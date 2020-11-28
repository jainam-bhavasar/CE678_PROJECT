% remove_g_ggm(lat_faa,lon_faa,g_faa,lat_ggm,lon_ggm,g_ggm) calculates ong- wavelength gravity anomaly ( ∆gGGM) 
%by removing the effect of a global gravity field model from free air anomily values
% Inputs:
% lat_faa (double) - Geodetic latitude (decimal degrees) of corresponding free air anomily 
% lon_faa (double) - Geodetic longitude (decimal degrees) of corresponding free air anomily 
% g_faa   (double) - corresponding free air anomalies (mGals) to respective latitude
% lat_ggm (double) - Geodetic latitude (decimal degrees) of corresponding global gravity
% lon_ggm (double) - Geodetic longitude (decimal degrees) of corresponding global gravity
% g_faa   (double) - corresponding global gravity (mGals) to respective latitude
% 
%
% Output:
% g_msw   (double) - reduced gravity anomaly ∆gs&mw contains only the medium and the short wave- lengths.
% mapped over lat_faa,lon_faa
function g_msw = remove_g_ggm(lat_faa,lon_faa,g_faa,lat_ggm,lon_ggm,g_ggm)
    g_ggm = griddata(lat_ggm, lon_ggm, g_ggm, lat_faa, lon_faa, "nearest");
    g_msw = g_faa - g_ggm;
end