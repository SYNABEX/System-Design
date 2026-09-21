%Formulas: Vrms = sqrt((1/N)*sum(v_n^2))          (eq. 3)
%            Irms = sqrt((1/N)*sum(i_n^2))          (eq. 3)
%            S    = Vrms * Irms
%            P    = (1/N)*sum(v_n * i_n)
%            pf   = P / S




% Data set measured by the volatge sensor and current sensors in time of
% six seconds 
N = 6;
time = (1:N)';
Voltage_measured = [228 228 230 230 229 227];   % V, from ZMPT101B
I_fan_measured    = [0.5702 0.5702 0.5652 0.5652 0.5677 0.5727];% A, ACS712 on fan
I_bulb_measured   = [0.0789 0.0789 0.0783 0.0783 0.0786 0.0792];   % A, ACS712 on bulb
I_heater_measured = [13.1579 13.1579 13.0435 13.0435 13.1004 13.2159]; %ACS712 on heater
I_total_measured = I_fan_measured + I_bulb_measured + I_heater_measured;

Vrms = zeros(N,1);
I_fan_rms = zeros(N,1);
I_bulb_rms = zeros(N,1);
I_heater_rms = zeros(N,1);
I_total_measured_rms = zeros(N,1);

%Now let calculate Vrms 
for i = 1:(N)
    Vrms(i) = sqrt( (1/i) * sum(Voltage_measured(1:i).^2) );
    I_fan_rms(i) = sqrt( (1/i) * sum(I_fan_measured(1:i).^2) );
    I_bulb_rms(i) = sqrt( (1/i) * sum(I_bulb_measured(1:i).^2) );
    I_heater_rms(i) = sqrt( (1/i) * sum(I_heater_measured(1:i).^2) );
    I_total_measured_rms(i) = sqrt( (1/i) * sum(I_total_measured(1:i).^2) );
end

figure(1),hold on
plot(time,Voltage_measured,    '-o' , 'color',  [0.85 0.1 0.1] , 'LineWidth',1.2)
plot(time,Vrms,    '-o' ,'color',    [0.9 0.6 0] ,  'LineWidth',  1.2)
grid on
xlabel("Time",'fontsize' , 12) ,  ylabel ("Volatge", 'fontsize',12)
legend({'Measured Voltage', 'Root Mean square Volatge'})
title('measured vs RMS')

figure(2)
subplot(411),hold on
plot(time, I_total_measured,    '-o' , 'color',  [0.85 0.1 0.1] , 'LineWidth', 1.2)
plot(time, I_total_measured_rms,    '-o' ,'color',    [0.9 0.6 0] ,  'LineWidth',   1.2)
grid on
xlabel("Time",'fontsize' , 12) ,  ylabel ("Volatge", 'fontsize',12)
legend({'Measured Current', 'Root Mean square Current'})
title('measured vs RMS')

subplot(412),hold on
plot(time, I_bulb_measured,    '-o' , 'color',  [0.85 0.1 0.1] , 'LineWidth', 1.2)
plot(time,I_bulb_rms,    '-o' ,'color',    [0.9 0.6 0] ,  'LineWidth',  1.2)
grid on
xlabel("Time",'fontsize' , 12) ,  ylabel ("Volatge", 'fontsize',12)
legend({'Measured bulb current', 'Root Mean square current'})
title('measured vs RMS')

subplot(413),hold on
plot(time,I_fan_measured,    '-o' , 'color',  [0.85 0.1 0.1] , 'LineWidth', 1.2)
plot(time,I_fan_rms,    '-o' ,'color',    [0.9 0.6 0] ,  'LineWidth',   1.2)
grid on
xlabel("Time",'fontsize' , 12) ,  ylabel ("Volatge", 'fontsize',12)
legend({'Measured Voltage', 'Root Mean square Volatge'})
title('measured vs RMS')

subplot(414),hold on
plot(time,I_heater_measured,    '-o' , 'color',  [0.85 0.1 0.1] , 'LineWidth', 1.2)
plot(time,I_heater_rms,    '-o' ,'color',    [0.9 0.6 0] ,  'LineWidth',   1.2)
grid on
xlabel("Time",'fontsize' , 12) ,  ylabel ("Volatge", 'fontsize',12)
legend({'Measured Voltage', 'Root Mean square Volatge'})
title('measured vs RMS')


%now to calculate power
P_bulb_measured =Voltage_measured .* I_bulb_measured ;
P_fan_measured =Voltage_measured .* I_fan_measured ;
P_heater_measured =Voltage_measured .* I_heater_measured ;
P_total = P_bulb_measured + P_fan_measured+ P_heater_measured ;

figure(3), hold on
plot(time,P_bulb_measured,    '-o' , 'color',  [0.85 0.1 0.1] , 'LineWidth', 1.2)
plot(time, P_fan_measured,    '-o' ,'color',    [0.9 0.6 0] ,  'LineWidth',  1.2)
plot(time, P_heater_measured,    '-o' ,'color',    [0.72 0.10 0.47] ,  'LineWidth',  1.2)
plot(time, P_total,    '-o' ,'color',   [0.00 0.45 0.74] ,  'LineWidth',   2)
grid on
xlabel("Time",'fontsize' , 12) ,  ylabel ("Power", 'fontsize',12)
legend({'Measured power'})
title('Power against time')

%now let calculate apparant power over time
 

