function Tr = calc_disturb_potential(Latitude_grid,Longitude_grid,gfaye)
    %calc_disturb_potential(H,Latitude_grid,Longitude_grid,gfaye)
    %calculates disturbing potential Tr over given Latitude,Longitude grid
    %using gfaye
    %INPUT - 
    %1. Latitude grid (double) -(degrees) Latitude grid used for gfaye
    %2. Longitude grid (double) -(degrees) Longitude grid used for gfaye
    %3. gfaye(double) - (mGals)gfaye grid over the latitude and longitude grid
    %Help-
    %Help for forming grid -<a href="matlab:help create_grid.m"> create_grid c</a>
    %Calculating gFaye - <a href="matlab:help calc_gfaye">calc_gfaye</a>

    %finding out center of Latitude and Longitude grid
    max_lat = max(Latitude_grid(:));
    min_lat = min(Latitude_grid(:));
    max_lon = max(Longitude_grid(:));
    min_lon = min(Longitude_grid(:));
    lat_center = (max_lat+min_lat)/2;
    lon_center = (max_lon+min_lon)/2;

    %Finding stokes equation matrix
    %finding si ,sin(si/2),sin(si/2)^2 which will be input to stokes equation
    si_term1 = sind((Latitude_grid-lat_center)/2).^2;
    si_term2 = (sind((Longitude_grid-lon_center)/2).^2).*(cosd(lat_center)*cosd(Latitude_grid));
    si = acosd(1-2*(si_term1+si_term2));
    
    sin_si_by_2 = sind(si./2);
    sin_si_by_2_square = si_term1+si_term2;

    %finally, forming the stokes equation using sin_si_by_2 and sin_si_by_2_square
    stokes = 1./sin_si_by_2 -4-6*sin_si_by_2 + 10*sin_si_by_2_square - (3-6*sin_si_by_2_square) - log(sin_si_by_2+sin_si_by_2_square);
    %modifying stokes kernel
    cx = ceil(size(stokes,1)/2);
    cy = ceil(size(stokes,2)/2);
    stokes(cx,cy)=(4*sqrt(pi/((0.01*pi/180)^2*cosd(((Latitude_grid(cx,cy)))))));
    
    %constant R/4pi
    R = 6378137.0;
    c = R/(4*pi);

    %Calculating Integration

    Tr_term1 = gfaye.*cosd(Latitude_grid);
    Tr_term2 = stokes;

    %adding padding
    Tr_term1 = addPadding_full(Tr_term1);
    Tr_term2 = addPadding_full(Tr_term2);
    
    %Applying FFT
    Tr_stokes_fft = fft2(fftshift(Tr_term2));
    Tr_g_fft = fft2(Tr_term1);

    Tr = c*((0.01*(pi/180))^2)*ifft2(Tr_stokes_fft.*Tr_g_fft);
    Tr = Tr(1+end/3:2*end/3,1+end/3:2*end/3);
end