%Object definition for the second stage part of a rocket
classdef secondstage
	properties
		m_2_i %Total initial mass [kg]
		m_2_p %Total propellant mass [kg]
		m_2_s %Structure mass  [kg]
		T_2_vac %vacuum thrust [N]
		Isp_2_vac%vacuum specific impulse [s]
		tb_2 %burn time [s]
		D_2 %Diameter [m]
		A_2 %Area [m^2]
		C_D_2 %drag coefficient	
	end

	methods
		%Constructor
		function newSS = secondstage(m_2_i, m_2_p, ...
									m_2_s, T_2_vac, Isp_2_vac, tb_2, ... 
									D_2, A_2, C_D_2)
			newSS.m_2_i = m_2_i; 
			newSS.m_2_p = m_2_p; 
			newSS.m_2_s = m_2_s; 
			newSS.T_2_vac = T_2_vac;
			newSS.Isp_2_vac = Isp_2_vac;
			newSS.tb_2 = tb_2; 
			newSS.D_2 = D_2;
			newSS.A_2 = A_2;
			newSS.C_D_2 = C_D_2;
		end		
	end
end