%Object definition for first stage part of a rocket
classdef firststage
	properties
		m_1_i %Total initial mass [kg]
		m_1_p %Total propellant mass [kg]
		m_1_s %Structure mass [kg]
		T_1_SL %sea level thrust [N]
		T_1_vac % vacuum thrust [N]
		Isp_1_SL %sea level specific impulse [s]
		Isp_1_vac%vacuum specific impulse [s]
		tb_1%burn time [s]
		D_1 %Diameter [m]
		A_1 %Area [m^2]
		C_D_1 %drag coefficient	
	end

	methods
		%Constructor
		function newFS = firststage(m_1_i, m_1_p, m_1_s, ... 
									T_1_SL, T_1_vac, Isp_1_SL, Isp_1_vac, ...
									tb_1, D_1, A_1, C_D_1)
			newFS.m_1_i = m_1_i;
			newFS.m_1_p = m_1_p 
			newFS.m_1_s = m_1_s;  
			newFS.T_1_SL = T_1_SL;
			newFS.T_1_vac = T_1_vac;
			newFS.Isp_1_SL = Isp_1_SL;
			newFS.Isp_1_vac = Isp_1_vac;
			newFS.tb_1 = tb_1;
			newFS.D_1 = D_1;
			newFS.A_1 = A_1;
			newFS.C_D_1 = C_D_1;
		end		
	end
end