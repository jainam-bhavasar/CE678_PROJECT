function h = calc_orthometric_height(ellipsoidal_height,n_ggm)
%calc_orthometric_height(ellipsoidal_height,n_ggm) - calculates orthometric height
%
%    INPUT
%    1. Ellipsoidal height(meters)(double)
%    2. nggm(meters)(double) - Geoid height from nggm model.   
%    IMP- ellipsoidal_height and n_ggm should be mapped over same latitude and longitudes
%    TIP- import ellipsoidal_height and n_ggm using  <a href="matlab:help import_airborne_gravity_data">import_airborne_gravity_data</a> and <a href="matlab:help import_geoid_heights">import_geoid_heights</a>  
%    to ensure same latitudes and longitudes for both vectors

h = ellipsoidal_height+n_ggm;    
end