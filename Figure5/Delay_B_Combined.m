clear;
clc;

%Parameters Simulation
global Rb;                %Bit rate (bps)
global P_LO_dBm;          %Power of Local Oscillator (dBm)
global lamda_wavelength;  %Wavelength (m)
global v_wind;            %Wind speed (m/s)
global H_S;               %Satellite altitude (m)
global H_G;               %Ground station height (m)
global H_a;               %Amospheric altitude (m)
global l_k;               %Length of bit string (in bits)
global zenithAng_Do
global D;                 %Maximum delay jitter

Rb=10*10^9;
P_LO_dBm=0;
lamda_wavelength=1550*10^-9;
v_wind=21;
D=80*10^-3;
H_S=600*10^3;
H_G=5;   
H_a=20*10^3;
l_k=5*10^7; 
zenithAng_Do=50;

C2n_Weak=5*10^-15;        %Refractive index structure coefficient
C2n_Strong=7*10^-12; 

MArray=[1,2,3,4,5,6,7,8]; %Maximum number of transmissions
Attenuation=0.43;
P_T_dBm=7;

lamda_Weak=60;
lamda_Strong=60;

%(a) Conventional System
ScaleCo_Weak=0.7;
ScaleCo_Strong=1.4;

%(b) Proposed System
ScaleCo_SH=0.7;
ScaleCo_Weak_HG=0.7;
ScaleCo_Strong_HG=1.4;

B=4:1:16;

%Calculate delay outage rate
%(a) Conventional System
%Weak turbulence
QBER_Weak_Conventional=zeros(1,length(B));
P_sift_Weak_Conventional=zeros(1,length(B));

delayOutageRate2_Weak_Conventional=zeros(1,length(B));
delayOutageRate3_Weak_Conventional=zeros(1,length(B));
delayOutageRate4_Weak_Conventional=zeros(1,length(B));
delayOutageRate5_Weak_Conventional=zeros(1,length(B));
delayOutageRate6_Weak_Conventional=zeros(1,length(B));
delayOutageRate7_Weak_Conventional=zeros(1,length(B));
delayOutageRate8_Weak_Conventional=zeros(1,length(B));

%Strong turbulence
QBER_Strong_Conventional=zeros(1,length(B));
P_sift_Strong_Conventional=zeros(1,length(B));

delayOutageRate2_Strong_Conventional=zeros(1,length(B));
delayOutageRate3_Strong_Conventional=zeros(1,length(B));
delayOutageRate4_Strong_Conventional=zeros(1,length(B));
delayOutageRate5_Strong_Conventional=zeros(1,length(B));
delayOutageRate6_Strong_Conventional=zeros(1,length(B));
delayOutageRate7_Strong_Conventional=zeros(1,length(B));
delayOutageRate8_Strong_Conventional=zeros(1,length(B));

%(b) Proposed System
%Satellite to HAP
QBER_SH=zeros(1,length(B));
P_sift_SH=zeros(1,length(B));

%HAP to Ground Station
%Weak turbulence
QBER_Weak_HG=zeros(1,length(B));
P_sift_Weak_HG=zeros(1,length(B));

delayOutageRate2_Weak_HG=zeros(1,length(B));
delayOutageRate3_Weak_HG=zeros(1,length(B));
delayOutageRate4_Weak_HG=zeros(1,length(B));
delayOutageRate5_Weak_HG=zeros(1,length(B));
delayOutageRate6_Weak_HG=zeros(1,length(B));
delayOutageRate7_Weak_HG=zeros(1,length(B));
delayOutageRate8_Weak_HG=zeros(1,length(B));

%Strong turbulence
QBER_Strong_HG=zeros(1,length(B));
P_sift_Strong_HG=zeros(1,length(B));

delayOutageRate2_Strong_HG=zeros(1,length(B));
delayOutageRate3_Strong_HG=zeros(1,length(B));
delayOutageRate4_Strong_HG=zeros(1,length(B));
delayOutageRate5_Strong_HG=zeros(1,length(B));
delayOutageRate6_Strong_HG=zeros(1,length(B));
delayOutageRate7_Strong_HG=zeros(1,length(B));
delayOutageRate8_Strong_HG=zeros(1,length(B));

