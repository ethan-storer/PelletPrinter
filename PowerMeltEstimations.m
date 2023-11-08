% Estimation to melt plastic
% IN MWETRIC UNTIDS FOR THEL OVE OF DGOR
% The deep magic:
clc
clear
close all

% Start with one plastic at a time!!
% Q Solid + Q Melt + Q Liquid

%% SAUCE
% PP: chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://iopscience.iop.org/article/10.1088/1757-899X/412/1/012070/pdf#:~:text=As%20a%20result%20of%20calculation,8%2C%2010%2D11%5D.
% PP: https://www.engineeringtoolbox.com/specific-heat-capacity-d_391.html

% PLA: https://www.sciencedirect.com/science/article/pii/S0021961404000990#:~:text=For%20100%25%20crystalline%20PLA%2C%20the,1%20at%20T%3D480%20K.
% PLA: chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://www.polyfluor.nl/assets/files/datasheet-pla-filament-uk.pdf




%% Volumetric Properties

% Volume of filament being melted at a given moment
% Filament melts in the nozzle, which is ~12 mm long
% Assuming 1.75 mm diameter filament

% you are my density [kg/mm^3]
PLA_dens = 1.25; % g/cm^3
PLA_dens = (1.25/1000)/1000; % kg/mm^3



%% Estimating Volume flow for filament printer

% These will probably end up becoming arrays for a plot...

Print_Speed = linspace(30, 100, 20); % mm/sec (actual PrusaSlicer settings average around 30-40
% Ender-3 runs around 40 mm/sec on PrusaSlicer settings

Nozzle_Diameter = [0.4 0.6 0.8 1]; % mm

%% Plastc Thermal Properties
% Plastics of Interest:
% PLA, need density
% PP, in progress
% PETG, in progress

T_room = 60; % °C

% Conversion factors:
molmass_PLA = 88/1000; %kg/mol


% Liquid Specific Heats [J/kg°C]
cp_liq_PLA = 120.17; %J/K*mol
cp_liq_PLA = cp_liq_PLA/molmass_PLA; %J/kg°C


% Solid Specific Heats (convert to [J/kg°C])
cp_PP = 1920; %J/kg°C

change_cp_PLA = 43.8; % J/K*mol
change_cp_PLA = change_cp_PLA/molmass_PLA; %J/kg°C
cp_solid_PLA = change_cp_PLA + cp_liq_PLA; %J/kg°C


% Melting Temps (convert to [°C])
Tmelt_PP = 161.8; %°C
Tmelt_PLA = 158.85; %°C, assuming upper range to assume greater heat to melt


% Heats of Fusion (converr to [J/kg])
fus_PP = 72.0; %J/g
fus_PP = fus_PP*1000; %J/kg

fus_PLA = 6.55; %kJ/mol
fus_PLA = (fus_PLA/molmass_PLA)*1000; %J/kg


%% Heat of Filament PLA
yeet = estimatorLoop(PLA_dens, cp_solid_PLA, fus_PLA, Print_Speed, Nozzle_Diameter, Tmelt_PLA, T_room);



