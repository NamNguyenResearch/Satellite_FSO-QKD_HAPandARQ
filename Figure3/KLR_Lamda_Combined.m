clear;
clc;

%Parameters Simulation
global Rb;               %Bit rate (bps)
global P_LO_dBm;         %Power of Local Oscillator (dBm)
global lamda_wavelength; %Wavelength (m)
global v_wind;           %Wind speed (m/s)
global H_S;              %Satellite altitude (m)
global H_G;              %Ground station height (m)
global H_a;              %Amospheric altitude (m)
global l_k;              %Length of bit string (in bits)
global zenithAng_Do

Rb=10*10^9;
P_LO_dBm=0;
lamda_wavelength=1550*10^-9;
v_wind=21;
H_S=600*10^3;
H_G=5;   
H_a=20*10^3;
l_k=5*10^7; 
zenithAng_Do=50;

C2n_Weak=5*10^-15;       %Refractive index structure coefficient
C2n_Strong=7*10^-12; 

MArray=[1,2,3,4,5,6,7,8];%Maximum number of transmissions
B=10;                    %BS buffer size
Attenuation=0.43;
P_T_dBm=7;

%(a) Conventional System
ScaleCo_Weak_Conventional=0.7;
ScaleCo_Strong_Conventional=1.4;

%(b) Proposed system
ScaleCo_SH=0.4;
ScaleCo_Weak_HG=0.7;
ScaleCo_Strong_HG=1.4;

lamda=0:10:200;

%Calculate Key loss rate
%(a) Conventional System
%Weak turbulence
QBER_Weak_Conventional=zeros(1,length(lamda));
P_sift_Weak_Conventional=zeros(1,length(lamda));

keyLossRate1_Weak_Conventional=zeros(1,length(lamda));
keyLossRate2_Weak_Conventional=zeros(1,length(lamda));
keyLossRate3_Weak_Conventional=zeros(1,length(lamda));
keyLossRate4_Weak_Conventional=zeros(1,length(lamda));
keyLossRate5_Weak_Conventional=zeros(1,length(lamda));
keyLossRate6_Weak_Conventional=zeros(1,length(lamda));
keyLossRate7_Weak_Conventional=zeros(1,length(lamda));
keyLossRate8_Weak_Conventional=zeros(1,length(lamda));

%Strong turbulence
QBER_Strong_Conventional=zeros(1,length(lamda));
P_sift_Strong_Conventional=zeros(1,length(lamda));

keyLossRate1_Strong_Conventional=zeros(1,length(lamda));
keyLossRate2_Strong_Conventional=zeros(1,length(lamda));
keyLossRate3_Strong_Conventional=zeros(1,length(lamda));
keyLossRate4_Strong_Conventional=zeros(1,length(lamda));
keyLossRate5_Strong_Conventional=zeros(1,length(lamda));
keyLossRate6_Strong_Conventional=zeros(1,length(lamda));
keyLossRate7_Strong_Conventional=zeros(1,length(lamda));
keyLossRate8_Strong_Conventional=zeros(1,length(lamda));

%(b) Proposed system
%Satellite to HAP
QBER_SH=zeros(1,length(lamda));
P_sift_SH=zeros(1,length(lamda));

%HAP to Ground Station
%Weak turbulence
QBER_Weak_HG=zeros(1,length(lamda));
P_sift_Weak_HG=zeros(1,length(lamda));

keyLossRate1_Weak_HG=zeros(1,length(lamda));
keyLossRate2_Weak_HG=zeros(1,length(lamda));
keyLossRate3_Weak_HG=zeros(1,length(lamda));
keyLossRate4_Weak_HG=zeros(1,length(lamda));
keyLossRate5_Weak_HG=zeros(1,length(lamda));
keyLossRate6_Weak_HG=zeros(1,length(lamda));
keyLossRate7_Weak_HG=zeros(1,length(lamda));
keyLossRate8_Weak_HG=zeros(1,length(lamda));

%Strong turbulence
QBER_Strong_HG=zeros(1,length(lamda));
P_sift_Strong_HG=zeros(1,length(lamda));

keyLossRate1_Strong_HG=zeros(1,length(lamda));
keyLossRate2_Strong_HG=zeros(1,length(lamda));
keyLossRate3_Strong_HG=zeros(1,length(lamda));
keyLossRate4_Strong_HG=zeros(1,length(lamda));
keyLossRate5_Strong_HG=zeros(1,length(lamda));
keyLossRate6_Strong_HG=zeros(1,length(lamda));
keyLossRate7_Strong_HG=zeros(1,length(lamda));
keyLossRate8_Strong_HG=zeros(1,length(lamda));