for i=1:length(B)
    %(a) Conventional System
    %Weak turbulence
    [QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i)]=calculateQBER_QPSK_Gamma_Conventional(Attenuation,ScaleCo_Weak,P_T_dBm,C2n_Weak);
    
    delayOutageRate2_Weak_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(2),B(i),QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda_Weak);
    delayOutageRate3_Weak_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(3),B(i),QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda_Weak);  
    delayOutageRate4_Weak_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(4),B(i),QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda_Weak);
    delayOutageRate5_Weak_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(5),B(i),QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda_Weak);
    delayOutageRate6_Weak_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(6),B(i),QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda_Weak);
    delayOutageRate7_Weak_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(7),B(i),QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda_Weak);
    delayOutageRate8_Weak_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(8),B(i),QBER_Weak_Conventional(i),P_sift_Weak_Conventional(i),lamda_Weak);
    
    %Strong turbulence
    [QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i)]=calculateQBER_QPSK_Gamma_Conventional(Attenuation,ScaleCo_Strong,P_T_dBm,C2n_Strong);
    
    delayOutageRate2_Strong_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(2),B(i),QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda_Strong);
    delayOutageRate3_Strong_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(3),B(i),QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda_Strong);  
    delayOutageRate4_Strong_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(4),B(i),QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda_Strong);
    delayOutageRate5_Strong_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(5),B(i),QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda_Strong);
    delayOutageRate6_Strong_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(6),B(i),QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda_Strong);
    delayOutageRate7_Strong_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(7),B(i),QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda_Strong);
    delayOutageRate8_Strong_Conventional(i)=calculateKeyLossRate_Delay_Conventional(MArray(8),B(i),QBER_Strong_Conventional(i),P_sift_Strong_Conventional(i),lamda_Strong);
    
    %(b) Proposed System
    %HAP to Ground Station
    %Weak turbulence
    [QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i)]...
    =calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_SH,ScaleCo_Weak_HG,P_T_dBm,C2n_Weak);

    delayOutageRate2_Weak_HG(i)=calculateKeyLossRate_Delay_HG(MArray(2),B(i),QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda_Weak);
    delayOutageRate3_Weak_HG(i)=calculateKeyLossRate_Delay_HG(MArray(3),B(i),QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda_Weak);  
    delayOutageRate4_Weak_HG(i)=calculateKeyLossRate_Delay_HG(MArray(4),B(i),QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda_Weak);
    delayOutageRate5_Weak_HG(i)=calculateKeyLossRate_Delay_HG(MArray(5),B(i),QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda_Weak);
    delayOutageRate6_Weak_HG(i)=calculateKeyLossRate_Delay_HG(MArray(6),B(i),QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda_Weak);
    delayOutageRate7_Weak_HG(i)=calculateKeyLossRate_Delay_HG(MArray(7),B(i),QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda_Weak);
    delayOutageRate8_Weak_HG(i)=calculateKeyLossRate_Delay_HG(MArray(8),B(i),QBER_SH(i),P_sift_SH(i),QBER_Weak_HG(i),P_sift_Weak_HG(i),lamda_Weak);
    
    %Strong turbulence
    [QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i)]...
    =calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_SH,ScaleCo_Strong_HG,P_T_dBm,C2n_Strong);

    delayOutageRate2_Strong_HG(i)=calculateKeyLossRate_Delay_HG(MArray(2),B(i),QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda_Strong);
    delayOutageRate3_Strong_HG(i)=calculateKeyLossRate_Delay_HG(MArray(3),B(i),QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda_Strong);  
    delayOutageRate4_Strong_HG(i)=calculateKeyLossRate_Delay_HG(MArray(4),B(i),QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda_Strong);
    delayOutageRate5_Strong_HG(i)=calculateKeyLossRate_Delay_HG(MArray(5),B(i),QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda_Strong);
    delayOutageRate6_Strong_HG(i)=calculateKeyLossRate_Delay_HG(MArray(6),B(i),QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda_Strong);
    delayOutageRate7_Strong_HG(i)=calculateKeyLossRate_Delay_HG(MArray(7),B(i),QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda_Strong);
    delayOutageRate8_Strong_HG(i)=calculateKeyLossRate_Delay_HG(MArray(8),B(i),QBER_SH(i),P_sift_SH(i),QBER_Strong_HG(i),P_sift_Strong_HG(i),lamda_Strong);
