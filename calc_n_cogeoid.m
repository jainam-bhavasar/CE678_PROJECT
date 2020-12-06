%calc_n_cogeoid(Nr,N_ggm,ggm_Latitudes,ggm_longitudes,Latitude_grid,Longitude_grid)
% calculates co-geoid height by adding initial undulation to Nggm.
% INPUT -
% 1. Nr - Geoid Undulation calculated using stokes integral
% 2. N_ggm - geoid heights from ggm model imported.
% 3. ggm_Latitudes (double)  - Latitude(degrees) vector on which N_ggm is mapped
% 4. ggm_longitudes (double) - Longitude(degrees) vector on which N_ggm is mapped
% 5. Latitude_grid(double)   - Latitude(degrees) matrix used for Nr
% 6. Longitude_grid(double)  - Longitude(degrees) matrix used for  Nr 
% OUTPUT - 
% gfaye(mGals) over Latitude and Longitude grid
% TIP- 
% Nr - use <a href="matlab:help calc_undulation">calc_undulation</a>
% Nggm - use <a href="matlab:help import_geoid_heights">import_geoid_heights</a>
function N_cogeoid = calc_n_cogeoid(Nr,N_ggm,ggm_Latitudes,ggm_longitudes,Latitude_grid,Longitude_grid)
    N_ggm = griddata(ggm_longitudes, ggm_Latitudes, N_ggm,  Longitude_grid, Latitude_grid);
    N_cogeoid = Nr+N_ggm;
end