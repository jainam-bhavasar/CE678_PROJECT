function h = calc_orthometric_height(ellipsoidal_height,n_ggm)
%calc_orthometric_height - Description
%
% Syntax: h = calc_orthometric_height(input)
%
% Long description
h = ellipsoidal_height+n_ggm;    
end