function anomaly = import_grav_anomaly(filePath,Latitudes,Longitudes)
    %import_grav_anomaly - Description
    %
    % Syntax: anomaly = import_grav_anomaly(filePath)
    %
    % Long description
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