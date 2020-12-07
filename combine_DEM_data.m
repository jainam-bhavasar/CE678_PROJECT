% combine_DEM_data(files,Latitude_grid,Longitude_grid) will take input DEM files
% downloaded from SRTM website and user interested Latitue and Longitude grid 
% and give final DEM height matrix mapped over Latitude and Longitude grid.
% input : 
% 1 - files - array of strings - each string containg file path of DEM file 
% 2 - Latitude grid (double) - Grid of latitudes of area of interest(degrees)
% 3 - Longitude grid (double)- Grid of latitudes of area of interest(degrees)
% IMP - Latitude and longitude grid must have minimum resololution of 0.01
% and they must be inside or equal to the area covered by the DEM heights data.
%
% TIP - download DEM values from  <a href="matlab:web('http://srtm.csi.cgiar.org/srtmdata/','-browser')">here</a>
% TIP - Use  <a href="matlab:help create_grid">create_grid</a> function for creating Latitude and Longitude grid
%
% OUTPUT - 
% H - dem heights mapped over latitude and longitude grid

function Hs = combine_DEM_data(files,Latitude_grid,Longitude_grid)
    
   
    H1 = importdata(files(1),' ',6).data;
    H2 = importdata(files(2),' ',6).data;
    Hs = [H1(:,1:end-1) ,H2]' ;
    
    
    lat = linspace(40,45,6000);
    long1  =  linspace(-105,-100,6000);
    long2  = linspace (-100,-95,6000);
    long = [long1(1:end-1), long2];
    [latm, longm] = meshgrid(lat, long);
    
    
    
    Hs = Hs(1:12:end,1:12:end);
    longm = longm(1:12:end,1:12:end);
    latm = latm(1:12:end,1:12:end);
    Hs = griddata(latm,longm,Hs,Latitude_grid,Longitude_grid);
end