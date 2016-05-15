%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity, acceleration)
function soln = rocketup(t,s, A_main, C_D_main, c_e_main, m_dot_main, m_0, g_0, rho_SL)

    if (s(1) < 100000)
        m = m_0 - m_dot_main*t;
    else
        m = (m_0 - m_dot_main*t) - 20000; %mass_stage_1_structure
    end
	T = m_dot_main*c_e_main;
    rho = rho_SL*exp((-2.9e-5)*s(1)^1.15);
	D = C_D_main*rho*(s(2))^2*A_main/2;

	soln(1,1) = s(2);
	soln(2,1) = T / m - D / m - g_0;	
end