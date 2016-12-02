function [ HRV, rtime ] = plotrr( val, time )
%PLOTRR 
 
volt=val(1,:); %Reads the first ampliude readings from the time series
tTime=time(1,:); %Reads the corresponding time stamps
[pks,timeindice]=findpeaks(volt); %Find the local maxmima
 
i=1;
j=1;
 
while(i<length(pks)+1)  %This loop removes the local maxima that fall below the threhold
    
    if pks(i)> 1
        rintervals(j)=pks(i);
        rtime(j)=time(timeindice(i));
        j=j+1;
    end
    i=i+1;
end
 
for w = 2:length(rtime); %This loop filters for local maxima above the thresehold but on the same R wave as other local maxima
    try
        if rtime(w)-rtime(w-1)<0.25 %time interval for maximumheart
                
            rintervals(w)=[];
            rtime(w)=[];
        end
    catch
        break;
    end
end
 
heartrate=zeros(1,length(rtime),'double');
RRI=zeros(1,length(rtime),'double');
for w = 2:length(rtime);     %This loop calculates the time interval and sets the inverse of that number to HRV
    RRI(w)= (rtime(w)-rtime(w-1));
    HRV(w)=1/RRI(w);
    heartrate(w) = 60/RRI(w); %Instaneous heartrate (not used)
    
 
end
 %removes initial HRV value for smoother plot
rintervals(1)=[];
heartrate(1)=[];
HRV(1)=[];
rtime(1)=[];
 
figure;      %Plots the raw ECG against detected peak points
plot(tTime,volt,'b',rtime,rintervals,'*r' );
grid on
title('ECG Signal Peak detection')
xlabel('Time(seconds)')
ylabel('Voltage')
 
 
figure; %Plots HRV againt time
plot(rtime,HRV);
grid on
title('Heartrate Variability')
xlabel('Time(seconds)')
ylabel('HRV')
 
 
N = HRV; %Creates two vectors from HRV one with the first value missing and the other with the end value missing
N(end)=[]; %Creates N as N HRV values and NP as N+1 HRV values
NP=HRV;
NP(1)=[];
 
figure; %Plot the two vectors against each other
plot(NP,N,'.');
grid on
title('ECG Poincare Plot')
xlabel('RII(i)')
ylabel('RII(i+1)')
 
end
