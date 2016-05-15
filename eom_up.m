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
        h_vac = 80000; %80000 m treated as vacuum height
        %Atmospheric Specific impulse and Thrust models (interpolation)
        %{
        if (s(1) < h_vac)
            Isp = mainbody.Isp_SL + (mainbody.Isp_vac - mainbody.Isp_SL) * s(1) / 80000;
            T = mainbody.T_SL + (mainbody.T_vac - mainbody.T_SL) * s(1) / 80000;
        else
            Isp = mainbody.Isp_vac;
            T = mainbody.T_vac;
        end
        %}

        T = mainbody.T_SL;
        Isp = mainbody.Isp_vac;

        %Constant Mass flow rate model 
        m_dot = T / (Isp * g);
    
        %Mass of structure stage 1 detaches at 100000 km
        m = rocket.m_tot_i - m_dot*t
        
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