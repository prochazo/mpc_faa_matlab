%% Plot the closed-loop response simulation with and without my approvement
% the script is just tmp because the yy = y, which is the response from the
% previus run which includes my upgrades


time = 0:Ts:Duration;
if use_wamv_trajectory
    [~, yreftot] = WamvReferenceTrajectory(N, Ts, TrajStart, data_file_name);
    yreftot = yreftot(1:simEnd-N+1,:);
    time = time(1:size(yreftot, 1));
    y = y(:, 1:size(yreftot, 1));
    yy = yy(:, 1:size(yreftot, 1));
    u = u(:, 1:size(yreftot, 1));
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
plot(time,yreftot(:,1), ':r', 'LineWidth', 2)
plot(time,y(1,:)', 'c', 'LineWidth', 2)
p = plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,1)), min(y(1,:))), max(max(yreftot(:,1)), max(y(1,:)))]);
p.Annotation.LegendInformation.IconDisplayStyle = 'off';
plot(time,yy(1,:)', ':b', 'LineWidth', 2)
grid on
xlabel('time (s)', 'FontSize', 11)
ylabel('x (m)', 'FontSize', 11)
legend('reference', 'MPC', 'MPC-FAA','Location','southeast','Interpreter','latex', 'FontSize', 11)
% title('x position')
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,1)), min(y(1,:))), max(max(yreftot(:,1)), max(y(1,:)))])

nexttile
hold on
plot(time,yreftot(:,2), ':r', 'LineWidth', 2)
plot(time,y(2,:)', 'c', 'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,2)), min(y(2,:))), max(max(yreftot(:,2)), max(y(2,:)))]);
plot(time,yy(2,:)', ':b', 'LineWidth', 2)
grid on
xlabel('time (s)', 'FontSize', 11)
ylabel('y (m)', 'FontSize', 11)
% legend('response','reference','Location','southeast','Interpreter','latex')
% title('y position')
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,2)), min(y(2,:))), max(max(yreftot(:,2)), max(y(2,:)))])