for i=1:length(lamda)
    %(a) Conventional System
    %Weak turbulence
    [QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i)]=calculateQBER_QPSK_Gamma_Conventional(Attenuation,ScaleCo_Weak_Conventional,P_T_dBm,C2n_Weak);
    
    keyLossRate1_Weak_Conventional(i)=calculateKeyLossRate_Conventional(MArray(1),B,QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda(i));
    keyLossRate2_Weak_Conventional(i)=calculateKeyLossRate_Conventional(MArray(2),B,QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda(i));
    keyLossRate3_Weak_Conventional(i)=calculateKeyLossRate_Conventional(MArray(3),B,QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda(i));  
    keyLossRate4_Weak_Conventional(i)=calculateKeyLossRate_Conventional(MArray(4),B,QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda(i));
    keyLossRate5_Weak_Conventional(i)=calculateKeyLossRate_Conventional(MArray(5),B,QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda(i));
    keyLossRate6_Weak_Conventional(i)=calculateKeyLossRate_Conventional(MArray(6),B,QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda(i));
    keyLossRate7_Weak_Conventional(i)=calculateKeyLossRate_Conventional(MArray(7),B,QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda(i));
    keyLossRate8_Weak_Conventional(i)=calculateKeyLossRate_Conventional(MArray(8),B,QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda(i));
    
    %Strong turbulence
    [QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i)]=calculateQBER_QPSK_Gamma_Conventional(Attenuation,ScaleCo_Strong_Conventional,P_T_dBm,C2n_Strong);
    
    keyLossRate1_Strong_Conventional(i)=calculateKeyLossRate_Conventional(MArray(1),B,QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda(i));
    keyLossRate2_Strong_Conventional(i)=calculateKeyLossRate_Conventional(MArray(2),B,QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda(i));
    keyLossRate3_Strong_Conventional(i)=calculateKeyLossRate_Conventional(MArray(3),B,QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda(i));  
    keyLossRate4_Strong_Conventional(i)=calculateKeyLossRate_Conventional(MArray(4),B,QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda(i));
    keyLossRate5_Strong_Conventional(i)=calculateKeyLossRate_Conventional(MArray(5),B,QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda(i));
    keyLossRate6_Strong_Conventional(i)=calculateKeyLossRate_Conventional(MArray(6),B,QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda(i));
    keyLossRate7_Strong_Conventional(i)=calculateKeyLossRate_Conventional(MArray(7),B,QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda(i));
    keyLossRate8_Strong_Conventional(i)=calculateKeyLossRate_Conventional(MArray(8),B,QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda(i));
    
    %(b) Proposed system
    %HAP to Ground Station
    %Weak turbulence
    [QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i)]...
    =calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_SH,ScaleCo_Weak_HG,P_T_dBm,C2n_Weak);

    keyLossRate1_Weak_HG(i)=calculateKeyLossRate_HG(MArray(1),B,QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda(i));
    keyLossRate2_Weak_HG(i)=calculateKeyLossRate_HG(MArray(2),B,QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda(i));
    keyLossRate3_Weak_HG(i)=calculateKeyLossRate_HG(MArray(3),B,QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda(i));  
    keyLossRate4_Weak_HG(i)=calculateKeyLossRate_HG(MArray(4),B,QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda(i));
    keyLossRate5_Weak_HG(i)=calculateKeyLossRate_HG(MArray(5),B,QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda(i));
    keyLossRate6_Weak_HG(i)=calculateKeyLossRate_HG(MArray(6),B,QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda(i));
    keyLossRate7_Weak_HG(i)=calculateKeyLossRate_HG(MArray(7),B,QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda(i));
    keyLossRate8_Weak_HG(i)=calculateKeyLossRate_HG(MArray(8),B,QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda(i));
    
    %Strong turbulence
    [QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i)]...
    =calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_SH,ScaleCo_Strong_HG,P_T_dBm,C2n_Strong);
    
    keyLossRate1_Strong_HG(i)=calculateKeyLossRate_HG(MArray(1),B,QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda(i));
    keyLossRate2_Strong_HG(i)=calculateKeyLossRate_HG(MArray(2),B,QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda(i));
    keyLossRate3_Strong_HG(i)=calculateKeyLossRate_HG(MArray(3),B,QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda(i));  
    keyLossRate4_Strong_HG(i)=calculateKeyLossRate_HG(MArray(4),B,QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda(i));
    keyLossRate5_Strong_HG(i)=calculateKeyLossRate_HG(MArray(5),B,QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda(i));
    keyLossRate6_Strong_HG(i)=calculateKeyLossRate_HG(MArray(6),B,QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda(i));
    keyLossRate7_Strong_HG(i)=calculateKeyLossRate_HG(MArray(7),B,QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda(i));
    keyLossRate8_Strong_HG(i)=calculateKeyLossRate_HG(MArray(8),B,QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda(i));