end

% %Plot function of the delay outage rate
% %(a) Conventional System
% figure(1)
% subplot(1,2,1)
% %Weak turbulence
% semilogy(B,delayOutageRate2_Weak_Conventional,'k-h',...
%          B,delayOutageRate3_Weak_Conventional,'k-s',B,delayOutageRate4_Weak_Conventional,'k-x',...
%          B,delayOutageRate5_Weak_Conventional,'k-*',B,delayOutageRate6_Weak_Conventional,'k-o',...
%          'LineWidth',1.5);
% grid on
% xlabel('Buffer size, B (bit strings)');
% ylabel('Delay outage rate');
% title('(a)','FontWeight','Normal');
% legend('QKD-KR, M = 1','QKD-KR, M = 2','QKD-KR, M = 3','QKD-KR, M = 4',...
%        'QKD-KR, M = 5','Location','southeast');
% axis([4,16,1.e-28,1.e-0]);
% 
% subplot(1,2,2)
% %Strong turbulence
% semilogy(B,delayOutageRate2_Strong_Conventional,'k-h',...
%          B,delayOutageRate3_Strong_Conventional,'k-s',B,delayOutageRate4_Strong_Conventional,'k-x',...
%          B,delayOutageRate5_Strong_Conventional,'k-*',B,delayOutageRate6_Strong_Conventional,'k-o',...
%          'LineWidth',1.5);
% grid on
% xlabel('Buffer size, B (bit strings)');
% ylabel('Delay outage rate');
% title('(b)','FontWeight','Normal');
% legend('QKD-KR, M = 1','QKD-KR, M = 2','QKD-KR, M = 3','QKD-KR, M = 4',...
%        'QKD-KR, M = 5','Location','southeast');
% axis([4,16,1.e-11,1.e-0]);
% 
% %(b) Proposed system
% figure(2)
% subplot(1,2,1)
% %Weak turbulence
% semilogy(B,delayOutageRate2_Weak_HG,'b-h',...
%          B,delayOutageRate3_Weak_HG,'b-s',B,delayOutageRate4_Weak_HG,'b-x',...
%          B,delayOutageRate5_Weak_HG,'b-*',B,delayOutageRate6_Weak_HG,'b-o',...
%          'LineWidth',1.5);
% grid on
% xlabel('Buffer size, B (bit strings)');
% ylabel('Delay outage rate');
% title('(a)','FontWeight','Normal');
% legend('HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 2','HAP-QKD-KR, M = 3','HAP-QKD-KR, M = 4',...
%        'HAP-QKD-KR, M = 5','Location','southeast');
% axis([4,16,1.e-28,1.e-0]);
% 
% subplot(1,2,2)
% %Strong turbulence
% semilogy(B,delayOutageRate2_Strong_HG,'b-h',...
%          B,delayOutageRate3_Strong_HG,'b-s',B,delayOutageRate4_Strong_HG,'b-x',...
%          B,delayOutageRate5_Strong_HG,'b-*',B,delayOutageRate6_Strong_HG,'b-o',...
%          'LineWidth',1.5);
% grid on
% xlabel('Buffer size, B (bit strings)');
% ylabel('Delay outage rate');
% title('(b)','FontWeight','Normal');
% legend('HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 2','HAP-QKD-KR, M = 3','HAP-QKD-KR, M = 4',...
%        'HAP-QKD-KR, M = 5','Location','southeast');
% axis([4,16,1.e-11,1.e-0]);
% 
% %(c) Combined
% figure(3)
% subplot(1,2,1)
% %Weak turbulence
% semilogy(B,delayOutageRate2_Weak_Conventional,'k-h',...
%          B,delayOutageRate3_Weak_Conventional,'k-s',B,delayOutageRate4_Weak_Conventional,'k-x',...
%          B,delayOutageRate5_Weak_Conventional,'k-*',B,delayOutageRate6_Weak_Conventional,'k-o',...
%          'LineWidth',1.5);
% hold on
% semilogy(B,delayOutageRate2_Weak_HG,'b-h',...
%          B,delayOutageRate3_Weak_HG,'b-s',B,delayOutageRate4_Weak_HG,'b-x',...
%          B,delayOutageRate5_Weak_HG,'b-*',B,delayOutageRate6_Weak_HG,'b-o',...
%          'LineWidth',1.5);
% hold off
% grid on
% xlabel('Buffer size, B (bit strings)');
% ylabel('Delay outage rate');
% title('(a)','FontWeight','Normal');
% legend('QKD-KR, M = 1','QKD-KR, M = 2','QKD-KR, M = 3',...
%        'QKD-KR, M = 4','QKD-KR, M = 5','HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 2',...
%        'HAP-QKD-KR, M = 3','HAP-QKD-KR, M = 4','HAP-QKD-KR, M = 5','Location','southeast');
% axis([4,16,1.e-28,1.e-0]);
% 
% subplot(1,2,2)
% %Strong turbulence
% semilogy(B,delayOutageRate2_Strong_Conventional,'k-h',...
%          B,delayOutageRate3_Strong_Conventional,'k-s',B,delayOutageRate4_Strong_Conventional,'k-x',...
%          B,delayOutageRate5_Strong_Conventional,'k-*',B,delayOutageRate6_Strong_Conventional,'k-o',...
%          'LineWidth',1.5);
% hold on
% semilogy(B,delayOutageRate2_Strong_HG,'b-h',...
%          B,delayOutageRate3_Strong_HG,'b-s',B,delayOutageRate4_Strong_HG,'b-x',...
%          B,delayOutageRate5_Strong_HG,'b-*',B,delayOutageRate6_Strong_HG,'b-o',...
%          'LineWidth',1.5);
% hold off
% grid on
% xlabel('Buffer size, B (bit strings)');
% ylabel('Delay outage rate');
% title('(b)','FontWeight','Normal');
% legend('QKD-KR, M = 1','QKD-KR, M = 2','QKD-KR, M = 3',...
%        'QKD-KR, M = 4','QKD-KR, M = 5','HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 2',...
%        'HAP-QKD-KR, M = 3','HAP-QKD-KR, M = 4','HAP-QKD-KR, M = 5','Location','southeast');
% axis([4,16,1.e-11,1.e-0]);