nexttile
hold on
plot(time,yreftot(:,3), ':r', 'LineWidth', 2)
plot(time,y(3,:)', 'c', 'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,3)), min(y(3,:))), max(max(yreftot(:,3)), max(y(3,:)))]);
plot(time,yy(3,:)', ':b', 'LineWidth', 2)
grid on
xlabel('time (s)', 'FontSize', 11)
ylabel('z (m)', 'FontSize', 11)
% legend('response','reference','Location','southeast','Interpreter','latex', 'FontSize', 11)
% title('z position', 'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,3)), min(y(3,:))), max(max(yreftot(:,3)), max(y(3,:)))])

% sgtitle('Required position with the response', 'FontSize', 11) 

%% -----------------------
figure('Name','Angles')

tiledlayout(3,1);
nexttile
hold on
plot(time,yreftot(:,4), ':r', 'LineWidth', 2)
plot(time,y(4,:)', 'c', 'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,4)), min(y(4,:))), max(max(yreftot(:,4)), max(y(4,:)))]);
plot(time,yy(4,:)', ':b', 'LineWidth', 2)
grid on
xlabel('time (s)', 'FontSize', 11)
ylabel('roll angle (rad)', 'FontSize', 11)
% legend('performed','reference','Location','southeast','Interpreter','latex', 'FontSize', 11)
% title('roll', 'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,4)), min(y(4,:))), max(max(yreftot(:,4)), max(y(4,:)))])

nexttile
hold on
plot(time,yreftot(:,5), ':r', 'LineWidth', 2)
plot(time,y(5,:)', 'c', 'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,5)), min(y(5,:))), max(max(yreftot(:,5)), max(y(5,:)))]);
plot(time,yy(5,:)', ':b', 'LineWidth', 2)
grid on
xlabel('time (s)', 'FontSize', 11)
ylabel('pitch angle (rad)', 'FontSize', 11)
% legend('performed','reference','Location','southeast','Interpreter','latex', 'FontSize', 11)
% title('pitch', 'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,5)), min(y(5,:))), max(max(yreftot(:,5)), max(y(5,:)))])

nexttile
hold on
plot(time,yreftot(:,6), ':r', 'LineWidth', 2)
plot(time,y(6,:)', 'c', 'LineWidth', 2)
p = plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,6)), min(y(6,:))), max(max(yreftot(:,6)), max(y(6,:)))]);
p.Annotation.LegendInformation.IconDisplayStyle = 'off';
plot(time,yy(6,:)', ':b', 'LineWidth', 2)
grid on
xlabel('time (s)', 'FontSize', 11)
ylabel('yaw angle (rad)', 'FontSize', 11)
legend('reference', 'MPC', 'MPC-FAA','Location','southeast','Interpreter','latex', 'FontSize', 11)
% title('yaw', 'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,6)), min(y(6,:))), max(max(yreftot(:,6)), max(y(6,:)))])

% sgtitle('Required angular position with the response', 'FontSize', 11) 

%% ----------------------
figure('Name','Horizontal velocity')

tiledlayout(3,1);

nexttile
hold on
plot(time,yreftot(:,7), ':r', 'LineWidth', 2)
plot(time,y(7,:)','LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,7)), min(y(7,:))), max(max(yreftot(:,7)), max(y(7,:)))]);
grid on
xlabel('time (s)','FontSize', 11)
ylabel('velocity (m/s)','FontSize', 11)
legend('reference','MPC','Location','southeast','Interpreter','latex', 'FontSize', 11)
title("Quadrotor's linear velocity in x-axis",'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,7)), min(y(7,:))), max(max(yreftot(:,7)), max(y(7,:)))])

nexttile
hold on
plot(time,yreftot(:,8), ':r', 'LineWidth', 2)
plot(time,y(8,:)','LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,8)), min(y(8,:))), max(max(yreftot(:,8)), max(y(8,:)))]);
grid on
xlabel('time (s)','FontSize', 11)
ylabel('velocity (m/s)','FontSize', 11)
% legend('reference','performed','Location','southeast','Interpreter','latex','FontSize', 11)
title("Quadrotor's linear velocity in y-axis",'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,8)), min(y(8,:))), max(max(yreftot(:,8)), max(y(8,:)))])

% nexttile
% hold on
% plot(time,sqrt(y(8,:)'.^2+y(7,:)'.^2),'LineWidth', 2)
% grid on
% xlabel('time (s)','FontSize', 11)
% ylabel('velocity (m/s)','FontSize', 11)
% legend('Location','performed','southeast','Interpreter','latex','FontSize', 11)
% title("Quadrotor's horizontal velocity",'FontSize', 11)

nexttile
hold on
plot(time,yreftot(:,9), ':r', 'LineWidth', 2)
plot(time,y(9,:)','LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,9)), min(y(9,:))), max(max(yreftot(:,9)), max(y(9,:)))]);
grid on
xlabel('time (s)')
ylabel('velocity (m/s)')
% legend('reference','response','Location','southeast','Interpreter','latex')
title("Quadrotor's linear velocity in z-axis",'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,9)), min(y(9,:))), max(max(yreftot(:,9)), max(y(9,:)))])

% sgtitle('Horizontal velocities','FontSize', 15) 

%% ----------------------
figure('Name','Vertical velocity')

hold on
plot(time,yreftot(:,9), ':r', 'LineWidth', 2)
plot(time,y(9,:)','LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,9)), min(y(9,:))), max(max(yreftot(:,9)), max(y(9,:)))]);
grid on
xlabel('time (s)','FontSize', 11)
ylabel('$v_z$ (m/s)','FontSize', 11)
legend('reference','MPC','Location','southeast','Interpreter','latex','FontSize', 11)
title("Quadrotor's vertical velocity")
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,9)), min(y(9,:))), max(max(yreftot(:,9)), max(y(9,:)))])

%% ----------------------
figure('Name','Euler rates')

tiledlayout(3,1);

