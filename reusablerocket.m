%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity)
function soln = reusablerocket(t,s, A, C_D, m_tot_i, m_i, m_p, ...
			   m_s_pay, T_SL, T_vac, Isp_SL, Isp_vac, ...
			   g_SL, rho_SL, R_earth, tb))

	m = m_0 - m_dot_main*t;
	T_main = m_dot_main*c_e_main;

	%Atmospheric Density model
	rho = rho_SL*exp((-2.9e-5)*s(1)^1.15);
	
	%Atmospheric Specific impulse model
	Isp_1_SL = 1;

	%Atmospheric Thrust model

	%Constant Mass flow rate model 

	%Geopotential Gravity model
	g = g_SL * R_earth^2 / (R_earth^2 + s(1)^2);

	%Atmospheric Drag model
	D = C_D_main*rho*s(2)^2*A_main/2;

	soln(1,1) = s(2);
	soln(2,1) = T_main / m - D / m - g_0;
	
end
