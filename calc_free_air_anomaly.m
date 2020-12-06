% calc_free_air_anomaly(g_observed,lat,ellipsoid,height) calculates free
% air anomaly by removing normal gravity and free air corrections from
% observed gravity values
% Inputs:
% lat (double) -  Geodetic latitude (decimal degrees) 
% g_observed (double) - corresponding observed gravity values (mGals) to respective latitude
% Ellipsoid (struct) ellipsoid parameters (from <a href="matlab:help make_Ellipsoid">make_Ellipsoid</a> function)
% height -  corresponding orthometric height (m) to respective latitude
%
% Output:
% fac (double) free air correction (mGal)
%
function anomaly = calc_free_air_anomaly(g_observed,lat,ellipsoid,height)
    %calling calc_FAC and calc_gnorm_ellip_surface
    %using formula g_anomaly = g_observed - g_free_air_correction - gamma_normal_gravity
    anomaly = g_observed - calc_FAC(lat,ellipsoid,height) - calc_gnorm_ellip_surface(lat,ellipsoid);
end
