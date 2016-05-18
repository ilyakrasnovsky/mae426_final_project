alt = 1:100:2.1e4;

qbary = zeros(1,length(alt));

for y = 1:length(alt)
    
    qbary(y) = getqbar(alt(y),s);
    
end

plot(qbary,alt)
xlabel('Dynamic Pressure, Pa')
ylabel('Altitude, m')

%%
figure
semilogy(h,qbarmax)
ylabel('Max Dynamic Pressure, Pa')
xlabel('Airbrake length, m')