%DESIGN OF FIR FILTER...................................
%----------------------------------------------------------------------
%Index Number - 200552V
% A- First Digit of Index No.
% B- Second Digit of Index No.
% C- Third Digit of Index No.
% Ap- Maximum Passband ripple in DB
% Aa- Minimum Stopband attenuation in DB
% digital_Wp1- Lowe Passband Edge in hertz
% digital_Wp2- Upper Passband Edge in hertz
% digital_Ws1- Lower Stopband Edge in hertz
% digital_Ws2- Upper Stopband edge in hertz
% digital_Wsm -Sampling Frequency in hertz
clear all,
A=5;
B=5;
C=2;
Ap= 0.1+(0.01*A); Rp = Ap;
Aa= 50+B; Rs = Aa;
Wsm= 2*(((C*100)+1500));
Analog_Wp1= ((C*100)+400); 
Analog_Wp2= ((C*100)+900); 
Analog_Ws1= ((C*100)+100); 
Analog_Ws2= ((C*100)+1100); 
fcuts = [Analog_Ws1 Analog_Wp1 Analog_Wp2 Analog_Ws2]; %setting bandfrequencies (stop and passbands)
mags = [0 1 0]; 
devs = [10^(-Rs/20) 10^(-Rp/20) 10^(-Rs/20)]; % converstion of decible attenuation.
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,Wsm); %to computes the order of an FIR filter and the independent parameter to a Kaiser window 
n = n + rem(n,2); 
hh = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale'); %to calculates the coefficients of FIR filters designed using the windowing method
[h,f]=freqz(hh,1,1024,Wsm); % computes the frequency, magnitude, and phase response of a digital filter 
%Code change only here....................
plot(f,db(h))
ylim([-75 10])
xlim([0 1700])
xlabel("Angular Frequency (w)");
ylabel('Magnitute (DB)')
title('56th order FIR Bandpass Filter')
% impz(hh); %impulse response of the filter..
disp(hh);