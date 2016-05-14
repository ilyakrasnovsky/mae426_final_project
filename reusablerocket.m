%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity, acceleration)
function soln = reusablerocket(t,s, A_main, C_D_main,...
			 c_e_main, m_dot_main, m_0, g_0, rho_SL)

	m = m_0 - m_dot_main*t;
	T_main = m_dot_main*c_e_main;
	rho = rho_SL*exp((-2.9e-5)*s(1)^1.15);
	D = C_D_main*rho*(s(2))^2*A_main/2;

	soln(1,1) = s(2);
	soln(2,1) = T_main / m - D / m - g_0;
	
end
