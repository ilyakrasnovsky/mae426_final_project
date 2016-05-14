%Script that solves the rocket equation ODE for a reusable rocket,
%ex. SpaceX.

%Clear workspace, command line, and close any figures
clear;
clc;
close all;

%Full-throttle (FT) Falcon 9 Version data (incomplete)
%m_0 = 549054;     % Initial mass of rocket (Falcon 9) [kg]
%m_p = 22800;	%Mass of payload + rest of rocket after reusable stage detach [kg]
%D_main = 3.7;		%Rocket Diameter (Falcon 9) [m
%t_b = 162;		%1st stage (reusable) burn time [s]

%General constants (for v1.1 of Falcon 9)

C_D_main = 1.14;	%Drag coefficient of rocket before reusable stage detach (cone)
C_D_reuse = 2;  	%Drag coefficient of reusable stage after detach
m_0 = 549054;     % Initial mass of rocket (Falcon 9) [kg]
m_p = 22800;	%Mass of payload + rest of rocket after reusable stage detach [kg]
m_fuel_main = m_0 - m_p; %Mass of reusable stage fuel [kg]
t_b = 162;		%1st stage (reusable) burn time [s] (162 for FT)
m_dot_main = m_fuel_main/t_b; %Mass flow rate of propellant out of rocket [kg/s]
m_dot_reuse = 1;	%Mass flow rate of propellant out of reusable stage [kg/s]
D_main = 3.66;		%Rocket Diameter (Falcon 9) [m]
A_main = pi*D_main^2/4;		%Drag area of rocket [m^2]
A_reuse = 2;		%Drag area of reusable stage [m^2]
T_main = 7607000;	%Sea level thrust of reusable stage [N]
c_e_main = T_main/m_dot_main; 	%Effective exhaust velocity of rocket [m/s]
c_e_reuse = 1;		%Effective exhaust velocity of reusable stage [m/s]

g_0 = 9.81;     	%Acceleration due to gravity at sea level [m/s^2]
rho = 1.225;		%Density of air at sea level [kg/m^3]
tspan = [0 t_b];     %Simulation Time interval [s]

%Initial conditions

h_0 = 0;     % Initial altitude of rocket above Earth's surface [m]
u_0 = 0;	 % Initial rocket velocity [m/s]
%a_0 = 0;	 % Initial rocket acceleration [m/s^2]
                
% Call ode45 to solve the equation of motion ODE

%options = odeset('RelTol', 1e-100);  %increases tolerances to avoid rounding errors
[t,s] = ode45(@reusablerocket, tspan, [h_0, u_0], [], A_main, C_D_main,...
			 c_e_main,m_dot_main, m_0, g_0, rho);

%Plot the values of interest over time

figure(1)
plot(t,s(:,1));  % h vs. t
title('Altitude of the Rocket vs. Time');
xlabel('Time (s)');
ylabel('Altitude (m)');

figure(2);
plot(t,s(:,2)); % u vs. t
title('Velocity of the Rocket vs. Time');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
%legend('b_1 direction (omega_1)','b_3 direction (omega_3');
