%calc_gfaye(g_atm_and_s_mw,g_atm_and_s_mw_longitudes,g_atm_and_s_mw_latitudes,tc,Latitude_grid,Longitude_grid)
% calculates faye anomily by removing terrain correction from g_atm_and_s_mw.
% INPUT -
% 1. g_atm_and_s_mw (double)- medium and short wave anomaly(mGals)
% 2. g_atm_and_s_mw_longitudes(double) - Latitude(degrees) vector on which g_atm_and_s_mw is mapped
% 3. g_atm_and_s_mw_latitudes(double) - Latitude(degrees) vector on which g_atm_and_s_mw is mapped
% 4. tc (mGals) - Terrain correction calculated using <a href="matlab:help terrain_correction.m">terrain_correction</a>
% 5. Latitude_grid(double) - Latitude(degrees) matrix used for tc 
% 6. Longitude_grid(double) - Longitude(degrees) matrix used for tc 
% OUTPUT - 
% gfaye(mGals) over Latitude and Longitude grid
% TIP- 
% Use <a href="matlab:help create_grid.m">create_grid</a> for forming Latitude and Longitude grids.

function gfaye = calc_gfaye(g_atm_and_s_mw,g_atm_and_s_mw_longitudes,g_atm_and_s_mw_latitudes,tc,Latitude_grid,Longitude_grid)


g_atm_and_s_mw = griddata( g_atm_and_s_mw_latitudes,g_atm_and_s_mw_longitudes,g_atm_and_s_mw, Latitude_grid, Longitude_grid);
gfaye = g_atm_and_s_mw - tc;
end