* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
* Decision Tree.
TREE symboling [n] BY normalized_losses [s] make [n] fuel_type [n] aspiration [n] number_of_doors 
    [n] body_style [n] drive_wheels [n] engine_location [n] wheel_base [s] length [s] width [s] height 
    [s] curb_weight [s] engine_type [n] number_of_cylinders [n] engine_size [s] fuel_system [n] bore 
    [s] stroke [s] compression_ratio [s] horsepower [s] peak_rpm [s] city_mpg [s] highway_mpg [s] price 
    [s] 
  /TREE DISPLAY=TOPDOWN NODES=STATISTICS BRANCHSTATISTICS=YES NODEDEFS=YES SCALE=AUTO
  /DEPCATEGORIES USEVALUES=[VALID]
  /PRINT MODELSUMMARY CLASSIFICATION RISK
  /METHOD TYPE=CRT MAXSURROGATES=AUTO PRUNE=NONE
  /GROWTHLIMIT MAXDEPTH=AUTO MINPARENTSIZE=20 MINCHILDSIZE=10
  /VALIDATION TYPE=SPLITSAMPLE(66) OUTPUT=BOTHSAMPLES
  /CRT IMPURITY=GINI MINIMPROVEMENT=0.0001
  /COSTS EQUAL
  /PRIORS FROMDATA ADJUST=NO
  /MISSING NOMINALMISSING=MISSING.
