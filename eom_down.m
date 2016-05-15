%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity)
function soln = eom_down(t,s, rocket, constants)

	mainbody = rocket.firststage;    

	%Atmospheric Density model
	rho = constants.rho_SL*exp((-2.9e-5)*s(1)^1.15);
	
	%Geopotential Gravity model
	g = constants.g_SL * constants.R_earth^2 / (constants.R_earth^2 + s(1)^2);
    
    %Atmospheric Thrust model
    T = 0;
    
    %Initial Mass, only structure of stage 1
    %m = mainbody.m_s;
    
    %Mass, thrust, and ISP constant for initial down calculations
    %{
    %Atmospheric Specific impulse model
    %Need to design as a function of altitude
    Isp = (mainbody.Isp_SL + mainbody.Isp_vac) / 2;

    %Atmospheric Thrust model
    %Need to design as a function of altitude
    T = (mainbody.T_SL + mainbody.T_vac) / 2;
    
    %Constant Mass flow rate model 
    m_dot = T / (Isp * g);

    %Mass of structure stage 1 detaches at 100000 km
    m = rocket.m_tot_i - m_dot*t;
    %}
    
	%Atmospheric Drag model
	D = mainbody.C_D*rho*s(2)^2*mainbody.A/2;
    
    %Cannot go below 0 altitude
    if (s(1) <= 0)
        soln(1,1) = 0;
    else
        soln(1,1) = s(2);    
    end
    %Drag always opposes velocity
    if (s(2) > 0)
        soln(2,1) = T / s(3) - D / s(3) - g;
    elseif (s(2) <= 0)
        soln(2,1) = T / s(3) + D / s(3) - g;
    end
    soln(3,1) = 0;
    soln
end