end

% %Plot function of the key loss rate
% %(a) Conventional System
% figure(1)
% subplot(2,1,1)
% %Weak turbulence
% semilogy(lamda,keyLossRate1_Weak_Conventional,'k-',lamda,keyLossRate2_Weak_Conventional,'k-h',...
%          lamda,keyLossRate3_Weak_Conventional,'k-s',lamda,keyLossRate4_Weak_Conventional,'k-x',...
%          lamda,keyLossRate5_Weak_Conventional,'k-*',lamda,keyLossRate6_Weak_Conventional,'k-o',...
%          'LineWidth',1.5);
% grid on
% xlabel('Arrival rate, H (bit sequences/second)');
% ylabel('Key loss rate, KLR');
% title('(a)','FontWeight','Normal');
% legend('Conventional QKD','QKD-KR, M = 1', 'QKD-KR, M = 2', 'QKD-KR, M = 3', 'QKD-KR, M = 4',...
%        'QKD-KR, M = 5','Location','southeast');
% axis([0,200,1.e-17,1.e-0]);
% 
% subplot(2,1,2)
% %Strong turbulence
% semilogy(lamda,keyLossRate1_Strong_Conventional,'k-',lamda,keyLossRate2_Strong_Conventional,'k-h',...
%          lamda,keyLossRate3_Strong_Conventional,'k-s',lamda,keyLossRate4_Strong_Conventional,'k-x',...
%          lamda,keyLossRate5_Strong_Conventional,'k-*',lamda,keyLossRate6_Strong_Conventional,'k-o',...
%          'LineWidth',1.5);
% grid on
% xlabel('Arrival rate, H (bit sequences/second)');
% ylabel('Key loss rate, KLR');
% title('(b)','FontWeight','Normal');
% legend('Conventional QKD','QKD-KR, M = 1', 'QKD-KR, M = 2', 'QKD-KR, M = 3', 'QKD-KR, M = 4',...
%        'QKD-KR, M = 5','Location','southeast');
% axis([0,200,1.e-7,1.e-0]);
% 
% %(b) Proposed system
% figure(2)
% subplot(2,1,1)
% %Weak turbulence
% semilogy(lamda,keyLossRate1_Weak_HG,'b-',lamda,keyLossRate2_Weak_HG,'b-h',...
%          lamda,keyLossRate3_Weak_HG,'b-s',lamda,keyLossRate4_Weak_HG,'b-x',...
%          lamda,keyLossRate5_Weak_HG,'b-*',lamda,keyLossRate6_Weak_HG,'b-o',...
%          'LineWidth',1.5);
% grid on
% xlabel('Arrival rate, H (bit sequences/second)');
% ylabel('Key loss rate, KLR');
% title('(a)','FontWeight','Normal');
% legend('Conventional HAP-QKD','HAP-QKD-KR, M = 1', 'HAP-QKD-KR, M = 2', 'HAP-QKD-KR, M = 3', 'HAP-QKD-KR, M = 4',...
%        'HAP-QKD-KR, M = 5','Location','southeast');
% axis([0,200,1.e-17,1.e-0]);
% 
% subplot(2,1,2)
% %Strong turbulence
% semilogy(lamda,keyLossRate1_Strong_HG,'b-',lamda,keyLossRate2_Strong_HG,'b-h',...
%          lamda,keyLossRate3_Strong_HG,'b-s',lamda,keyLossRate4_Strong_HG,'b-x',...
%          lamda,keyLossRate5_Strong_HG,'b-*',lamda,keyLossRate6_Strong_HG,'b-o',...
%          'LineWidth',1.5);
% grid on
% xlabel('Arrival rate, H (bit sequences/second)');
% ylabel('Key loss rate, KLR');
% title('(b)','FontWeight','Normal');
% legend('Conventional HAP-QKD','HAP-QKD-KR, M = 1', 'HAP-QKD-KR, M = 2', 'HAP-QKD-KR, M = 3', 'HAP-QKD-KR, M = 4',...
%        'HAP-QKD-KR, M = 5','Location','southeast');
% axis([0,200,1.e-7,1.e-0]);
% 
% %(c) Combined
% figure(3)
% subplot(2,1,1)
% %Weak turbulence
% semilogy(lamda,keyLossRate1_Weak_Conventional,'k-',lamda,keyLossRate2_Weak_Conventional,'k-h',...
%          lamda,keyLossRate3_Weak_Conventional,'k-s',lamda,keyLossRate4_Weak_Conventional,'k-x',...
%          lamda,keyLossRate5_Weak_Conventional,'k-*',lamda,keyLossRate6_Weak_Conventional,'k-o',...
%          'LineWidth',1.5);
% hold on
% semilogy(lamda,keyLossRate2_Weak_HG,'b-h',lamda,keyLossRate3_Weak_HG,'b-s',...
%          lamda,keyLossRate4_Weak_HG,'b-x',lamda,keyLossRate5_Weak_HG,'b-*',...
%          lamda,keyLossRate6_Weak_HG,'b-o','LineWidth',1.5);
% hold off
% grid on
% xlabel('Arrival rate, H (bit sequences/second)');
% ylabel('Key loss rate, KLR');
% title('(a)','FontWeight','Normal');
% legend('Conventional QKD','QKD-KR, M = 1','QKD-KR, M = 2','QKD-KR, M = 3',...
%        'QKD-KR, M = 4','QKD-KR, M = 5''HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 2',...
%        'HAP-QKD-KR, M = 3','HAP-QKD-KR, M = 4','HAP-QKD-KR, M = 5','Location','southeast');
% axis([0,200,1.e-17,1.e-0]);
% 
% subplot(2,1,2)
% %Strong turbulence
% semilogy(lamda,keyLossRate1_Strong_Conventional,'k-',lamda,keyLossRate2_Strong_Conventional,'k-h',...
%          lamda,keyLossRate3_Strong_Conventional,'k-s',lamda,keyLossRate4_Strong_Conventional,'k-x',...
%          lamda,keyLossRate5_Strong_Conventional,'k-*',lamda,keyLossRate6_Strong_Conventional,'k-o',...
%          'LineWidth',1.5);
% hold on
% semilogy(lamda,keyLossRate2_Strong_HG,'b-h',lamda,keyLossRate3_Strong_HG,'b-s',...
%          lamda,keyLossRate4_Strong_HG,'b-x',lamda,keyLossRate5_Strong_HG,'b-*',...
%          lamda,keyLossRate6_Strong_HG,'b-o','LineWidth',1.5);
% hold off
% grid on
% xlabel('Arrival rate, H (bit sequences/second)');
% ylabel('Key loss rate, KLR');
% title('(b)','FontWeight','Normal');
% legend('Conventional QKD','QKD-KR, M = 1','QKD-KR, M = 2','QKD-KR, M = 3',...
%        'QKD-KR, M = 4','QKD-KR, M = 5','HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 2',...
%        'HAP-QKD-KR, M = 3','HAP-QKD-KR, M = 4','HAP-QKD-KR, M = 5','Location','southeast');
% axis([0,200,1.e-7,1.e-0]);

