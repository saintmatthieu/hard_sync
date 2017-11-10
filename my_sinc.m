function s = my_sinc(T_m, T_s, k_m, k_p)

omega_m = 2*pi*k_m/T_m;
omega_s = 2*pi*k_p/T_s;
s = 1./k_p.*sinc(omega_m - omega_s).*exp(1i*omega_s.*T_m/2);

