# CE678\_PROJECT

Geoid modelling ce678 project

## REGIONAL GEOID MODELLING

## REGIONAL GEOID MODELLING

### MEMBERS

### MEMBERS

1. Jainam
2. Vyush
3. Sachin
4. Jainam
5. Vyush
6. Sachin



### HOW TO USE

If stuck anywhere use this guide or type help corresponding to the function in Matlab.

Take note of these points -

There is a also a file `project.ipynb` that we have created to demonstrate our code on Nebraska,USA.

#### 1. Organisation

Also `project.pdf` is the project report file.

1. 'project.ipynb' is the master jupyter notebook where all the finalised code is written 
2. There are folders named 'Q1','Q2',... 'Q11' in which all the files regarding those questions will be put

   **2. Working**

3. First learn how to use github - watch any youtube video , you will understand. tip - If you are new to github, download github desktop for faster working because command line tools will overwhelm you the first time.
4. If you want to start working, then take the project from master branch and start working
5. When done, merge into the master branch.
6. IMP - WRITE APPROPRIATE COMMENTS IN THE  FILE 'project.ipynb' WITH YOUR NAME IN IT.
7. IMP - Explain the steps [here](https://www.dropbox.com/scl/fi/uun1m9xwssywjvfamsoll/CE678-LAB.paper?dl=0&rlkey=nuggb6ffqvkql010m8ll3uwtx) you have to take in your answer \(just an overview\) for others to understand and not waste their time to reach up to you. 

   **PROGRESS**

### Step 1

1. Download the airborne gravity data from [here](https://geodesy.noaa.gov/GRAV-D/data_products.shtml) by choosing any state tile.
2. Use the [`import_airborne_gravity_data.m`](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/import_airborne_gravity_data.m) function to import the data from the file of gravity data.
3. Save the matrix into vectors . Ex -

   `T = import_airborne_gravity_data('file_path');`

   `latitude = T(:,1);`

   `longitude = T(:,2);`

   `elipsoidal_height = T(:,4);`

   `gravity_filtered = T(:,3);`

### Step 2

1. Download the geoid heights of GGM model from [here](http://icgem.gfz-potsdam.de/calcgrid)
2. You can import them with [import\_geoid\_heights](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/import_geoid_heights.m)
3. Code can be written as -

   `nggm = import_geoid_heights('filepath',latitude,longitude)`

4. Calculate the **Orthometric height** by adding `nggm` to `ellisoidal_height` using this function-

   [`orthometric_height = calc_orthometric_height(elipsoidal_height,nggm)`](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/calc_orthometric_height.m)

### Step 3

Calculate the free air anomaly using the formula 

![](https://render.githubusercontent.com/render/math?math=%5CDelta%20g%3D%5Cleft%28g_%7B%5Ctext%20%7Bobserved%20%7D%7D%2B%5Cdelta%20g_%7B%5Ctext%20%7BFree%20air%20%7D%7D%5Cright%29-%5Cgamma) Code -

 `free_air_anomily = calc_free_air_anomaly(gravity_filtered,latitude,Ellipsoid,orthometric_height)`

Here \`Ellipsoid\` is a \`struct\` used for storing important constants of Earth.For example ,You can use it by initiating as - 

`Ellipsoid = make_Ellipsoid('WGS84')` 

####  Step 4 

From the free-air gravity anomaly, remove the effect of a global gravity field model, a long- wavelength gravity anomaly

 ![](https://render.githubusercontent.com/render/math?math=\Delta%20g_{\mathrm{GGM}})![](https://render.githubusercontent.com/render/math?math=%5CDelta%20g_%7B%5Cmathrm%7Bs%7D%20%5C%26%20%5Cmathrm%7Bmw%7D%7D%3D%5CDelta%20g-%5CDelta%20g_%7B%5Cmathrm%7BGGM%7D%7D) 

The resultant reduced gravity anomaly ![](https://render.githubusercontent.com/render/math?math=%5CDelta%20g_%7B%5Cmathrm%7Bs%7D%20%5C%26%20%5Cmathrm%7Bmw%7D%7D) contains only the medium and the short wave- lengths. Download gravity anomaly of any GGM model from [here](http://icgem.gfz-potsdam.de/calcgrid). 

TIPS on choosing- 

1. Choose latitude and longitude range within the tile of our gravity airborne data we got in 1st step. 

2. The website doesn't allow resolution less than about 0.01. So make sure choose appropriate resolution so that code does not take long time to execute. 

Code- 

1. To import the data 

[`del_g_ggm = import_grav_anomaly('filepath',latitude,longitude)`](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/import_grav_anomaly.m) 

[del\_g\_s\_and\_mw = remove\_g\_ggm\(free\_air\_anomily,del\_g\_ggm\);](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/remove_g_ggm.m)

\#\#\# Step 5 

A correction to account for the gravitational attraction of the attraction must be applied![](https://render.githubusercontent.com/render/math?math=%5CDelta%20g_%7B%5Cmathrm%7Bs%7D%20%5Cell%20%5Cmathrm%7Bmw%7D%7D%5E%7B%5Cmathrm%7Batm%7D%7D%3D%5CDelta%20g_%7B%5Cmathrm%7Bs%7D%20%5C%26%20%5Cmathrm%7Bmw%7D%7D-%5Cdelta%20g_%7B%5Cmathrm%7Batm%7D%7D)

Code-

[`g_atm_and_s_mw = remove_g_atm(del_g_s_and_mw,orthometric_height)`](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/remove_g_atm.m)

### Step 6

Convert the gravity anomaly  ![](https://render.githubusercontent.com/render/math?math=%5CDelta%20g_%7B%5Cmathrm%7Bs%7D%20%5C%26%20%5Cmathrm%7Bmw%7D%7D%5E%7B%5Cmathrm%7Batm%7D%7D) data points into a grid

Ex Code -

[`[Latitude_grid,Longitude_grid] = create_grid(latitude,longitude,0.01);`](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/create_grid.m)

`g_atm_and_s_mw = griddata(latitude,longitude,g_atm_and_s_mw,Latitude_grid,Longitude_grid);`

### Step 7

1. Download the DEM data from [here](http://srtm.csi.cgiar.org/srtmdata/) in ASCII format and of 5'x5' resolution. Remember to use all the tiles that cover up your interested area.
2. create a string array of filePaths

   `files = ["file1path","file2path"...]`

Apply gravimetric terrain reduction  ![](https://render.githubusercontent.com/render/math?math=%5Cdelta%20g_%7B%5Cmathrm%7BT%7D%7D) to compute the Faye anomaly  ![](https://render.githubusercontent.com/render/math?math=%5CDelta%20g_%7B%5Ctext%20%7BFaye%20%7D%7D).

Code -

[`gfaye = calc_gfaye(g_atm_and_s_mw,files,Latitude_grid,Longitude_grid,0.01);`](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/calc_gfaye.m)

### Step 8

Calculate disturbing potential by using Stokes integral. 

![](https://render.githubusercontent.com/render/math?math=T_%7Br%7D%3D%5Cfrac%7BR%7D%7B4%20%5Cpi%7D%20%5Ciint_%7B%5COmega%7D%20%5CDelta%20g_%7B%5Ctext%20%7BFaye%20%7D%7D%20S%28%5Cpsi%29%20d%20%5COmega)

 [`Tr = calc_disturb_potential(Latitude_grid,Longitude_grid,gfaye);`](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/calc_disturb_potential.m) 

### Step 9 

By using Bruns’s formula, calculate undulation.![](https://render.githubusercontent.com/render/math?math=N_%7Br%7D%3D%5Cfrac%7BT_%7Br%7D%7D%7B%5Cgamma%7D) 

\`\`[`Nr = calc_undulation(Tr,Latitude_grid,Ellipsoid)`](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/calc_undulation.m) 

###  Step 10 

Restore the undulation ![](https://render.githubusercontent.com/render/math?math=%5Cleft%28N_%7BG%20G%20M%7D%5Cright%29) corresponding to the removed long-wavelength gravity anomaly of the GGM model ![](https://render.githubusercontent.com/render/math?math=%5Cleft%28%5CDelta%20g_%7BG%20G%20M%7D%5Cright%29) . You will get a co-geoid![](https://render.githubusercontent.com/render/math?math=N_%7B%5Ctext%20%7Bcogeoid%20%7D%7D%3DN_%7Br%7D%2BN_%7B%5Ctext%20%7BGGM%20%7D%7D)

[`N_co_geoid = calc_n_cogeoid(Nr,nggm,latitude,longitude,Latitude_grid,Longitude_grid);`](https://github.com/Jainam-IITK/CE678_PROJECT/blob/main/calc_n_cogeoid.m)

### 

