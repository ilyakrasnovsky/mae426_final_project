%Script that solves the rocket equation ODE for a reusable rocket,
%ex. SpaceX.

%Clear workspace, command line, and close any figures
clear;
clc;
close all;

%General constants (for v1.1 of Falcon 9)

%Total rocket data
m_tot_i = 505846;     %Total Initial mass of rocket (Falcon 9) [kg]

%First stage (reusable stage) data

m_1_i = 392500; %Total initial mass [kg]
m_1_p = 372500; %Total propellant mass [kg]
m_1_s = m_1_i - m_1_p; %Structure mass [kg]
T_1_SL =  5885058.92; %sea level thrust [N]
T_1_vac = 6672405.43; % vacuum thrust [N]
Isp_1_SL = 282; %sea level specific impulse [s]
Isp_1_vac = 311; %vacuum specific impulse [s]
tb_1 = 185; %burn time [s]
D_1 = 3.66; %Diameter [m]
A_1 = pi*D_1^2/4; %Area [m^2]
C_D_1 = 1.14; %drag coefficient

%Second stage data

m_2_i = 79000; %Total initial mass [kg]
m_2_p = 75000; %Total propellant mass [kg]
m_2_s =  m_2_i - m_2_p; %Structure mass  [kg]
T_2_vac = 800683.553; %vacuum thrust [N]
Isp_2_vac = 340; %vacuum specific impulse [s]
tb_2 = 375; %burn time [s]
D_2 = 3.66; %Diameter [m]
A_2 = pi*D_2^2/4; %Area [m^2]
C_D_2 = 1.14; %drag coefficient

%Dragon capsule (third stage) data to LEO 

m_3_i = m_tot_i - m_1_i - m_2_i; %Total mass of the Dragon Capsule
m_3_pay = 13150; %Total LEO payload mass of Dragon capsule [kg]
D_3 = 5.2; %Diameter [m]
A_3 = pi*D_3^2/4; %Area [m^2]
C_D_3 = 1.14; %drag coefficient

%Physical Constants

g_SL = 9.81;     	%Acceleration due to gravity at sea level [m/s^2]
rho_SL = 1.225;		%Density of air at sea level [kg/m^3]
R_earth = 6371000;  %Radius of the earth [m]
tspan = [0 600];     %Simulation Time interval [s]

%Initial conditions for ode45

h_0 = 0;     % Initial altitude of rocket above Earth's surface [m]
u_0 = 0;	 % Initial rocket velocity [m/s]
%a_0 = 0;	 % Initial rocket acceleration [m/s^2]
  
f9 = rocket(m_tot_i, m_1_i, m_1_p, m_1_s, ... 
			T_1_SL, T_1_vac, Isp_1_SL, Isp_1_vac, ...
			tb_1, D_1, A_1, C_D_1, m_2_i, m_2_p, ...
			m_2_s, T_2_vac, Isp_2_vac, tb_2, ... 
			D_2, A_2, C_D_2, m_3_i, m_3_pay, ... 
			D_3, A_3, C_D_3)

%{
%Grouped Inputs to ode45

A = [A1, A2, A3];
C_D = [C_D_1, C_D_2, C_D_3];
m_i = [m_1_i, m_2_i, m_3_i];
m_p = [m_1_p, m_2_p];
m_s_pay = [m_1_s, m_2_s, m_3_pay];
T_SL = [T_1_SL];
T_vac = [T_1_vac, T_2_vac];
Isp_SL = [Isp_1_SL];
Isp_vac = [Isp_1_vac, Isp_2_vac];
tb = [tb_1, tb_2];

% Call ode45 to solve the equation of motion ODE

%options = odeset('RelTol', 1e-100);  %increases tolerances to avoid rounding errors
[t,s] = ode45(@reusablerocket, tspan, [h_0, u_0], [], A, C_D, ...
			 m_tot_i, m_i, m_p, m_s_pay, T_SL, T_vac, Isp_SL, Isp_vac, ...
			 g_SL, rho_SL, R_earth, tb);

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
%}
