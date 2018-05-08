clc;
clear all;
close all;


x=input('Enter the binary info');     %put in brackets like [1 0 1 0] as i/p
bp=input('Enter the value of Tb');                                               

bit=[]; 
for n=1:1:length(x)
    if x(n)==1;
       se=ones(1,100);
    else x(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];

end
t1=bp/100:bp/100:100*length(x)*(bp/100);
subplot(3,1,1);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('transmitting information as digital signal');




A=5;                                         
br=1/bp;                                                         
f1=br*8;                           
f2=br*2;                           
t2=bp/99:bp/99:bp;                 
ss=length(t2);
m=[];
for (i=1:1:length(x))
    if (x(i)==1)
        y=A*cos(2*pi*f1*t2);
    else
        y=A*cos(2*pi*f2*t2);
    end
    m=[m y];
end
t3=bp/99:bp/99:bp*length(x);
subplot(3,1,2);
plot(t3,m);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('waveform for binary FSK modulation coresponding binary information');
%Non coherent Demodulation
mn=[];
for n=ss:ss:length(m)
  t=bp/99:bp/99:bp;
  y1=cos(2*pi*f1*t);
  y2=cos(2*pi*f2*t); 
   
  y11=sin(2*pi*f1*t);                 
  y22=sin(2*pi*f2*t);
  mm=y1.*m((n-(ss-1)):n);
  mmm=y2.*m((n-(ss-1)):n);
  mm1=y11.*m((n-(ss-1)):n);
  mmm1=y22.*m((n-(ss-1)):n);
  t4=bp/99:bp/99:bp;
  z1=trapz(t4,mm);
  z11=trapz(t4,mm1); 
  z2=trapz(t4,mmm);
  z22=trapz(t4,mmm1); 
  zz1=round(2*z1/bp);
  zz11=round(2*z11/bp);
  zz2= round(2*z2/bp);
  zz22= round(2*z22/bp);
  %square law detection
  R1=zz1^2+zz11^2;
  R2=zz2^2+zz22^2;
  if((R1>R2))      
    a=1;
  else(R2>R1)
    a=0;
  end
  mn=[mn a];
end
disp(' Binary information at Reciver :');
disp(mn);
bit=[];
for n=1:length(mn);
    if mn(n)==1;
       se=ones(1,100);
    else mn(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];

end
t4=bp/100:bp/100:100*length(mn)*(bp/100);
subplot(3,1,3)
plot(t4,bit,'LineWidth',2.5);grid on;
axis([ 0 bp*length(mn) -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('recived information as digital signal after binary FSK Non-coherent demodulation');


