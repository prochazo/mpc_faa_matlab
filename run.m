% %% run script for mpc_faa landing method
% % @author: Ondřej Procházka

% clean workspace
close all
clear all

% setting latex formating
set(0,'defaulttextinterpreter','latex')
set(0,'DefaultAxesFontSize',1)

% Determine where your m-file's folder is.
 folder = fileparts(which(mfilename));  

% Add that folder plus all subfolders to the path.
addpath(genpath(folder));
clear folder

define_solver;

define_uav_model;

augment_model;

N = 15;
Q = diag([30 30 40 1 1 50 10 10 5 1 1 1]); % tracking weight matrix
P = diag([0 0 0 0 0 0 0 0 0 0 0 0]); % tracking weight matrix
R = 0.1*eye(4); % input increment weight matrix

umax = (1-0.35)*[1 1 1 1]';
umin = -0.35*[1 1 1 1]';

sequential_form_calculation;

hard_constraints;
use_soft_constraints = true;
soft_constraints;
use_slew_rate = false;
slew_rate;

if use_soft_constraints
    G = [G_out_soft];
    W = [W_out_soft];
    S = [S_out_soft];
else
    G = [G_out];
    W = [W_out];
    S = [S_out];
end

if use_slew_rate
    G = [G; G_in];
    W = [W; W_in];
    S = [S; S_in];
end


use_wamv_trajectory = true;
if use_wamv_trajectory == true
    data_file_name = 'usv_states.mat';
    TrajStart = 183; %245 defines begin of the referenced trajecotry which is loaded from real simulation dataset
    [Duration, ref] = WamvReferenceTrajectory(N, Ts, TrajStart, data_file_name);
    t = 0:Ts:Duration; % time vector
else
    Duration = 20; % Final time
    t = 0:Ts:Duration; % time vector
    ref = referenceTrajectory([t, Duration+Ts:Ts:Duration+(N*Ts)])';
end

simulation;

plotResult;