figure(4)
subplot(1,2,1)
%Weak turbulence
semilogy(B,delayOutageRate2_Weak_Conventional,'k-s',...
         B,delayOutageRate4_Weak_Conventional,'k-*',B,delayOutageRate6_Weak_Conventional,'k-o',...
         B,delayOutageRate8_Weak_Conventional,'k-h','LineWidth',1.5);
hold on
semilogy(B,delayOutageRate2_Weak_HG,'b-s',...
         B,delayOutageRate4_Weak_HG,'b*-',B,delayOutageRate6_Weak_HG,'b-o',...
         B,delayOutageRate8_Weak_HG,'b-h','LineWidth',1.5);
hold off
grid on
xlabel('Buffer size, B (bit strings)');
ylabel('Delay outage rate');
title('(a)','FontWeight','Normal');
legend('QKD-KR, M = 1','QKD-KR, M = 3','QKD-KR, M = 5',...
       'QKD-KR, M = 7','HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 3',...
       'HAP-QKD-KR, M = 5','HAP-QKD-KR, M = 7','Location','southeast');
% axis([4,16,1.e-28,1.e-0]);

subplot(1,2,2)
%Strong turbulence
semilogy(B,delayOutageRate2_Strong_Conventional,'k-s',...
         B,delayOutageRate4_Strong_Conventional,'k-*',B,delayOutageRate6_Strong_Conventional,'k-o',...
         B,delayOutageRate8_Strong_Conventional,'k-h','LineWidth',1.5);
hold on
semilogy(B,delayOutageRate2_Strong_HG,'b-s',...
         B,delayOutageRate4_Strong_HG,'b-*',B,delayOutageRate6_Strong_HG,'b-o',...
         B,delayOutageRate8_Strong_HG,'b-h','LineWidth',1.5);
hold off
grid on
xlabel('Buffer size, B (bit strings)');
ylabel('Delay outage rate');
title('(b)','FontWeight','Normal');
legend('QKD-KR, M = 1','QKD-KR, M = 3','QKD-KR, M = 5',...
       'QKD-KR, M = 7','HAP-QKD-KR, M = 1','HAP-QKD-KR, M = 3',...
       'HAP-QKD-KR, M = 5','HAP-QKD-KR, M = 7','Location','southeast');
% axis([4,16,1.e-11,1.e-0]);