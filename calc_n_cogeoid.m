%
function N_cogeoid = calc_n_cogeoid(Nr,N_ggm,ggm_Latitudes,ggm_longitudes,Latitude_grid,Longitude_grid)
    N_ggm = griddata(ggm_longitudes, ggm_Latitudes, N_ggm,  Longitude_grid, Latitude_grid);
    N_cogeoid = Nr+N_ggm;
end