function gfaye = calc_gfaye(g_atm_and_s_mw,g_atm_and_s_mw_longitudes,g_atm_and_s_mw_latitudes,tc,Latitude_grid,Longitude_grid)

%calc_gfaye - Description
%
% Syntax: gfaye = calc_gfaye(input)
%
% Long description
g_atm_and_s_mw = griddata( g_atm_and_s_mw_latitudes,g_atm_and_s_mw_longitudes,g_atm_and_s_mw, Latitude_grid, Longitude_grid);
gfaye = g_atm_and_s_mw - tc;
end