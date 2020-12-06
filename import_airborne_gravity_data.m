%
% import_airborne_gravity_data(filepath) imports the observed airborne gravity 
%   data (gobserve) of any tile from < https://geodesy.noaa.gov/ GRAV-D/data_products.shtml here >
%  
%
% Inputs:
% filepath (string)
%
% Output:
%  Matrix with 
%   Column 1 - Latitudes  (degrees)  
%   Column 2 - Longitudes (degrees)
%   Column 3 - gravity (observed) (mgGals)
%   Column 4 - ellipsoid height (m)

function data = import_airborne_gravity_data(filepath)
    T = importdata(filepath).data;
    Latitudes = T(:,2);
    Longitudes = T(:,3);
    ellipsoid_height = T(:,4);
    gravity = T(:,5);
    data = [Latitudes,Longitudes,gravity,ellipsoid_height];
end