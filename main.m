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
m_1_pay = 0; %Payload mass [kg]
T_1_SL =  5885058.92; %sea level thrust [N]
T_1_vac = 6672405.43; % vacuum thrust [N]
Isp_1_SL = 282; %sea level specific impulse [s]
Isp_1_vac = 311; %vacuum specific impulse [s]
tb_1 = 185; %data burn time [s]
%tb_1 = 173; %code (modified) burn time [s]
D_1 = 3.66; %Diameter [m]
A_1 = pi*D_1^2/4; %Area [m^2]
C_D_1 = 1.14; %drag coefficient
f9_firststage = stage(m_1_i, m_1_p, m_1_s, m_1_pay, ... 
			T_1_SL, T_1_vac, Isp_1_SL, Isp_1_vac, ...
			tb_1, D_1, A_1, C_D_1);

%Second stage data
m_2_i = 79000; %Total initial mass [kg]
m_2_p = 75000; %Total propellant mass [kg]
m_2_s =  m_2_i - m_2_p; %Structure mass  [kg]
m_2_pay = 0; %Payload mass [kg]
T_2_vac = 800683.553; %vacuum thrust [N]
Isp_2_vac = 340; %vacuum specific impulse [s]
tb_2 = 375; %burn time [s]
D_2 = 3.66; %Diameter [m]
A_2 = pi*D_2^2/4; %Area [m^2]
C_D_2 = 1.14; %drag coefficient
f9_secondstage = stage(m_2_i, m_2_p, ...
			m_2_s, m_2_pay, 'NA', T_2_vac, 'NA', Isp_2_vac, tb_2, ... 
			D_2, A_2, C_D_2);

%Dragon capsule (third stage) data to LEO
m_3_i = m_tot_i - m_1_i - m_2_i; %Total mass of the Dragon Capsule
m_3_pay = 13150; %Total LEO payload mass of Dragon capsule [kg]
D_3 = 5.2; %Diameter [m]
A_3 = pi*D_3^2/4; %Area [m^2]
C_D_3 = 1.14; %drag coefficient
f9_capsule = stage(m_3_i, 'NA', 'NA', m_3_pay, ... 
			'NA', 'NA', 'NA', 'NA', ...
			'NA', D_3, A_3, C_D_3);
        
%Define the Falcon 9 rocket at the object level
f9 = rocket(m_tot_i, f9_firststage, f9_secondstage, f9_capsule);

%Physical Constants
g_SL = 9.81;     	%Acceleration due to gravity at sea level [m/s^2]
rho_SL = 1.225;		%Density of air at sea level [kg/m^3]
R_earth = 6371000;  %Radius of the earth [m]
cons = constants(g_SL, rho_SL, R_earth);

%Rocket Up
%Initial conditions for ode45 simulation of rocket going up
h_0 = 0;     % Initial altitude of rocket above Earth's surface [m]
u_0 = 0;	 % Initial rocket velocity [m/s]
m_0 = f9.m_tot_i; %Initial rocket mass [kg]

%Change tspan for burn time
tspan = [0 f9.firststage.tb];     %Simulation Time interval [s]

% Call ode45 to solve the equation of motion ODE
%options = odeset('RelTol', 1e-100);  %increases tolerances to avoid rounding errors
[t,s] = ode45(@eom_up, tspan, [h_0, u_0, m_0], [], f9, cons);

%Plot the values of interest over time
figure()
plot(t,s(:,1));  % h vs. t
title('Altitude of the Rocket vs. Time');
xlabel('Time (s)');
ylabel('Altitude (m)');

figure();
plot(t,s(:,2)); % u vs. t
title('Velocity of the Rocket vs. Time');
xlabel('Time (s)');
ylabel('Velocity (m/s)');

figure();
plot(t,s(:,3)); % m vs. t
title('Mass of the Rocket vs. Time');
xlabel('Time (s)');
ylabel('Mass (kg)');

%Rocket Down
%Initial conditions on the way down
hdown_0 = s(end,1); %firststage height at detach [m]
udown_0 = s(end,2); %firststage velocity at detach [m/s] 
mdown_0 = f9.firststage.m_i - (f9.m_tot_i - s(end,3)); %firststage total mass at detach [kg]

%Change tspan for burn time
tspan = [0 550]; %550 Arbitrary to guarentee code time to converge

%Call ode45 to solve the equation of motion ODE
options = odeset('RelTol', 1e-100);  %increases tolerances to avoid rounding errors
[t,s] = ode45(@eom_down, tspan, [hdown_0, udown_0, mdown_0], options, f9, cons);

%Plot the values of interest over time
figure()
%subplot(1,3,1)
plot(t,s(:,1));  % h vs. t
title('Altitude of the Reusable Stage vs. Time');
xlabel('Time (s)');
ylabel('Altitude (m)');

figure();
%subplot(1,3,2)
plot(t,s(:,2)); % u vs. t
title('Velocity of the Reusable Stage vs. Time');
xlabel('Time (s)');
ylabel('Velocity (m/s)');

figure();
%subplot(1,3,3)
plot(t,s(:,3)); % m vs. t
title('Mass of the Reusable Stage vs. Time');
xlabel('Time (s)');
ylabel('Mass (kg)');

disp('End Height = ');
disp(s(end,1));
disp('End Velocity = ');
disp(s(end,2));
disp('End Mass = ');
disp(s(end,3));