%% This script define UAV's model

%% initialization
syms xt(t) yt(t) zt(t) phit(t) thetat(t) psit(t) xdott(t) ydott(t)...
    zdott(t) phidott(t) thetadott(t) psidott(t) 
syms u1 u2 u3 u4 Ixx Iyy Izz k l m b g
syms x y z phi theta psi xdot ydot zdot phidot thetadot psidot

statet = {
    xt(t) yt(t) zt(t) phit(t) thetat(t) psit(t) xdott(t) ...
    ydott(t) zdott(t) phidott(t) thetadott(t) psidott(t)};
state = {
    x y z phi theta psi xdot ydot zdot phidot thetadot psidot};
    state_diff = {diff(xt(t),t), diff(yt(t),t), diff(zt(t),t), ...
    diff(phit(t),t), diff(thetat(t),t), diff(psit(t),t)};
state_dot = {
    xdot ydot zdot phidot thetadot psidot};
control = [
    u1, u2, u3, u4];

%% Prior information about the UAV
gVal = 9.81; % gravitation acceleration
mass = 3.5; % drone's weight in simulation
d = 0.325; % arm's length
lVal = d*cos(deg2rad(45));
kVal = 24.5; 
bVal = 0.7;

inertia_body_radius = 0.25; 
inertia_body_height = 0.15; %0.05;
rotor_mass = 0; % 0.005 % kg zatim tuto hmotnost zanedbam
motor_mass = 0.148; % kg
propeller_mass = 0.0202;

IxxVal = 2*((rotor_mass+motor_mass+propeller_mass)*lVal^2) + (mass - (rotor_mass+motor_mass+propeller_mass)) * (3 * inertia_body_radius * inertia_body_radius + inertia_body_height * inertia_body_height) / 12; 
IyyVal = 2*((rotor_mass+motor_mass+propeller_mass)*lVal^2) + (mass - (rotor_mass+motor_mass+propeller_mass)) * (3 * inertia_body_radius * inertia_body_radius + inertia_body_height * inertia_body_height) / 12;
IzzVal = 4*((rotor_mass+motor_mass+propeller_mass)*lVal^2) + (mass - (rotor_mass+motor_mass+propeller_mass)) * inertia_body_radius * inertia_body_radius / 2;

paramValues = [IxxVal IyyVal IzzVal kVal lVal mass bVal gVal];

%% Model definition
% transformation matrices
W = [1, 0, -sin(thetat);
    0, cos(phit), cos(thetat)*sin(phit);
    0, -sin(phit), cos(thetat)*cos(phit)];

Rz = [cos(psit), -sin(psit), 0;
    sin(psit), cos(psit), 0;
    0, 0, 1];
Ry = [cos(thetat), 0, sin(thetat);
    0, 1, 0;
    -sin(thetat), 0, cos(thetat)];
Rx = [1, 0, 0;
    0, cos(phit), -sin(phit);
    0, sin(phit), cos(phit)];

Rzyx = Rz*Ry*Rx;

% Jacobian
I = [Ixx, 0, 0; 0, Iyy, 0; 0, 0, Izz];
J = W.'*I*W;

% Coriolis forces
dJ_dt = diff(J);
dJ_dt = subs(dJ_dt,[state_diff statet],[state_dot state]);
h_dot_J = [phidott(t), thetadott(t), psidott(t)]*J;
h_dot_J = subs(h_dot_J,[state_diff statet],[state_dot state]);
grad_temp_h = jacobian(h_dot_J,[phi theta psi]);
C = dJ_dt - 1/2*grad_temp_h;

% Total thrust
T = k*(u1+u2+u3+u4);

% Torque
tau_beta = [l*k*(- u1 - u2 + u3 + u4); l*k*(- u1 - u4 + u2 + u3); b*(- u1 + u2 - u3 + u4)];

%% UAV's dynamics

f(1) = xdott;
f(2) = ydott;
f(3) = zdott;
f(4) = phidott;
f(5) = thetadott;
f(6) = psidott;
f(7:9) = -g*[0;0;1] + Rzyx*[0;0;T]/m;
f(10:12) = inv(J)*(tau_beta - C*[phidott(t); thetadott(t); psidott(t)]);

f = subs(f, [Ixx Iyy Izz k l m b g], paramValues);
f = subs(f,statet,state);
f = simplify(f);

%% Calculate linearization

% working point for linearization
u_work = 0.48*[1 1 1 1]; % minimum rotation^2 of the rotors to be in hover 
state_work = zeros(1,numel(state));

Ac = jacobian(f,[state{:}]);
Ac = subs(Ac, state,state_work);
Ac = double(subs(Ac, control,u_work));

Bc = jacobian(f,control);
Bc = subs(Bc, state,state_work);
Bc = double(subs(Bc, control,u_work));

Cc = diag(ones(1,12));
    
Dc = zeros(12,4);

sys=ss(Ac,Bc,Cc,Dc);

%% Discretization 
Ts = 0.1; 

model = c2d(sys,Ts);

% Extract the matrices of the discrete state-space description
A = model.A;
B = model.B;
C = model.C;

n = size(A,1); % number of states
m = size(B,2); % number of inputs
p = size(C,1); % number of outputs