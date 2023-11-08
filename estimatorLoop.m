
function Power = estimatorLoop(density, heat_capacity, heat_fusion, print_speeds, ...
    nozzle_diameters, melt_temp, room_temp)
Power = [];


for  i = [0.4 0.6 0.8 1]
    i
% Get mass flow
nozzle_area = pi()*(i).^2; % mm^2
volumetric_flow = nozzle_area .* print_speeds; % mm^3/sec
mass_flow = volumetric_flow * density; % kg/sec

% Get power for heating up
P_solid = mass_flow * heat_capacity * (melt_temp - room_temp);

% Get power for melting
P_melt = mass_flow * heat_fusion;

% Total
Power = P_melt + P_solid
print_speeds


plot(print_speeds, Power)
hold on
end

xlabel("Print Speed [mm/sec]")
ylabel("Power [Watts]")
title('Maximum Print Speed at Selected Nozzle Diameters for PLA')
legend('0.4 mm nozzle', '0.6 mm nozzle', '0.8 mm nozzle', '1 mm nozzle')
yline(40,'-',{'Ender-3 Maximum Wattage'});


end