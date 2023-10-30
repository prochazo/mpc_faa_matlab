
M = diag([0.01 0.01 10 1 1 1 1 1 1 1 1 1 0 0 0 0]);              % weight on slack variables
L = 10*ones(1,16*N);       % missdesign of the slack variables 

G_out_soft = [
    Cdbar  -eye(size(Cdbar,1));
   -Cdbar   -eye(size(Cdbar,1));
    zeros(size(Cdbar,1),N*size(Btilde,2))      eye(size(Cdbar,1));
    zeros(size(Cdbar,1),N*size(Btilde,2))      -eye(size(Cdbar,1))
    ];

W_out_soft = [
    W_out_max;
    W_out_min;
    0.2*ones(1,size(Btilde,1)*N)';
    zeros(1,size(Btilde,1)*N)'
    ];

S_out_soft = [
    -Adhat;
    Adhat;
    zeros(size(Btilde,1),size(Btilde,1)*N)';
    zeros(size(Btilde,1),size(Btilde,1)*N)'
    ];

if use_soft_constraints
    mm = M;
    for i = 1:(N-1)
        M = blkdiag(M,mm);
    end
    H = blkdiag(H,M); 
end