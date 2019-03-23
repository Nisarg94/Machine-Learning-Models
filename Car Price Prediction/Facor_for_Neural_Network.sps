* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
FACTOR
  /VARIABLES normalized_losses wheel_base length width height curb_weight engine_size bore stroke 
    compression_ratio horsepower peak_rpm city_mpg highway_mpg price
  /MISSING LISTWISE 
  /ANALYSIS normalized_losses wheel_base length width height curb_weight engine_size bore stroke 
    compression_ratio horsepower peak_rpm city_mpg highway_mpg price
  /PRINT INITIAL EXTRACTION
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /SAVE REG(ALL)
  /METHOD=CORRELATION.
