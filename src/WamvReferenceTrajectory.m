function [Duration, ref] = WamvReferenceTrajectory(N, Ts, begin)
    load('usv_states.mat');
    
    
    % [x, y, z]
    ref(:,1) = usv_states(begin:end,1);
    ref(:,2) = usv_states(begin:end,2);
    ref(:,3) = usv_states(begin:end,3);
  
    
    % [phi, theta, psi]
    ref(:,4) = usv_states(begin:end,4);
    ref(:,5) = usv_states(begin:end,5);
    ref(:,6) = usv_states(begin:end,6);
    
    % [xdot, ydot, zdot]
    ref(:,7) = usv_states(begin:end,7);
    ref(:,8) = usv_states(begin:end,8);
    ref(:,9) = usv_states(begin:end,9);
    
    % [phidot, thetadot, psidot]
    ref(:,10) = usv_states(begin:end,10);
    ref(:,11) = usv_states(begin:end,11);
    ref(:,12) = usv_states(begin:end,12);
   
    Duration = Ts*(size(usv_states(begin:end,:), 1)-N);
%     t = 0:Ts:Duration;
    
end

