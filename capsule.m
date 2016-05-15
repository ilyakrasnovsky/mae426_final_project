%Object definition for the capsule (payload) part of a rocket
classdef capsule
	properties
		m_3_i %Total mass [kg]
		m_3_pay %Total LEO payload mass [kg]
		D_3 %Diameter [m]
		A_3 %Area [m^2]
		C_D_3 %drag coefficient	
	end

	methods
		%Constructor
		function newCapsule = capsule(m_3_i, m_3_pay, ... 
									D_3, A_3, C_D_3)
			newCapsule.m_3_i = m_3_i; 
			newCapsule.m_3_pay = m_3_pay; 
			newCapsule.D_3 = D_3; 
			newCapsule.A_3 = A_3;
			newCapsule.C_D_3 = C_D_3;
		end		
	end
end