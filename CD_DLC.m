close all
clear all
clc
data=readtable('E:\Supriyo_DLC\ST_CDDLC_resnet50_cervical_dystoniaNov16shuffle1_500000 - Copy');
nb_X=data.nb_ad_x;
nb_Y=data.nb_ad_y;
nt_X=data.nt_ad_x;
nt_Y=data.nt_ad_y;
SS=30; %Hz
t=(data.coords./30); %s
subplot(2,2,1);
%plot(t(1:300),nb_Y(1:300));
%hold on 
plot(t(1:300),nb_X(1:300));
hold on 
plot(t(1:300),nt_X(1:300),'--b');
hold on
% plot(t(1:300),nt_Y(1:300),'--r');
xlabel ('Time (s)');
ylabel ('Pixels');
fftsz=120;  
meas={'Psn','Vel','Acc'};
for n=1:3
    
    subplot (2,2,n+1);
    L=floor(length(nb_Y)/fftsz);
    data=reshape(nb_Y(1:L*fftsz),[fftsz,L]);
    if n>1
        data=diff(data,n-1);
    end
    data=fft(data,[],1);
    data=data.*conj(data);
    pow=sum(data,2);
    f=linspace(0,15,fftsz/2+1);
    pow=pow/sum(pow(2:fftsz/2+1));
    plot(f(2:fftsz/2+1),pow(2:fftsz/2+1),'k-');
    xlabel ('Frequency (Hz)');
    ylabel ('Relative Power');
    title (meas{n});
    
end