function anomaly = import_grav_anomaly(filePath,Latitudes,Longitudes)
   % import_grav_anomaly(filePath,Latitudes,Longitudes) imports gravity anomilies
% from the GGM model into the latitude and longitude vectors specified.
% INPUTS:
%   1- filePath - path of the file (.gdf format) downloaded from <a href="matlab:web('http://icgem.gfz-potsdam.de/calcgrid','-browser')">here</a> with minimum resolution 0.01 and 
%                 mapping our area of interest
%   2 Latitude(double) -  (degrees)The Latitude vector of area of interest in increasing order.
%   3 longitude(double) - (degrees)The longitude vector of area of interest in increasing order.
%   OUTPUT
%    gravity anomily(double) - gravity anomily(in mGals) vector of ggm model over the given Latitude and longitude vector 
%TIP - Use the vectors obtained from importing gravity airborne data 
% <a href="matlab:help import_airborne_gravity_data">Help for importing airborne data</a>
    fid = fopen(filePath); % file identifier



    n = 1; % headerlines counter

    while true

        str = fgets(fid); % reading the file line by line
        
        if length(str) >= 11
            indx = strcmp(str(1:11), 'end_of_head'); % checking for 'end_of_head' string
        else
            indx = false;
        end
        
        if indx == 0
        
        n = n+1; % keep counting
        
        else

        break;
        
        end

    end
    fgets(fid);
    fclose(fid);
    GGM01C_anomily = textread('Data/Q4/GGM02C_Anomily.gdf','', 'headerlines', n);
    GGM01C_anomily_longitude = GGM01C_anomily(:,1)-360;
    GGM01C_anomily_latitude = GGM01C_anomily(:,2);
    GGM01C_anomily_gravity_anomily = GGM01C_anomily(:,4); 

    anomaly = griddata(GGM01C_anomily_latitude, GGM01C_anomily_longitude, GGM01C_anomily_gravity_anomily, Latitudes, Longitudes);
end