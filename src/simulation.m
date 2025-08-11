
N_states = length(A);

x0 = zeros(n,1); 
% x0(1) = ref(1,1);
% x0(2) = ref(1,2);
% x0(3) = ref(1,3);

u0 = zeros(m,1); 
xtilde0 = [x0; u0];

x = zeros(n, numel(t));
y = zeros(p, numel(t));
u = zeros(m, numel(t));

x(:,1) = x0;
y(:,1) = C*x0;
uprev = u0;

if use_soft_constraints
    mosqp.setup(H/2+H'/2, [[x(1:N_states,i)' uprev' vec(ref(1:N, 1:N_states)')']*F, L], G, -inf*ones(size(W)), W+S*[x(:,i); uprev], settings);
else
    mosqp.setup(H/2+H'/2, [x(1:N_states,i)' uprev' vec(ref(1:N, 1:N_states)')']*F, G, -inf*ones(size(W)), W+S*[x(:,i); uprev], settings);
end

simEnd = inf;
touchdownMoment = 0;
for i = 1:(numel(t)-1)
    tic;
    % Reference signal over the current prediction window
    rk_raw = ref(i:i+N-1, 1:N_states)';
    
    rk = preprocessReference(rk_raw, x(:,i), Ts);
    
    if ispc
        % or by qpOASES ...
        [qp_res,fval,exitflag,iter,lambda,auxOutput] = qpOASES(H/2+H'/2, F'*[x(:,i)' uprev' rk(:)']', G, [], [], [], W+S*[x(:,i); uprev]);
    
    elseif isunix
        % or by OSQP
        if use_soft_constraints
            mosqp.update('q', [[x(1:N_states,i)' uprev' rk(:)']*F, L], 'u', W+S*[x(:,i); uprev]);
        else
            mosqp.update('q', [x(1:N_states,i)' uprev' rk(:)']*F, 'u', W+S*[x(:,i); uprev]);
        end
        results = mosqp.solve();
        qp_res = results.x;
    end
    
    % Extract the incement in u
    duk = qp_res(1:m,1);
    
    u(:,i) = uprev + duk;
    
    % Simulate the system using model of the UAV
    x(:,i+1) = A*x(:,i) + B*u(:,i);
    y(:,i+1) = C*x(:,i+1);
        
    uprev = u(:,i);
    
    if touchdownMoment == 0 && checkTouchdown(x(:,i+1), rk_raw) == true
        touchdownMoment = i+1;
    end
    if touchdownMoment ~= 0 && abs(touchdownMoment - i) > 3/Ts % let simulation run for 3 sec after touchdown
        simEnd = i;
        break
    end
    time_c(i) = toc;
    
end


