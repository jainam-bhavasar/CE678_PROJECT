function nggm = import_geoid_heights(filePath,Latitudes,Longitudes)
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
    GGM01C = textread('Data/Q2/Downloaded_data/GGM02C.gdf','', 'headerlines', n);
    GGM01C_longitudes = GGM01C(:,1)-360;
    GGM01C_latitudes = GGM01C(:,2);
    GGM01C_geoid = GGM01C(:,3);
    nggm = griddata(GGM01C_latitudes, GGM01C_longitudes, GGM01C_geoid, Latitudes, Longitudes);
end
