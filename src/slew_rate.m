ub = 0.1*ones(m*N,1);   % Upper bounds
lb = -0.1*ones(m*N,1);  % Lower bounds

G_in = [eye(N*4);-eye(N*4)];
W_in = [ub;-lb];
S_in = [zeros(N*m*2,n),[-repmat(zeros(m),N,1);repmat(zeros(m),N,1)]];
