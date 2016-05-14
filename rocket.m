%Object definition for a two-stage rocket
classdef rocket
	properties
		%Total rocket data

		m_tot_i %Total Initial mass of rocket (Falcon 9) [kg]

		%First stage (reusable stage) data

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

		%Second stage data

		m_2_i %Total initial mass [kg]
		m_2_p %Total propellant mass [kg]
		m_2_s %Structure mass  [kg]
		T_2_vac %vacuum thrust [N]
		Isp_2_vac%vacuum specific impulse [s]
		tb_2 %burn time [s]
		D_2 %Diameter [m]
		A_2 %Area [m^2]
		C_D_2 %drag coefficient

		%Dragon capsule (third stage) data to LEO 

		m_3_i %Total mass of the Dragon Capsule
		m_3_pay %Total LEO payload mass of Dragon capsule [kg]
		D_3 %Diameter [m]
		A_3 %Area [m^2]
		C_D_3 %drag coefficient	
	end

	methods
		%Constructor
		function newRocket = rocket(m_tot_i, m_1_i, m_1_p, m_1_s, ... 
									T_1_SL, T_1_vac, Isp_1_SL, Isp_1_vac, ...
									tb_1, D_1, A_1, C_D_1, m_2_i, m_2_p, ...
									m_2_s, T_2_vac, Isp_2_vac, tb_2, ... 
									D_2, A_2, C_D_2, m_3_i, m_3_pay, ... 
									D_3, A_3, C_D_3)
			newRocket.m_tot_i = m_tot_i;
			newRocket.m_1_i = m_1_i;
			newRocket.m_1_p = m_1_p 
			newRocket.m_1_s = m_1_s;  
			newRocket.T_1_SL = T_1_SL;
			newRocket.T_1_vac = T_1_vac;
			newRocket.Isp_1_SL = Isp_1_SL;
			newRocket.Isp_1_vac = Isp_1_vac;
			newRocket.tb_1 = tb_1;
			newRocket.D_1 = D_1;
			newRocket.A_1 = A_1;
			newRocket.C_D_1 = C_D_1;
			newRocket.m_2_i = m_2_i; 
			newRocket.m_2_p = m_2_p; 
			newRocket.m_2_s = m_2_s; 
			newRocket.T_2_vac = T_2_vac;
			newRocket.Isp_2_vac = Isp_2_vac;
			newRocket.tb_2 = tb_2; 
			newRocket.D_2 = D_2;
			newRocket.A_2 = A_2;
			newRocket.C_D_2 = C_D_2;
			newRocket.m_3_i = m_3_i; 
			newRocket.m_3_pay = m_3_pay; 
			newRocket.D_3 = D_3; 
			newRocket.A_3 = A_3;
			newRocket.C_D_3 = C_D_3;
		end		
	end
end