figure(4)
subplot(2,1,1)
%Weak turbulence
semilogy(lamda,keyLossRate1_Weak_Conventional,'k-',lamda,keyLossRate2_Weak_Conventional,'k-s',...
         lamda,keyLossRate4_Weak_Conventional,'k-*',lamda,keyLossRate6_Weak_Conventional,'k-o',...
         lamda,keyLossRate8_Weak_Conventional,'k-h','LineWidth',1.5);
hold on
semilogy(lamda,keyLossRate2_Weak_HG,'b-s',lamda,keyLossRate4_Weak_HG,'b*-',...
         lamda,keyLossRate6_Weak_HG,'b-o',lamda,keyLossRate8_Weak_HG,'b-h','LineWidth',1.5);
hold off
grid on
xlabel('Arrival rate, H (bit sequences/second)');
ylabel('Key loss rate, KLR');
title('(a)','FontWeight','Normal');
legend('Conventional QKD','QKD-KR, M = 1','QKD-KR, M = 3','QKD-KR, M = 5',...
       'QKD-KR, M = 7','HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 3',...
       'HAP-QKD-KR, M = 5','HAP-QKD-KR, M = 7','Location','southeast');
axis([0,200,1.e-21,1.e-0]);

subplot(2,1,2)
%Strong turbulence
semilogy(lamda,keyLossRate1_Strong_Conventional,'k-',lamda,keyLossRate2_Strong_Conventional,'k-s',...
         lamda,keyLossRate4_Strong_Conventional,'k-*',lamda,keyLossRate6_Strong_Conventional,'k-o',...
         lamda,keyLossRate8_Strong_Conventional,'k-h','LineWidth',1.5);
hold on
semilogy(lamda,keyLossRate2_Strong_HG,'b-s',lamda,keyLossRate4_Strong_HG,'b-*',...
         lamda,keyLossRate6_Strong_HG,'b-o',lamda,keyLossRate8_Strong_HG,'b-h','LineWidth',1.5);
hold off
grid on
xlabel('Arrival rate, H (bit sequences/second)');
ylabel('Key loss rate, KLR');
title('(b)','FontWeight','Normal');
legend('Conventional QKD','QKD-KR, M = 1','QKD-KR, M = 3','QKD-KR, M = 5',...
       'QKD-KR, M = 7','HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 3',...
       'HAP-QKD-KR, M = 5','HAP-QKD-KR, M = 7','Location','southeast');
axis([0,200,1.e-10,1.e-0]);