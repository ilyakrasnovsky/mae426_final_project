function soln = glider(t,s,m,S,Cl,Cd,g)
%Solve ODES for glider
    
     rho = 1.2*exp(-s(3)/9042);    %density as a function of height
      
    soln(1,1) = -Cd/2*rho*(s(1))^2*S/m-g*sin(s(2));
    soln(2,1) = 1/s(1)*(Cl/2*rho*(s(1))^2*S/m-g*cos(s(2)));
    soln(3,1) = s(1)*sin(s(2));
    soln(4,1) = s(1)*cos(s(2));

end

