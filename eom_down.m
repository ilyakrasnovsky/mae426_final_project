%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity, mass)
function soln = eom_down(t,s, rocket, constants)

	mainbody = rocket.firststage;    

	%Atmospheric Density model
	rho = constants.rho_SL*exp((-2.9e-5)*s(1)^1.15);
	
	%Geopotential Gravity model
	g = constants.g_SL * constants.R_earth^2 / (constants.R_earth^2 + s(1)^2);
    
    %Thrust model
    %while we have fuel
    if (s(3) > mainbody.m_s)
        
        %immediate downward boost below a given altitude
        if ((t > 0) && (t < 10))
            T = -0.25*mainbody.T_SL;             
        %Around 299-300 provides slow descent    
        elseif (t > 298.6) 
            T = 0.05*mainbody.T_SL;
        else
            T = 0;        
        end
    else
        T = 0;
    end
    
    %Isp model from vaccume
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
    if ((t > 0) && (t < 10))
        soln(3,1) = T / (Isp * g);
    else
        soln(3,1) = -T / (Isp * g);
    end
end