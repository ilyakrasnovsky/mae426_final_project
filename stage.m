%Object definition for a generic rocket stage
classdef stage
	properties
		m_i %Total initial mass [kg]
		m_p %Total propellant mass [kg]
		m_s %Structure mass [kg]
		m_pay %Payload mass [kg]
		T_SL %sea level thrust [N]
		T_vac % vacuum thrust [N]
		Isp_SL %sea level specific impulse [s]
		Isp_vac%vacuum specific impulse [s]
		tb%burn time [s]
		D %Diameter [m]
		A %Area [m^2]
		C_D %drag coefficient	
	end

	methods
		%Constructor
		function newStage = stage(m_i, m_p, m_s, m_pay, ... 
									T_SL, T_vac, Isp_SL, Isp_vac, ...
									tb, D, A, C_D)
			newStage.m_i = m_i;
			newStage.m_p = m_p 
			newStage.m_s = m_s;  
			newStage.m_pay = m_pay;
			newStage.T_SL = T_SL;
			newStage.T_vac = T_vac;
			newStage.Isp_SL = Isp_SL;
			newStage.Isp_vac = Isp_vac;
			newStage.tb = tb;
			newStage.D = D;
			newStage.A = A;
			newStage.C_D = C_D;
		end		
	end
end