function x = my_ifft(X, t)

X = X(:);
t = t(:)';

K = length(X);
T = length(t);

XX = X*ones(1, T);
kk = (0:K-1)'*ones(1, T);
tt = ones(K, 1)*t;

tf = 2*pi*kk.*tt;
x = real(sum(XX.*exp(1i*tf)));