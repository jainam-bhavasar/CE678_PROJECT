% terrain_correction(H,lat,long,res) calculates terrain correction using 
% FFT techniques
%  INPUT:
%   1 - H(meters) DEM heights combined using <a href="matlab:help combine_DEM_data ">combine_DEM_data</a>
%   2 - Lat(double) - Latitudes vector in increasing order from L-to-R (degrees)
%   3 - Long(double) - Longitude vector in increasing order from L-to-R (degrees)
%   4 - resolution (double) - resolution of latitude and longitude vector
%  OUTPUT:
%  TC (double)- matrix with terrain correction mapped over Latitude and Longitude grid formed using 
%  meshgridding lat and long vector. 
function TC = terrain_correction_fft(H,lat,long,res)
    

        lat_range = max(lat)- min(lat);
        long_range = max(long) - min(long);
        lat1 = [(lat-lat_range),lat(1:end),(lat+lat_range)];
        long1 = [(long-long_range),long(1:end),(long+long_range)];

   
        % Import the DEM esri ascii data file
        %%
        H(H==-9999)=0;
        H(H<0)=0;
        %% Padd array
        disp('Padding array')
        H=addPadding_full(H);
        
        % pad lats and longs
        
      
        %% Establish a grid of lats and long i.e. the locations of the DEM data
        disp('Determining spatial grids')
        Latv=flip(lat1);
        Longv=long1;
        
        [Longm,Latm]=meshgrid(Longv,Latv);
        % Extract submatrxices of the DEM heights and location grids 
        % and convert the locations to metres
        Xm=Longm*111319.9*cosd(mean(mean(Latm)));
        Ym=Latm*111319.9;
       
        
        % Set up the integration kernel l3
        Mlat=mean(mean(Latm));
        %%
        %% Check if data is all zeros if so jump to the end
        if sum(sum(H==0))==numel(H)
           TC=zeros(size(H));
           disp('Writing output file')
           arcgridwrite(outfile,Longv,Latv',TC);
           fid=fopen([outfile,'.dim'],'w');
           fprintf(fid,'%f %f %f %f',[minlat,maxlat,minlong,maxlong]);
           fclose(fid);
        else
        %% Calculate integration kernel    
        disp('Setting up integration kernel')
        l=sqrt((Xm-mean(mean(Xm))).^2+(Ym-mean(mean(Ym))).^2);
        clear Xm Ym Longm Latm
        Delta=111319.9*res;
        l3=l.^(3);
      
        % kernel weighting 
        W=(l3./(2*Delta)).*(((l+Delta/2).^2-(l-Delta/2).^2)./(((l+Delta/2).^2).*((l-Delta/2).^2)));
        K=W./l3;
        % apply a spherical cap to zero the kernel off outside some set radius
        K(l<111319.9*res)=0;
        % Free up some memory
        clear l l3 W dz
        %% compute 2D fft for the Heights, Heights^2 and kernel
        
        disp('FFT kernel for TC')
        FK=fft2(fftshift(K));
        clear K
        disp('FFT H^2')
        FH2=fft2(H.^2);
        disp('FFT H')
        FH=fft2(H);
        disp('FFT ones')
        FOne=fft2(ones(size(FK)));
        %% Compute the terrain correction in mGal for the whole strip
        disp('Computing TC')
        TCterm1 = ifft2(FK.*FH2);
        TCterm2 =  -2*H.*ifft2(FK.*FH);
        TCterm3 = (H.^2).*ifft2(FK.*FOne);
        c = (10^5)*2.67*6.6720e-08/2;
        delx = 111319.9*cosd(Mlat)*res;
        dely = 111319.9*res;
        TC=c*delx*dely*(TCterm1+TCterm2+TCterm3);
        TC = TC(end/3:2*end/3,end/3:2*end/3);
        disp(['time taken: ',num2str(toc)])
        end
    
    

end