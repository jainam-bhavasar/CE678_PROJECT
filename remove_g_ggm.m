% remove_g_ggm(g_faa,g_ggm) calculates ong- wavelength gravity anomaly ( ∆gGGM) 
% by removing the effect of a global gravity field model from free air anomily values
% Inputs:
% g_faa   (double) - corresponding free air anomalies (mGals) 
% g_ggm   (double) - corresponding global gravity (mGals) 
% 
%
% Output:
% g_msw   (double) - reduced gravity anomaly ∆gs&mw contains only the medium and the short wave- lengths.
% mapped over latitude and longitude of both g_ggm and f_faa
% IMP - Ensure that  g_faa and g_ggm are both imorted and calculated over same latitude and longitude vector
% TIP1 - Use <a href="matlab:help calc_free_air_anomaly"> calc_free_air_anomaly</a> for calculating g_faa
% TIP2 - Use <a href="matlab:help import_grav_anomaly"> import_grav_anomaly</a> for importing g_ggm
function g_msw = remove_g_ggm(g_faa,g_ggm)
    g_ggm = griddata(lat_ggm, lon_ggm, g_ggm, lat_faa, lon_faa, "nearest");
    g_msw = g_faa - g_ggm;
end