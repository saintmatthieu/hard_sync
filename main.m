clear all, close all

frequency_master = 100;
num_periods = 1;
prime_number = 1;

ratio_numerator = 7;
ratio_denominator = 2;
overwrite_wav = false;

%%%%%%%%%%%%%%%%%%%%%%

frequency_ratio = ratio_numerator / ratio_denominator;
f_m = frequency_master;
f_s = f_m*frequency_ratio;
T_s = 1/f_s;
T_m = 1/f_m;

K = 100;
k = (0:K-1);

duration = 1;
sr = 32000;
N = duration * sr;
n = (0:N-1);
t = duration*n/N;

P = K;
p = (-P:P)';
p = p(p ~= 0);

SAWTOOTH = sawtooth_spectrum(T_m, T_s, k, p);
sawtooth = my_ifft(SAWTOOTH, t/T_m);

subplot(211)
stem(k, abs(SAWTOOTH)), grid, hold on
xlabel('harmonic index')
ylabel('power')
subplot(212)
plot(t, sawtooth), grid
set(gca, 'xlim', [0, 3*T_m])
xlabel('time (s)')

filename = ['wav/sawtooth_' num2str(ratio_numerator) '_' num2str(ratio_denominator) '_@' num2str(frequency_master) 'Hz.wav'];
if overwrite_wav || ~exist(filename)
    wavwrite(sawtooth/2, sr, filename)
end