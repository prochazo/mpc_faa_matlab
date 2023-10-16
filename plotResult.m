% This script plots the closed-loop responses of the nonlinear MPC
% controller used in the quadrotor path following example.

% Copyright 2019 The MathWorks, Inc.

% Plot the closed-loop response.
time = 0:Ts:Duration;
if use_wamv_trajectory
    [~, yreftot] = WamvReferenceTrajectory(N, 0);
    yreftot = yreftot(1:end-N+1,:);
else
    yreftot = referenceTrajectory(time)';
end
set(0,'defaulttextinterpreter','latex')
set(0,'DefaultAxesFontSize',11)
set(0,'DefaultAxesFontSize',11)

%% Plot the states.
figure('Name','Position')

tiledlayout(3,1);

nexttile
hold on
plot(time,y(1,:)','LineWidth', 2)
plot(time,yreftot(:,1),'LineWidth', 2)
grid on
xlabel('time (s)')
ylabel('x (m)')
legend('actual','reference','Location','southeast','Interpreter','latex')
title('Qruadrotor x position')

nexttile
hold on
plot(time,y(2,:)','LineWidth', 2)
plot(time,yreftot(:,2),'LineWidth', 2)
grid on
xlabel('time (s)', 'FontSize', 11)
ylabel('y (m)', 'FontSize', 11)
legend('actual','reference','Location','southeast','Interpreter','latex')
title('Qruadrotor y position')

nexttile
hold on
plot(time,y(3,:)','LineWidth', 2)
plot(time,yreftot(:,3),'LineWidth', 2)
grid on
xlabel('time (s)', 'FontSize', 11)
ylabel('z (m)', 'FontSize', 11)
legend('actual','reference','Location','southeast','Interpreter','latex', 'FontSize', 11)
title('Qruadrotor z position', 'FontSize', 11)

sgtitle('Required position with the response', 'FontSize', 11) 

% -----------------------
figure('Name','Angles')

tiledlayout(3,1);
nexttile
hold on
plot(time,y(4,:)','LineWidth', 2)
plot(time,yreftot(:,4),'LineWidth', 2)
grid on
xlabel('time', 'FontSize', 11)
ylabel('phi', 'FontSize', 11)
legend('actual','reference','Location','southeast','Interpreter','latex', 'FontSize', 11)
title('Qruadrotor phi angle', 'FontSize', 11)

nexttile
hold on
plot(time,y(5,:)','LineWidth', 2)
plot(time,yreftot(:,5),'LineWidth', 2)
grid on
xlabel('time', 'FontSize', 11)
ylabel('theta', 'FontSize', 11)
legend('actual','reference','Location','southeast','Interpreter','latex', 'FontSize', 11)
title('Qruadrotor theta angle', 'FontSize', 11)

nexttile
hold on
plot(time,y(6,:)','LineWidth', 2)
plot(time,yreftot(:,6),'LineWidth', 2)
grid on
xlabel('time', 'FontSize', 11)
ylabel('psi', 'FontSize', 11)
legend('actual','reference','Location','southeast','Interpreter','latex', 'FontSize', 11)
title('Qruadrotor psi angle', 'FontSize', 11)

sgtitle('Required angular position with the response', 'FontSize', 11) 

% ----------------------
figure('Name','Horizontal velocity')

tiledlayout(3,1);

nexttile
hold on
plot(time,y(7,:)','LineWidth', 2)
plot(time,yreftot(:,7),'LineWidth', 2)
grid on
xlabel('time (s)','FontSize', 11)
ylabel('$v_x$ (m/s)','FontSize', 11)
legend('performed','reference','Location','southeast','Interpreter','latex', 'FontSize', 11)
title("Quadrotor's linear velocity in x-axis",'FontSize', 11)

nexttile
hold on
plot(time,y(8,:)','LineWidth', 2)
plot(time,yreftot(:,8),'LineWidth', 2)
grid on
xlabel('time (s)','FontSize', 11)
ylabel('$v_y$ (m/s)','FontSize', 11)
legend('performed','reference','Location','southeast','Interpreter','latex','FontSize', 11)
title("Quadrotor's linear velocity in y-axis",'FontSize', 11)

nexttile
hold on
plot(time,sqrt(y(8,:)'.^2+y(7,:)'.^2),'LineWidth', 2)
grid on
xlabel('time (s)','FontSize', 11)
ylabel('$v_h$ (m/s)','FontSize', 11)
legend('performed','Location','southeast','Interpreter','latex','FontSize', 11)
title("Quadrotor's horizontal velocity",'FontSize', 11)

% nexttile
% hold on
% plot(time,y(9,:)')
% plot(time,yreftot(:,9))
% grid on
% xlabel('time (s)')
% ylabel('$v_z$ (m/s)')
% legend('actual','reference','Location','southeast','Interpreter','latex')
% title("Quadrotor's vertical velocity")

sgtitle('Horizontal velocities','FontSize', 15) 

% ----------------------
figure('Name','Vertical velocity')

hold on
plot(time,y(9,:)','LineWidth', 2)
plot(time,yreftot(:,9),'LineWidth', 2)
grid on
xlabel('time (s)','FontSize', 11)
ylabel('$v_z$ (m/s)','FontSize', 11)
legend('actual','reference','Location','southeast','Interpreter','latex','FontSize', 11)
title("Quadrotor's vertical velocity")

% sgtitle('Horizontal velocities','FontSize', 15) 
%% Plot the manipulated variables.
figure('Name','Control Inputs')

subplot(2,2,1)
hold on
stairs(time,u(1,:),'LineWidth', 2)
grid on
xlabel('time (s)','FontSize', 11)
% legend('Upward force')
title('$\omega_1^2$')

subplot(2,2,2)
hold on
stairs(time,u(2,:),'LineWidth', 2)
grid on
xlabel('time (s)' ,'FontSize', 11)
title('Input 2' ,'FontSize', 11)
title('$\omega_2^2$' ,'FontSize', 11)

subplot(2,2,3)
hold on
stairs(time,u(3,:),'LineWidth', 2)
grid on
xlabel('time (s)','FontSize', 11)
title('Input 3','FontSize', 11)
title('$\omega_3^2$','FontSize', 11)

subplot(2,2,4)
hold on
stairs(time,u(4,:),'LineWidth', 2)
grid on
xlabel('time (s)','FontSize', 11)
title('$\omega_4^2$','FontSize', 11)

sgtitle('Required angular squared velocities','FontSize', 11) 
% 
%% Plot the manipulated variables recomputed to the RPM.

omega_max = 921735.7777;


figure('Name','Control Inputs')

subplot(2,2,1)
hold on
stairs(time,sqrt(omega_max*u(1,:))/(2*pi)*60,'LineWidth', 2)
% plot(time,nloptions.MVTarget(2)*ones(1,length(time)))
grid on
xlabel('time (s)','FontSize', 11)
ylabel('RPM','FontSize', 11)
% legend('actual','reference')
title('Input 1','FontSize', 11)

subplot(2,2,2)
hold on
stairs(time,sqrt(omega_max*u(2,:))/(2*pi)*60,'LineWidth', 2)
% ylim([-0.5,12.5])
% plot(time,nloptions.MVTarget(2)*ones(1,length(time)))
grid on
xlabel('time (s)','FontSize', 11)
ylabel('RPM','FontSize', 11)
title('Input 2','FontSize', 11)
% legend('actual','reference')

subplot(2,2,3)
hold on
stairs(time,sqrt(omega_max*u(3,:))/(2*pi)*60,'LineWidth', 2)
% ylim([-0.5,12.5])
% plot(time,nloptions.MVTarget(2)*ones(1,length(time)))
grid on
xlabel('time (s)','FontSize', 11)
ylabel('RPM','FontSize', 11)
title('Input 3','FontSize', 11)
% legend('actual','reference')

subplot(2,2,4)
hold on
stairs(time,sqrt(omega_max*u(4,:))/(2*pi)*60,'LineWidth', 2)
% ylim([-0.5,12.5])
% plot(time,nloptions.MVTarget(2)*ones(1,length(time)))
grid on
xlabel('time (s)','FontSize', 11)
ylabel('RPM','FontSize', 11)
title('Input 4','FontSize', 11)
% legend('actual','reference')

sgtitle('Inputs recomputed to the required RPMs','FontSize', 11) 