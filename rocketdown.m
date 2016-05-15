%Function handle for rocket equation for a reusable rocket 
% s : state : (altitude, velocity, acceleration)
function soln = rocketdown(t,s, A_main, C_D_main, c_e_reuse, m_dot_reuse, m_0, g_0, rho_SL)

    %m_0 constant untill we factor in thrust
    m = m_0;
	T = 0; %m_dot_main*c_e_main;
    rho = rho_SL*exp((-2.9e-5)*s(1)^1.15);
	D = C_D_main*rho*(s(2))^2*A_main/2;

    %(s(value), derivative)
	soln(1,1) = s(2);
    if (s(2) > 0)
        soln(2,1) = T / m - D / m - g_0;	
    elseif (s(2) <= 0)
        soln(2,1) = T / m + D / m - g_0;
    end
    
    if (s(1) < 10000)
        disp('done')
        disp(s(1))
        disp(s(2))
        disp(t)
    end
end