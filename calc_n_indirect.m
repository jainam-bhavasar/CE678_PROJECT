function deln = calc_n_indirect(Ellipsoid,Latitude_grid,Longitude_grid)
    R = Ellipsoid.a;
    G = 6.67*10^-11;
    rho = 2670;

    gamma = calc_gnorm_ellip_surface(Latitude_grid,Ellipsoid);
    Xm=Longitude_grid*111319.9*cosd(mean(mean(Latitude_grid)));
    Ym=Latitude_grid*111319.9;

    rq=sqrt((Xm-mean(mean(Xm))).^2+(Ym-mean(mean(Ym))).^2);
    rq(rq<100) = 100;
    rq = 1./rq;

    deltaN_indirect_term1 = pi*H.^2;
 
    deltaN_indirect_term2 = ifft2(fft2(H.^3).*fft2(rq.^3));
    deltaN_indirect_term3 = - H.^3.*conv2(1,rq.^3,'same');
 
    deltaN_indirect_term4 =  ifft2(fft2(H.^5).*fft2(rq.^5));
    deltaN_indirect_term5 = - H.^5.*conv2(1,rq.^5,'same');

     %Using all terms
     %deltaN_indirect1 = -(G*rho./gamma).*(deltaN_indirect_term1+((R.^2)/6).*(deltaN_indirect_term2 +deltaN_indirect_term3)-(3*(R.^2)/40).*(deltaN_indirect_term4+deltaN_indirect_term5))
 
    %Using just term 1
     deln = -(G*rho./gamma).*(deltaN_indirect_term1);
    
end