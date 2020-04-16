clear
f=50;
Fs=4000;
t=0:1/Fs:1-(1/Fs);

LPF=fft(sinc(2*f*t));
LPF=fftshift(LPF);

n=length(LPF);
plot(t,LPF)
