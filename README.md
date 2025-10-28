MPC_FAA MATLAB
==========

This project includes a MATLAB live script with an explanation of how to model a UAV in 6DOF. 
This model is then discretized and linearized. Such a model is used as an internal model for Model Predictive Control in the form of reference tracking. 

## Citing
If you use this code in an academic context, please cite the following publication:

Ondřej Procházka, Filip Novák, Tomáš Báča, Parakh M Gupta, Robert Pěnička, Martin Saska, "Model predictive control-based trajectory generation for agile landing of unmanned aerial vehicle on a moving boat," Ocean Engineering 313:119164, 2024. ([PDF](https://www.sciencedirect.com/science/article/pii/S0029801824025022))

```
@article{prochazka2024model,
  title={Model predictive control-based trajectory generation for agile landing of unmanned aerial vehicle on a moving boat},
  author={Proch{\'a}zka, Ond{\v{r}}ej and Nov{\'a}k, Filip and B{\'a}{\v{c}}a, Tom{\'a}{\v{s}} and Gupta, Parakh M and P{\v{e}}ni{\v{c}}ka, Robert and Saska, Martin},
  journal={Ocean Engineering},
  volume={313},
  pages={119164},
  year={2024},
  publisher={Elsevier}
}

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
