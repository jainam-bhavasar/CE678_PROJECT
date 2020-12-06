% terrain_correction(H,lat,long,res) calculates terrain correction using 
% convolution integral 
%  INPUT:
%   1 - H(meters) DEM heights combined using <a href="matlab:help combine_DEM_data ">combine_DEM_data</a>
%   2 - Latm(double) - Latitudes grid in increasing order from L-to-R and T-to-B(degrees)
%   3 - Longm(double) - Longitude grid in increasing order from L-to-R and T-to-B(degrees)
%   4 - resolution (double) - resolution of latitude and longitude vector
%  OUTPUT:
%  TC (double)- matrix with terrain correction mapped over Latm and Longm.
function TC = terrain_correction(H,Latm,Longm,res)
    

   
    
    % Import the DEM esri ascii data file
    %%
    H(H==-9999)=0;
    H(H<0)=0;

   
    
    %% Establish a grid of lats and long i.e. the locations of the DEM data
    disp('Determining spatial grids')
    

    
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
    
    l3=l.^(3);
    K=1./l3;
    K(l<111319.9*res)=0;
    % Free up some memory
    clear l l3 W dz
    %% compute 2D fft for the Heights, Heights^2 and kernel
    disp('FFT kernel for TC')
    FK=K;
    clear K
    disp('FFT H^2')
    FH2=H.^2;
    disp('FFT H')
    FH=H;
    disp('FFT ones')
    FOne=ones(size(FK));
    %% Compute the terrain correction in mGal for the whole strip
    disp('Computing TC')
    
    TCterm1 = conv2(FK,FH2,'same');
    TCterm2 =  -2*H.*conv2(FK,FH,'same');
    TCterm3 = (H.^2).*conv2(FK,FOne,'same');
    c = (10^5)*2.67*6.6720e-08/2;
    delx = 111319.9*cosd(Mlat)*res;
    dely = 111319.9*res;
    TC=c*delx*dely*(TCterm1+TCterm2+TCterm3);
    
    end
    
    

end