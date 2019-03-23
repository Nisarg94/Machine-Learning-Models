* Encoding: UTF-8.

*Multilayer Perceptron Network.
MLP symboling (MLEVEL=N) BY make fuel_type aspiration number_of_doors body_style drive_wheels 
    engine_location engine_type number_of_cylinders fuel_system WITH normalized_losses wheel_base 
    length width height curb_weight engine_size bore stroke compression_ratio horsepower peak_rpm 
    city_mpg highway_mpg price
 /RESCALE COVARIATE=STANDARDIZED 
  /PARTITION  TRAINING=7  TESTING=3  HOLDOUT=0
  /ARCHITECTURE   AUTOMATIC=YES (MINUNITS=1 MAXUNITS=50) 
  /CRITERIA TRAINING=BATCH OPTIMIZATION=SCALEDCONJUGATE LAMBDAINITIAL=0.0000005 
    SIGMAINITIAL=0.00005 INTERVALCENTER=0 INTERVALOFFSET=0.5 MEMSIZE=1000 
  /PRINT CPS NETWORKINFO SUMMARY CLASSIFICATION 
  /PLOT NETWORK   
  /STOPPINGRULES ERRORSTEPS= 1 (DATA=AUTO) TRAININGTIMER=ON (MAXTIME=15) MAXEPOCHS=AUTO 
    ERRORCHANGE=1.0E-4 ERRORRATIO=0.001 
 /MISSING USERMISSING=EXCLUDE .
