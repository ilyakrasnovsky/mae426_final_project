%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity)
function soln = reusablerocket(t,s, rocket, constants)

	%First stage burn 
	if (t <= rocket.firststage.tb)
		disp('Simulating First Stage Burn');
		mainbody = rocket.firststage;
	%Second stage burn
    elseif (t <= rocket.firststage.tb + rocket.secondstage.tb)
		disp('Simulating Second Stage Burn');
		mainbody = rocket.secondstage;
	%Rest of mission
	else
		disp('Simulating Rest of Mission');
		mainbody = rocket.capsule;
	end

	%Atmospheric Density model
	rho = constants.rho_SL*exp((-2.9e-5)*s(1)^1.15);
	
	%Geopotential Gravity model
	g = constants.g_SL * constants.R_earth^2 / (constants.R_earth^2 + s(1)^2);

	%Atmospheric Specific impulse model
	Isp = (mainbody.Isp_SL + mainbody.Isp_vac) / 2;

	%Atmospheric Thrust model
	T = (mainbody.T_SL + mainbody.T_vac) / 2;

	%Constant Mass flow rate model 
	m_dot = T / (Isp * g)
	
	m = rocket.m_tot_i - m_dot*t;
	
	%Atmospheric Drag model
	D = mainbody.C_D*rho*s(2)^2*mainbody.A/2;

	soln(1,1) = s(2);
	soln(2,1) = T / m - D / m - g;
	
end
