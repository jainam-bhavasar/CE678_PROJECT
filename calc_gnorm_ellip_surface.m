% calc_gnorm_ellip_surface(lat, ellipType) calculates normal gravity values on the surface
% of the ellipsoid at the given latitude.
%
% Inputs:
% lat (double) geodetic latitude (decimal degrees)
% ellipsoid (struct) ellipsoid parameters
%
% Output:
% gnorm (double) normal gravity on the surface of the ellipsoid at
% given latitude (mGal)
%
function gnorm=calc_gnorm_ellip_surface(lat, Ellipsoid)

%% Convert from decimal degrees to radians
latr=lat*pi()/180;
% Somigliana-Pizetti normal gravity formula. Equation 19 from GRAV-D
% General User manual
n1 = Ellipsoid.a.*Ellipsoid.gammaEquator.*(cos(latr)).^2 + Ellipsoid.b.*Ellipsoid.gammaPole.*(sin(latr)).^2;
d1 = sqrt(Ellipsoid.a^2.*(cos(latr)).^2 + Ellipsoid.b^2.*(sin(latr)).^2);
gnorm = n1./d1;
end