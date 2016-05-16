%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity)
function soln = eom_down(t,s, rocket, constants)

	mainbody = rocket.firststage;    

	%Atmospheric Density model
	rho = constants.rho_SL*exp((-2.9e-5)*s(1)^1.15);
	
	%Geopotential Gravity model
	g = constants.g_SL * constants.R_earth^2 / (constants.R_earth^2 + s(1)^2);
    
    %Atmospheric Thrust model
    %while we have fuel
    if (s(3) > mainbody.m_s)
        %T = -0.5*mainbody.T_SL; %immediate downward boost
        %below a given altitude
        h_fire = 80000; %altitude at which to fire upward boost [m]
        u_fire = 0; %velocity at which to fire upward boost [m/s]
        if (s(1) < h_fire)
        %if (s(2) < u_fire)
            T = 0.06*mainbody.T_SL;
        else
            T = 0;
        end
    else
        T = 0;
    end
    Isp = mainbody.Isp_vac;
    
	%Atmospheric Drag model
	D = mainbody.C_D*rho*s(2)^2*mainbody.A/2;
    
    %Cannot go below 0 altitude
    if (s(1) <= 0)
        soln(1,1) = 0;
        soln(2,1) = 0;
    else
        soln(1,1) = s(2);    
        %Drag always opposes velocity
        if (s(2) > 0)
            soln(2,1) = T / s(3) - D / s(3) - g;
        elseif (s(2) <= 0)
            soln(2,1) = T / s(3) + D / s(3) - g;
        end
    end
    %mass flow rate must be negative
    soln(3,1) = -T / (Isp * g);
    %soln
end