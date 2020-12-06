% calculates and removes correction to account for the gravitational
% attraction of the attraction from g_msw
%Input:
%1. gmsw(double) - gravity of medium and short wavelengths (mGals) of
%correspoinding lat,lon.
%2. H(double) - orthometric heights at corresponding lat,lon
function g_msw_atm = remove_g_atm(gmsw,H)
    % calculating g_atm using the the formula in task 5 of our project
    g_atm = 0.871 - 1.0298*(10^(-4))*H + 5.3105*(10^-9)*(H.^2)  - 2.1642*(10^-13)*(H.^3)+ 9.5246*(10^-18)*(H.^4) - 2.2411*(10^-22)*(H.^5);
   
    %removing it from g_msw
    g_msw_atm = gmsw - g_atm;
end