%calc_gfaye(g_atm_and_s_mw,g_atm_and_s_mw_longitudes,g_atm_and_s_mw_latitudes,tc,Latitude_grid,Longitude_grid)
% calculates faye anomily by removing terrain correction from g_atm_and_s_mw.
% INPUT -
% 1. g_atm_and_s_mw (double)- medium and short wave anomaly(mGals)
% 2. files - files - array of strings - each string containg file path of DEM file  
% 3. Latitude_grid(double) - Latitude(degrees) matrix used for tc 
% 4. Longitude_grid(double) - Longitude(degrees) matrix used for tc 
% 5. res(double) - (degrees) spacing between 2 longitudes/spacing between 2
% OUTPUT - 
% gfaye(mGals) over Latitude and Longitude grid
% TIP- 
% Use <a href="matlab:help create_grid.m">create_grid</a> for forming Latitude and Longitude grids.
% TIP- 
% put same resolution that you took when downloading ggm and geoid data
% from <a href="matlab:web('http://icgem.gfz-potsdam.de/calcgrid','-browser')">here</a>
function gfaye = calc_gfaye(g_atm_and_s_mw,files,Latitude_grid,Longitude_grid,res)

H = combine_DEM_data(files,Latitude_grid,Longitude_grid);
tc = terrain_correction(H,Latitude_grid,Longitude_grid,res);
gfaye = g_atm_and_s_mw - tc;
end