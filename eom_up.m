%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity, mass)
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
		disp('Simulating Rest of Mission');
		mainbody = rocket.capsule;
        current_stage = 'capsule';
	end

	%Atmospheric Density model
	rho = constants.rho_SL*exp((-2.9e-5)*s(1)^1.15);
	
	%Geopotential Gravity model
	g = constants.g_SL * constants.R_earth^2 / (constants.R_earth^2 + s(1)^2);
    
    %Models first stage
    if (strcmp(current_stage, 'firststage'))

        %Thrust and Isp Model
        T = mainbody.T_SL;
        Isp = mainbody.Isp_vac;
        
    %Able to model the second stage if we chose    
    elseif (strcmp(current_stage, 'secondstage'))
        %Atmospheric Specific impulse model
        Isp = mainbody.Isp_vac;

        %Atmospheric Thrust model
        T = mainbody.T_vac;
    end
    
	%Atmospheric Drag model
	D = mainbody.C_D*rho*s(2)^2*mainbody.A/2;
    
	soln(1,1) = s(2); %hdot = u
	soln(2,1) = T / s(3) - D / s(3) - g; %udot = force balance
    soln(3,1) = -T / (Isp * g); %mdot = mdot
end