nexttile
hold on
plot(time,yreftot(:,10),'LineWidth', 2)
plot(time,y(10,:)','LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,10)), min(y(10,:))), max(max(yreftot(:,10)), max(y(10,:)))]);
grid on
xlabel('time (s)','FontSize', 11)
ylabel('rate (rad/s)','FontSize', 11)
legend('reference','MPC','Location','southeast','Interpreter','latex', 'FontSize', 11)
title("Quadrotor's roll rate",'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,10)), min(y(10,:))), max(max(yreftot(:,10)), max(y(10,:)))])

nexttile
hold on
plot(time,y(11,:)','LineWidth', 2)
plot(time,yreftot(:,11),'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,11)), min(y(11,:))), max(max(yreftot(:,11)), max(y(11,:)))]);
grid on
xlabel('time (s)','FontSize', 11)
ylabel('rate (rad/s)','FontSize', 11)
% legend('performed','reference','Location','southeast','Interpreter','latex','FontSize', 11)
title("Quadrotor's pitch rate",'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,11)), min(y(11,:))), max(max(yreftot(:,11)), max(y(11,:)))])

nexttile
hold on
plot(time,y(12,:)','LineWidth', 2)
plot(time,yreftot(:,12),'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(min(yreftot(:,12)), min(y(12,:))), max(max(yreftot(:,12)), max(y(12,:)))]);
grid on
xlabel('time (s)','FontSize', 11)
ylabel('rate (rad/s)','FontSize', 11)
% legend('performed','reference','Location','southeast','Interpreter','latex','FontSize', 11)
title("Quadrotor's yaw rate",'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(min(yreftot(:,12)), min(y(12,:))), max(max(yreftot(:,12)), max(y(12,:)))])
%% Plot the manipulated variables.
figure('Name','Control Inputs')

subplot(2,2,1)
hold on
stairs(time,u(1,:),'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(u(1,:)), max(u(1,:))]);
grid on
xlabel('time (s)','FontSize', 11)
% legend('Upward force')
title('$\omega_1^2$')
xlim([0, time(touchdownMoment)+0.1])
ylim([min(u(1,:)), max(u(1,:))])

subplot(2,2,2)
hold on
stairs(time,u(2,:),'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(u(2,:)), max(u(2,:))]);
grid on
xlabel('time (s)' ,'FontSize', 11)
title('Input 2' ,'FontSize', 11)
title('$\omega_2^2$' ,'FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(u(2,:)), max(u(2,:))])

subplot(2,2,3)
hold on
stairs(time,u(3,:),'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(u(3,:)), max(u(3,:))]);
grid on
xlabel('time (s)','FontSize', 11)
title('Input 3','FontSize', 11)
title('$\omega_3^2$','FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(u(3,:)), max(u(3,:))])

subplot(2,2,4)
hold on
stairs(time,u(4,:),'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(u(4,:)), max(u(4,:))]);
grid on
xlabel('time (s)','FontSize', 11)
title('$\omega_4^2$','FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(u(4,:)), max(u(4,:))])

sgtitle('Required angular squared velocities','FontSize', 11) 
% 
%% Plot the manipulated variables recomputed to the RPM.

omega_max = 921735.7777;


figure('Name','Control Inputs')

subplot(2,2,1)
hold on
stairs(time,sqrt(omega_max*u(1,:))/(2*pi)*60,'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(sqrt(omega_max*u(1,:))/(2*pi)*60), max(sqrt(omega_max*u(1,:))/(2*pi)*60)]);
grid on
xlabel('time (s)','FontSize', 11)
ylabel('RPM','FontSize', 11)
% legend('response','reference')
title('Input 1','FontSize', 11)
xlim([0, time(touchdownMoment)+0.1])
ylim([min(sqrt(omega_max*u(1,:))/(2*pi)*60), max(sqrt(omega_max*u(1,:))/(2*pi)*60)])

subplot(2,2,2)
hold on
stairs(time,sqrt(omega_max*u(2,:))/(2*pi)*60,'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(sqrt(omega_max*u(2,:))/(2*pi)*60), max(sqrt(omega_max*u(2,:))/(2*pi)*60)]);
% ylim([-0.5,12.5])
% plot(time,nloptions.MVTarget(2)*ones(1,length(time)))
grid on
xlabel('time (s)','FontSize', 11)
ylabel('RPM','FontSize', 11)
title('Input 2','FontSize', 11)
% legend('response','reference')
xlim([0, time(touchdownMoment)+0.1])
ylim([min(sqrt(omega_max*u(2,:))/(2*pi)*60), max(sqrt(omega_max*u(2,:))/(2*pi)*60)])

subplot(2,2,3)
hold on
stairs(time,sqrt(omega_max*u(3,:))/(2*pi)*60,'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(sqrt(omega_max*u(3,:))/(2*pi)*60), max(sqrt(omega_max*u(3,:))/(2*pi)*60)]);
% ylim([-0.5,12.5])
% plot(time,nloptions.MVTarget(2)*ones(1,length(time)))
grid on
xlabel('time (s)','FontSize', 11)
ylabel('RPM','FontSize', 11)
title('Input 3','FontSize', 11)
% legend('response','reference')
xlim([0, time(touchdownMoment)+0.1])
ylim([min(sqrt(omega_max*u(3,:))/(2*pi)*60), max(sqrt(omega_max*u(3,:))/(2*pi)*60)])

subplot(2,2,4)
hold on
stairs(time,sqrt(omega_max*u(4,:))/(2*pi)*60,'LineWidth', 2)
plot([time(touchdownMoment), time(touchdownMoment)], [min(sqrt(omega_max*u(4,:))/(2*pi)*60), max(sqrt(omega_max*u(4,:))/(2*pi)*60)]);
% ylim([-0.5,12.5])
% plot(time,nloptions.MVTarget(2)*ones(1,length(time)))
grid on
xlabel('time (s)','FontSize', 11)
ylabel('RPM','FontSize', 11)
title('Input 4','FontSize', 11)
% legend('response','reference')
xlim([0, time(touchdownMoment)+0.1])
ylim([min(sqrt(omega_max*u(4,:))/(2*pi)*60), max(sqrt(omega_max*u(4,:))/(2*pi)*60)])

sgtitle('Inputs recomputed to the required RPMs','FontSize', 11) 