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
    %getting and setting DEM Heights
    Hs = zeros([500*length(files) 500]);
    HsLats = zeros([500*length(files) 500]);
    HsLons = zeros([500*length(files) 500]);

    for i = 1:length(files)
    
        fid = fopen(files(i));
         H = importdata(files(i),' ',6).data;
         H(H==-9999)=0;
         H(H<0)=0;
         
       
        %getting latitudes and longitudes
        for j = 1:6
            str = fgets(fid);
            if j == 3
                minlon = str2double(regexprep(str,'[a-zA-Z\s]',''));
            elseif j==4
                minlat = str2double(regexprep(str,'[a-zA-Z\s]',''));
            end
            
        end
        
        maxlat = minlat+5;
        maxlon = minlon+5; 
        
        % setting up grid and H 
        H = H(1:12:end,1:12:end);
        Hlat = linspace(maxlat,minlat,500);
        Hlon = linspace(minlon,maxlon,500);
        [Hlat,Hlon] = meshgrid(Hlat,Hlon);
        start_row =(500*(i-1)+1);
        end_row = (500*(i-1)+500);
        
        Hs(start_row:end_row,:) = H;
        HsLats(start_row:end_row,:) = Hlat;
        HsLons(start_row:end_row,:) = Hlon;
        
    end
    Hs = griddata(HsLons,HsLats,Hs,Longitude_grid,Latitude_grid,"nearest");
    Hs(isnan(Hs)) = 0;
end