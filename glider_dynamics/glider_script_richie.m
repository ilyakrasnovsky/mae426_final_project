%Script that solves the equation of motion ODEs for a rotating satellite
%with a nutation damper (particle-spring-damper-slot system). The particle
%position, satellite angular velocity in the b_1 and b_3 directions are 
%plotted against time. 

close all;
clear;
clc;

%General constants

time_total = 500;
tspan = [0 time_total];     % Time interval [s]
m = 20000;        % Mass of glider [kg]
AR = 7;         %Aspect ratio
Span = 20;         %Wingspan [m]
S = sqrt(AR*Span);          % Wing area [m^2]
CL = 0.5;             % Lift Coefficient [m]
CD = 1.14;             % Drag Coefficient [rad/s]
g = 9.8;               %Gravity [m/s^2]

%Initial conditions

s1_0 = 10;       % Initial glider velocity [m/s]
s2_0 = -90;      % Initial glider flight angle [deg]
s3_0 = 3.5e5;     % Initial height [m]
s4_0 = 0;      % Initial range [m]
               
% Call ode45 to solve the equation of motion ODEs for the particle and the
%satellite

%options = odeset('RelTol', 1e-100);  %increases tolerances to avoid rounding errors

[t,s] = ode45(@glider,tspan,[s1_0,s2_0,s3_0,s4_0],[],m,S,CL,CD,g);

J = find(diff(sign(s(:,3))))
time_land = 500*J/length(s(:,3))
K = find(diff(sign(s(:,1))));
time_stop = time_total*K/length(s(:,1))
%iterate to get time_land = time_stop (land when velocity is zero)

%Plot the values of interest over time

figure(1)
plot(t,s(:,1));  % y vs. t
title('Velocity of the Glider vs. Time');
xlabel('Time (s)');
ylabel('Velocity (m/s)');

% figure(2);
% plot(t,s(:,2)*180/pi); % omega_1 and omega_3 vs. t
% title('Glider Flight Angle vs. Time');
% xlabel('Time (s)');
% ylabel('Glider Flight Angle (deg)');

figure(3);
plot(t,s(:,3)); % omega_1 and omega_3 vs. t
title('Glider Altitude vs. Time');
xlabel('Time (s)');
ylabel('Altitude (m)');

% figure(4);
% plot(t,s(:,4)); % omega_1 and omega_3 vs. t
% title('Glider Range vs. Time');
% xlabel('Time (s)');
% ylabel('Glider Range (m)');