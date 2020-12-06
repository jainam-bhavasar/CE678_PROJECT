% calc_FAC(lat, ellipType, height) calculates a 2nd order free air
% correction to a reference surface given a latitude or height (orthometric)
%
% Inputs:
% lat (double) Geodetic latitude (decimal degrees)
% Ellipsoid (struct) ellipsoid parameters
%  orthometric height (m)
%
% Output:
% fac (double) free air correction (mGal)
%

function fac=calc_FAC(lat, Ellipsoid, height)
%% Convert latitude from decimal degrees to radians
latr = lat*pi/180;
sinlatr2 = (sin(latr)).^2;
% Calculate normal gravity on the ellipsoid at the given latitude
normGrav = calc_gnorm_ellip_surface(lat, Ellipsoid);
% Calculate ellipsoid parameter m
m = Ellipsoid.omega^2*Ellipsoid.a^2*Ellipsoid.b/Ellipsoid.GM;
% 2nd order free air correction: formula 16 for ellipsoid reference surface
% and equation 23 for geoid reference surface from the GRAV-D General User
% Manual
c1 = (-2*normGrav)/Ellipsoid.a;
term1 = (1 + Ellipsoid.f + m - 2*Ellipsoid.f.*sinlatr2).*height;
c2 = (3.*normGrav./(Ellipsoid.a^2));
term2 =height.^2;

fac = (c1.*term1) + (c2.*term2);
end
%----------------