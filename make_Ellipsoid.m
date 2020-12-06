%----------------------------------------------------------------------------
% get_Ellipsoid(ellipType) returns a structure containing ellipsoid
% parameters for the 'WGS84' and the 'GRS80' ellipsoids.
%
% Input:
% ellipType (string) Accepts 'WGS84' or 'GRS80'
%
% Output: ellipsoid (Struct)
% fields: GM (double) Earth's Gravitational Constant(m^3/s^2)
% omega (double) Angular Velocity of Earth (rad/s)
% gammaEquator (double) Equatorial Normal Gravity (mGal)
% gammaPole (double) Polar Normal Gravity (mGal)
% a (double) Semi-major Axis (m)
% b (double) Semi-minor Axis (m)
% e (double) first eccentricy (unitless)
% e2 (double) first ecentricity squared (unitless)
% f (double) flattening (unitless)

%
function [ellipsoid] = make_Ellipsoid(ellipType)

switch ellipType
 case 'WGS84'
 ellipsoid.GM = 3986004.418E8;
 ellipsoid.omega = 7.292115e-5;
 ellipsoid.gammaEquator = 978032.53359;
 ellipsoid.gammaPole = 983218.49378;
 ellipsoid.a = 6378137.0;
 ellipsoid.b = 6356752.3142;
 ellipsoid.e = 8.1819190842622.*1E-2; %first eccentricity
 ellipsoid.e2 = 6.69437999014.*1E-3; %first eccentricity squared
 ellipsoid.f = 1/298.257223563; %flattening
 %WGS84 defining parameters from NIMA (2004).
 case 'GRS80'
 ellipsoid.GM=3986005E8;
 ellipsoid.omega=7.292115e-5;
 ellipsoid.gammaEquator=978032.67715;
 ellipsoid.gammaPole = 983218.63685;
 ellipsoid.a = 6378137;
 ellipsoid.b = 6356752.3142;
 ellipsoid.e = 0.081819190842622; %first eccentricity
 ellipsoid.e2 = 0.00669437999014; %first eccentricity squared
 ellipsoid.f = 0.00335281066474; %flattening
 %GRS80 defining parameters from Moritz (2000).
 otherwise
 warning('This ellipsoid is not supported')
 return
end
end
%------------------------------------------------------