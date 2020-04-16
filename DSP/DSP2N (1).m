N=2;                                    %% Order of the filter required
n=[0.3 0.5];                              %% For odd-harmonics n=zeros(1,N); for i=1:N (n(i)=2*(i-1)+1;)

Fs=5000;
w=0:(1/Fs):(pi-(1/Fs));


Z= exp(1j*w);
                   
BW=[ (0.1*pi) (0.15*pi)];             %% 3dB bandwidth limits of each notch

%% Defining notch frequencies
W0 = n*pi;
%% Defining K2i array 

K2=sec(BW)-tan(BW); 

Constant = zeros(N,1);
Coeff    = ones(N);

for i=1:N
    Constant(i,1) = -2*cos(2*W0(i));
end

for i=2:N
    for j=1:N
        Coeff(i,j)= (2)*cos((i-1)*W0(j));
    end
end

Beta = ((Coeff')\Constant);
fun=@(x)fun2N(x,K2,Beta);
 x0=[0,0];
 K1=fsolve(fun,x0);

A2N_z=ones(1,length(Z));
for i=1:N
    A2N_z = A2N_z.*(((K2(i)*ones(1,length(Z)))+(K1(i)*(1+K2(i))*(Z.^(-1))+(Z.^(-2)))));
    A2N_z = A2N_z./(ones(1,length(Z))+(K1(i)*(1+K2(i))*(Z.^(-1))+((K2(i))*Z.^(-2))));
end
H_z=0.5*(1+A2N_z);
figure(1)
plot((w/pi),abs(H_z));
ylabel('|H(z)|');
xlabel('w/pi');
title('Amplitude Response of multi notch filter with N=2');
grid on

figure(2)
plot(w/pi,unwrap(angle(A2N_z)));
ylabel('Phase Angle');
xlabel('w/pi');
title('Phase Response of all-pass Multi Notch Filter with N=2');
grid on

figure(3)
plot(w/pi,unwrap(angle(H_z)));
ylabel('Phase Angle');
xlabel('w/pi');
title('Phase response of Multi Notch Filter with N=2');
grid on

