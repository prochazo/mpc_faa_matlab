function [ xdesired ] = UAVReferenceTrajectory(t)
% This function generates reference signal for nonlinear MPC controller

%#codegen
x = 3*sin(t/3);
% x = 1*t/3;
y = -2*sin(t/3).*cos(t/3);
% y = 6 * sin(pi*t/3);
z = 6*cos(t/3);
% z = 6*cos(pi*t/3);
phi = zeros(1,length(t));
theta = zeros(1,length(t));
psi = zeros(1,length(t));
% psi = 6*cos(t/3);
xdot = zeros(1,length(t));
ydot = zeros(1,length(t));
zdot = zeros(1,length(t));
phidot = zeros(1,length(t));
thetadot = zeros(1,length(t));
psidot = zeros(1,length(t));

% x = 3*ones(1,length(t));
% y = 0*ones(1,length(t));
% z = 0*ones(1,length(t));
% phi = zeros(1,length(t));
% theta = zeros(1,length(t));
% psi = zeros(1,length(t));
% xdot = zeros(1,length(t));
% ydot = zeros(1,length(t));
% zdot = zeros(1,length(t));
% phidot = zeros(1,length(t));
% thetadot = zeros(1,length(t));
% psidot = zeros(1,length(t));

%% x-y penalisation test
% x = 5*ones(1,length(t));
% y = 5*ones(1,length(t));
% z = 0*ones(1,length(t));
% phi = zeros(1,length(t));
% theta = zeros(1,length(t));
% psi = zeros(1,length(t));
% xdot = zeros(1,length(t));
% ydot = zeros(1,length(t));
% zdot = zeros(1,length(t));
% phidot = zeros(1,length(t));
% thetadot = zeros(1,length(t));
% psidot = zeros(1,length(t));

xdesired = [x;y;z;phi;theta;psi;xdot;ydot;zdot;phidot;thetadot;psidot];
% xdesired=[x;y;z];
end
