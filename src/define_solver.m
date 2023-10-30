%% This script define which solver will be used

cd(fileparts(matlab.desktop.editor.getActiveFilename))
if isunix
    % in that case OSQP will be used
    addpath('/home/prochazo/Documents/MATLAB/osqp-matlab');
    
    mosqp = osqp;
    settings = mosqp.default_settings();
    settings.verbose = 0;
    settings.eps_abs = 1e-05;
    settings.eps_rel = 1e-05;
    settings.polish = 1;
    settings.check_termination = 10;
    settings.max_iter = 4000;
    % settings.warm_start = 1;
    % settings.time_limit = 0.018;

elseif ispc
    % in that case qpOASES will be used
    addpath 'C:\Users\mropr\Documents\git\qpOASES\interfaces\matlab'
    
    myOptions = qpOASES_options;
    myOptions.maxIter = 1000;
    myOptions.maxCpuTime = 0.1;
end