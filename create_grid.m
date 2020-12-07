function [Latitude_grid,Longitude_grid] = create_grid(latitude,longitude,res,error)
%create_grid(latitude,longitude,res) creates grid using latitude and
%longitude vectors from the airborne gravity data
%INPUTS
%1. latitude(double)-(degrees)Latitude vector acquired from the airborne
%gravity data
%2. longitude(double)-(degrees)Longitude vector acquired from the airborne
%gravity data
%3. res(double) - (degrees) spacing between 2 longitudes/spacing between 2
%4 error(double) - (degrees) reduce range by error so that there are no NaN
%values while interpolating delg.
%latitudes
%OUTPUT
%[Latitude_grid,Longitude_grid] - grid formed by meshgridding vectors
%formed of given resolution
%<a href="matlab:help import_airborne_gravity_data">Help for importing airborne data</a>
%TIP- put same resolution that you took when downloading ggm and geoid data
%from <a href="matlab:web('http://icgem.gfz-potsdam.de/calcgrid','-browser')">here</a>
    
    lat = min(latitude)+error:res:max(latitude)-error;
    long = min(longitude)+error:res:max(longitude)-error;
    [Latitude_grid,Longitude_grid] = meshgrid(lat,long);
    
end