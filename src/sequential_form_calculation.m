[r, c] = size(Btilde);
ps = zeros(r*N,c);
for i=1:N
    ps(1+(i-1)*r:i*r,:) = Atilde^(i-1)*Btilde;
end
[~, c] = size(ps);

% C double bar
Cdbar = zeros(N*r,N*c);
for i = 0:(N-1)
    Cdbar(:,1+c*i:m+c*i) = [zeros(i*r,m);ps(1:end-i*r,:)];
end
[r, c] = size(Atilde);

% A double hat
Adhat = zeros(r*N,c);
for i = 1:N
    Adhat((i-1)*r+1:(i)*r,:)=Atilde^i;
end

RCell = repmat({R}, 1, N);
TCell = repmat({Q*Ctilde}, 1, N-1);
QCell = repmat({Ctilde'*Q*Ctilde}, 1, N-1);

Rdbar = blkdiag(RCell{:});
Qdbar = blkdiag(QCell{:},Ctilde'*P*Ctilde);
Tdbar = blkdiag(TCell{:},P*Ctilde);

H = Cdbar.' * Qdbar * Cdbar + Rdbar;
F = [(Adhat.' * Qdbar * Cdbar); -Tdbar * Cdbar];