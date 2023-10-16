LMPC Matlab
==========

This project includes MATLAB live scritp with the explanantion how to model UAV in 6DOF. This model is then discretized and linearized. Such a model is used as an internal model for Model Predictive Control in a form of reference tracking. 


Matlab toolboxes
---------------
- Control System Toolbox                                Version 10.10       (R2021a)
- DSP System Toolbox                                    Version 9.12        (R2021a)
- Model Predictive Control Toolbox                      Version 7.1         (R2021a)
- Optimization Toolbox                                  Version 9.1         (R2021a)
- Signal Processing Toolbox                             Version 8.6         (R2021a)
- Statistics and Machine Learning Toolbox               Version 12.1        (R2021a)
- Symbolic Math Toolbox                                 Version 8.7         (R2021a)


Quadratic solvers
----------------

### OSQP
To install matlab version of the OSQP run following commands into the MATLAB command window
```
!git clone --recurse-submodules https://github.com/osqp/osqp-matlab
cd osqp-matlab
make_osqp
```

### qpOASES


### MATLAB's quadprog
