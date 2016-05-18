Mmax = 1e4; % max moment on base of airbrake

CD = 1.28; % drag coefficient of the airbrake

w = 1; % width, m

h = 0:0.1:4; % range of airbrake lengths, meters

work = zeros(size(h));

qbarmax = zeros(size(h));

Amax = zeros(size(h));

for n = 1:length(h)
    
    Amax(n) = 2.1e4;
    
    qbarmax(n) = 2*Mmax/(h(n)*h(n)*w);
    
    % calculate max altitude
    for altitude = 0:10:2.1e4;
        
        rho = 1.225*exp((-2.9e-5)*altitude^1.15);

        A = s(:,1);
        V = s(:,2);

        diff = abs(A(20) - altitude);
        index = 20;
        for k = 20:length(A);
            newDiff = abs(A(k) - altitude);
            if (newDiff <= diff)
                index = k;
                diff = newDiff;
            end
        end

        velocity = V(index);

        qbar = 0.5*rho*velocity^2;
        
        Amax(n) = altitude;
 
        if (qbarmax(n) < qbar)
            break;
        end
    end
    
    
    % calculate work done by airbrakes
    
    dA = 10; % step size of 10 meters
    x = 0;
    while (x < Amax(n))
        
        rho = 1.225*exp((-2.9e-5)*x^1.15);
        A = s(:,1);
        V = s(:,2);
        diff = abs(A(20) - x);
        index = 20;
        for j = 20:length(A);
            newDiff = abs(A(j) - x);
            if (newDiff <= diff)
                index = j;
                diff = newDiff;
            end
        end
        velocity = V(index);
        qbar = 0.5*rho*velocity^2;
        
        dwork = qbar*CD*w*h(n)*dA;
        
        work(n) = work(n) + dwork;
        
        x = x + dA;
        
    end
end

%%

plot(h,work)
xlabel('Airbrake length, meters')
ylabel('Work done slowing the rocket, joules')

%%
plot(h,Amax)
xlabel('Airbrake length, meters')
ylabel('Deployment altitude, meters')