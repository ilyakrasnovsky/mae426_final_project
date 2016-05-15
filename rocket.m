%Object definition for a two-stage rocket
classdef rocket
	properties
		%Total rocket data
		m_tot_i %Total Initial mass of rocket (Falcon 9) [kg]

		%First stage (reusable stage) data
		firststage
		
		%Second stage data
		secondstage

		%Capsule (third stage) data to LEO 
		capsule	
	end

	methods
		%Constructor takes in total mass, firststage object,
		%secondstage object, and capsule object
		function newRocket = rocket(m_tot_i, firststage, secondstage, capsule)
			newRocket.m_tot_i = m_tot_i;
			newRocket.firststage = firststage;
			newRocket.secondstage = secondstage; 
			newRocket.capsule = capsule; 
		end		
	end
end