S_Power_bulb = Vrms .*  I_bulb_rms;
S_Power_fan = Vrms .*  I_fan_rms;
S_Power_heater = Vrms .*  I_heater_rms;
S_Power_total = S_Power_bulb +S_Power_fan +S_Power_heater;

figure(4), hold on
plot(time,S_Power_bulb,    '-o' , 'color',  [0.85 0.1 0.1] , 'LineWidth', 2)
plot(time,S_Power_fan,    '-o' ,'color',    [0.9 0.6 0] ,  'LineWidth',   2)
plot(time,S_Power_heater  ,    '-o' ,'color',    [0.72 0.10 0.47] ,  'LineWidth',   2)
plot(time, S_Power_total,    '-o' ,'color',   [0.00 0.45 0.74] ,  'LineWidth',   2)
grid on
xlabel("Time",'fontsize' , 12) ,  ylabel ("Power", 'fontsize',12)
legend({'Measured  Apparant power'})
title(' Apparant Power against time')

E_bulb_kWh   = cumtrapz(time,P_bulb_measured')   / 3600 / 1000;
E_fan_kWh    = cumtrapz(time,P_fan_measured')    / 3600 / 1000;
E_heater_kWh = cumtrapz(time,  P_heater_measured') / 3600 / 1000;
E_total_kWh  = cumtrapz(time, P_total')  / 3600 / 1000;

figure(5);
plot(time, E_bulb_kWh, 'r-o', 'LineWidth', 1.2); hold on;
plot(time, E_fan_kWh, 'g-o', 'LineWidth', 1.2);
plot(time, E_heater_kWh, 'm-o', 'LineWidth', 1.2);
plot(time, E_total_kWh, 'k-o', 'LineWidth', 1.6);
grid on; xlabel('Time (s)'); ylabel('Energy (kWh)');
legend('Bulb','Fan','Heater','Total','Location','best');
title('Cumulative energy per load (\int P \, dt)');

% ---- Build a results struct so you can query any value by name ----
results.time = time;

results.P_bulb   = P_bulb_measured;
results.P_fan    = P_fan_measured;
results.P_heater = P_heater_measured;
results.P_total  = P_total;

results.E_bulb   = E_bulb_kWh;
results.E_fan    = E_fan_kWh;
results.E_heater = E_heater_kWh;
results.E_total  = E_total_kWh;

results.S_bulb   = S_Power_bulb;
results.S_fan    = S_Power_fan;
results.S_heater = S_Power_heater;
results.S_total  = S_Power_total;

% ---- Final summary (one number per load) ----
summary.E_bulb_total   = E_bulb_kWh(end);
summary.E_fan_total    = E_fan_kWh(end);
summary.E_heater_total = E_heater_kWh(end);
summary.E_total        = E_total_kWh(end);

disp(summary)

%case scenario
N_case =6;
time_case = (1:N_case)';

fan_on = [ 1 1 1 0 0 0]';

%now let use cases
current_bulb_case = I_bulb_measured';
current_heater_case = I_heater_measured';
current_fan_case = I_fan_measured' .* fan_on;
V_case = Voltage_measured';
%power used
P_bulb_case = V_case .* current_bulb_case;
P_heater_case = V_case .* current_heater_case;
P_fan_case = V_case .* current_fan_case ;

P_total_case = P_bulb_case + P_heater_case + P_fan_case;
E_total_case = cumtrapz(time_case, P_total_case ) / 3600 / 1000;   % kWh

% ---- Plot: shows the drop when fan turns off ----
figure(6), hold on
plot(time_case, P_fan_case,   '-o', 'Color', [0.9 0.6 0],    'LineWidth', 2)
plot(time_case, P_total_case, '-o', 'Color', [0.00 0.45 0.74], 'LineWidth', 2)
grid on
xlabel('Time (s)'), ylabel('Power (W)')
legend('Fan Power', 'Total Power')
title('Case Scenario: Fan Switches OFF at t = 4s')

figure(7),hold on
plot(time_case, E_total_case, '-o', 'Color', [0.00 0.45 0.74], 'LineWidth', 2)
plot(time, E_total_kWh, 'k-o', 'LineWidth', 1.6);

grid on
xlabel('Time (s)'), ylabel('Cumulative Energy (kWh)')
legend({'full load ', 'load after fan is off'})
title('Total Energy — growth slows once fan is OFF')

%% ---- Build the results table ----
results = table(time, Voltage_measured', Vrms, ...
    I_bulb_measured', I_bulb_rms, I_fan_measured', I_fan_rms, ...
    I_heater_measured', I_heater_rms, ...
    P_bulb_measured', P_fan_measured', P_heater_measured', P_total', ...
    S_Power_bulb, S_Power_fan, S_Power_heater, S_Power_total, ...
    E_bulb_kWh, E_fan_kWh, E_heater_kWh, E_total_kWh, ...
    'VariableNames', {'Time_s','V_measured','Vrms', ...
    'I_bulb_measured','Irms_bulb','I_fan_measured','Irms_fan', ...
    'I_heater_measured','Irms_heater', ...
    'P_bulb_W','P_fan_W','P_heater_W','P_total_W', ...
    'S_bulb_VA','S_fan_VA','S_heater_VA','S_total_VA', ...
    'E_bulb_kWh','E_fan_kWh','E_heater_kWh','E_total_kWh'});

%---- Export to CSV ----
writetable(results, 'measured_dpb_dataset.csv');
disp('Dataset exported successfully.')




    



