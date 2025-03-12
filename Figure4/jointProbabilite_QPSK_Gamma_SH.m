function jointProbabilite=jointProbabilite_QPSK_Gamma_SH(bit_Alice,bit_Bob,ScaleCo,P_T_dBm) 
    %Gamma-Gamma channels
    %Simulation Parameters   
    
    global P_LO_dBm;               %Power of Local Oscillator(dBm)
    global Rb;                     %Bit rate(bps)
    global H_S;                    %Satellite altitude (m)
    global H_a;                    %Amospheric altitude (m)
    global lamda_wavelength;
    global zenithAng_Do
    
    kB=1.38*10^-23;                %Boltzman's constant(W/K/Hz)
    q=1.6*10^-19;                  %Electron charge(C)
    RL=50;                         %Load resistor(Ohm)
    T=298;                         %Receiver temperature(K)
    R=0.8;                         %PD responsivity
    x=0.8;                         %Excess noise factor(InGaAs APD)
    M=10;                          %Avalanche multiplication factor
    Id=3*10^-9;                    %Dark current(A)
    zenithAng=pi*zenithAng_Do/180; %(rad)
    G_Tx_dB=115;                   %Tx telescope gain(dB)
    G_Tx=10^(G_Tx_dB/10);
    G_Rx_dB=105;                   %Rx telescope gain(dB)
    G_Rx=10^(G_Rx_dB/10);
    deltaf=Rb/2;                   %Bandwidth of Noise(Hz)
    P_LO=10^(P_LO_dBm/10)*10^-3;
    P_T=10^(P_T_dBm/10)*10^-3;     %Transmitted power(W)
    
    %Calculate QBER
    %Free-space loss
    L_S=(H_S-H_a)/cos(zenithAng);
    FSL=(4*pi*L_S/lamda_wavelength)^2;
    
    I0=M*R*sqrt(G_Tx*1/FSL*P_T*G_Rx*P_LO);
    I1=-I0;
    
    EI0=I0;
    EI1=-EI0;
    
    sigmaN=sqrt(2*q*M^(2+x)*(R*P_LO+Id)*deltaf+4*kB*T/RL*deltaf);
            
    d0=EI0+ScaleCo*sqrt(sigmaN^2);
    d1=EI1-ScaleCo*sqrt(sigmaN^2);
            
    if bit_Alice==0 && bit_Bob==0
        jointProbabilite=1/2*qfunc((d0-I0)/sigmaN);   
    elseif bit_Alice==1 && bit_Bob==0
        jointProbabilite=1/2*qfunc((d0-I1)/sigmaN);    
    elseif bit_Alice==0 && bit_Bob==1
        jointProbabilite=1/2*qfunc((I0-d1)/sigmaN);      
    else 
        jointProbabilite=1/2*qfunc((I1-d1)/sigmaN);
    end
end