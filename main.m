function main(file)
 
[volt, time] = plotATM(file);
 
[HRV, rtime] = plotrr(volt, time);
 plotspec4(HRV, rtime);
 
end
