function Nr = calc_undulation(Tr,Latitude_grid,Ellipsoid)
    gamma = calc_gnorm_ellip_surface(Latitude_grid,Ellipsoid);
    Nr = Tr./gamma;
end