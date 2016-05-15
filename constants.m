%Object definition for physical constants
classdef constants
	properties
		g_SL    	%Acceleration due to gravity at sea level [m/s^2]
		rho_SL		%Density of air at sea level [kg/m^3]
		R_earth     %Radius of the earth [m]
	end

	methods
		%Constructor
		function newConstants = constants(g_SL, rho_SL, R_earth)
			newConstants.g_SL = g_SL; 
			newConstants.rho_SL = rho_SL; 
			newConstants.R_earth = R_earth; 
		end		
	end
end