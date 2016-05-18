function qbar = getqbar(altitude,s)

%Atmospheric Density model
rho = 1.225*exp((-2.9e-5)*altitude^1.15);

A = s(:,1);
V = s(:,2);

diff = abs(A(round(length(A)/2)) - altitude);
index = round(length(A)/2);
for n = round(length(A)/2):length(A)
    newDiff = abs(A(n) - altitude);
    if (newDiff < diff)
        index = n;
        diff = newDiff;
    end
end

velocity = V(index);

qbar = 0.5*rho*velocity^2;

end