%DESIGN OF IIR FILTER...................................
%----------------------------------------------------------------------
%Index Number - 200552V
% A- First Digit of Index No
% B- Second Digit of Index No
% C- Third Digit of Index No

% Ap- Maximum Passband ripple in DB
% Aa- Minimum Stopband attenuation in DB
% digital_Wp1- Lowe Passband Edge  in hertz
% digital_Wp2- Upper Passband Edge in hertz
% digital_Ws1- Lower Stopband Edge  in hertz
% digital_Ws2- Upper Stopband edge  in hertz
% digital_Wsm -Sampling Frequency  in hertz
clear all,

A=5;
B=5;
C=2;
Ap= 0.1+(0.01*A);     Rp = Ap;
Aa= 50+B;             Rs = Aa;
Wsm= 2*(((C*100)+1500));

%Needed Digital Angluar Frequencies............................................
digital_Wp1= ((C*100)+400)/(2*pi);                     
digital_Wp2= ((C*100)+900)/(2*pi);              
digital_Ws1= ((C*100)+100)/(2*pi);              
digital_Ws2= ((C*100)+1100)/(2*pi);             

%Prewarping Analog Frequency for Respective Frequencies.
analog_Wp1  =  2*Wsm*tan(digital_Wp1*(2*pi/(Wsm/(2*pi)))/2);           
analog_Wp2  =  2*Wsm*tan(digital_Wp2*(2*pi/(Wsm/(2*pi)))/2);
analog_Ws1  =  2*Wsm*tan(digital_Ws1*(2*pi/(Wsm/(2*pi)))/2);
analog_Ws2  =  2*Wsm*tan(digital_Ws2*(2*pi/(Wsm/(2*pi)))/2);

[n,Ws] = cheb2ord([analog_Wp1 analog_Wp2],[analog_Ws1 analog_Ws2],Rp,Rs,'s');       % return minimum order and array of stopband angular freq
[b,a] = cheby2(n,Rs,[analog_Ws1 analog_Ws2],'bandpass','s');                        % for calculating analog filter cofficients
% disp(n);
[b1,a1] = bilinear(b,a,Wsm);                                                        % for the for converting analog filter cofficients to digital IIR.
disp(b1);
disp(a1);

%Code change only here....................

[H,f]=freqz(b1,a1,2048,Wsm);                       % computes the frequency, magnitude, and phase response of a digital filter
plot(f,db(H));                            % Normalized the frequency respect to nyquist sampling rate.
ylim([-70 10])
xlim([0 1700])
xlabel("Angular Frequency (w)");
ylabel("Magnitude (dB)");  
title('7th order Chebyshev Type II IIR Bandpass Filter')


