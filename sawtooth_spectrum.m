function [S, sincs] = sawtooth_spectrum(T_m, T_s, k_m, k_p)

k = ones(length(k_p), 1)*k_m(:)';
p = k_p(:)*ones(1, length(k_m));

% omega_m = 2*pi*k/T_m;
% omega_s = 2*pi*p/T_s;
sincs = 1./p.*sinc(p*T_m/T_s - k).*exp(1i*p*pi*T_m/T_s);
S = -2i/pi*(-1).^k_m.*sum(sincs);
