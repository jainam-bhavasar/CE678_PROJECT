% calc_Disturbance(lat, height, ffg, method) calculates either a gravity
% disturbance or a free air disturbance given a certain latitude, height,
% and full field gravity value. The user must select with method they wish % to use: confocal (1 step) disturbance, or Free Air Correction (2 step)
% Free Air Disturbance.
% Inputs
%   lat (double)
%   height (double)
%   ffg (double)
%   ellipType (string)
%   method (int)
%
% Output
% Disturbance %
% Geodetic latitude (decimal degrees)
% ELLIPSOIDAL height (m)
% Full-Field Gravity at Altitude (mGal)
% 
% Gravity disturbance or Free Air Disturbance
% depending on method choice (mGal)
function Disturbance = calc_Disturbance(lat, height, ffg) 
%% Define ellipsoid parameters
Ellipsoid = make_Ellipsoid('WGS84');

fac = calc_FAC(lat, Ellipsoid, height); 
gnorm = calc_gnorm_ellip_surface(lat, Ellipsoid); % normal gravity
Disturbance = ffg - fac -gnorm;
% Calculate Free Air Disturbance if method 2 is selected

% free air correction gnorm = calc_gnorm_ellip_surface(lat, Ellipsoid); % normal gravity Disturbance = ffg - fac - gnorm;
% Give error and return control to invoking function if neither method 1 nor % 2 was chosen.

    fprintf('Method must either be a 1 or 2');
    return
end 
