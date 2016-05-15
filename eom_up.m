%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity)
function soln = eom_up(t,s, rocket, constants)

	%First stage burn 
	if (t <= rocket.firststage.tb)
		disp('Simulating First Stage Burn');
		mainbody = rocket.firststage;
        current_stage = 'firststage';
    
	%Second stage burn
    elseif (t <= rocket.firststage.tb + rocket.secondstage.tb)
		disp('Simulating Second Stage Burn');
		mainbody = rocket.secondstage;
        current_stage = 'secondstage';
        
	%Rest of mission
	else
		%disp('Simulating Rest of Mission');
		mainbody = rocket.capsule;
        current_stage = 'capsule';
	end

	%Atmospheric Density model
	rho = constants.rho_SL*exp((-2.9e-5)*s(1)^1.15);
	
	%Geopotential Gravity model
	g = constants.g_SL * constants.R_earth^2 / (constants.R_earth^2 + s(1)^2);
    
    if (strcmp(current_stage, 'firststage'))        
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
        
    elseif (strcmp(current_stage, 'secondstage'))
        %Atmospheric Specific impulse model
        Isp = mainbody.Isp_vac;

        %Atmospheric Thrust model
        T = mainbody.T_vac;

        %Constant Mass flow rate model 
        m_dot = T / (Isp * g);
    
        %Mass of structure stage 1 detaches at 100000 km
        m = (rocket.m_tot_i - rocket.firststage.m_i) - m_dot*(t-rocket.firststage.tb);
        
    end
    
	%Atmospheric Drag model
	D = mainbody.C_D*rho*s(2)^2*mainbody.A/2;
    
	soln(1,1) = s(2);
	soln(2,1) = T / m - D / m - g;
	
end