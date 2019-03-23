setwd("C:\\Users\\Khushru\\Box Sync\\DePaul\\Class\\Spring 2017-18\\CSC 424\\HW3")

automobile = read.csv("Automobile_clean.csv")

# Correspondence Analysis

library(ca)

table_auto <- with(automobile, table(automobile$fuel_type,automobile$body_style)) # create a 2 way table

prop.table(table_auto, 1) # row percentages

prop.table(table_auto, 2) # column percentages

fit <- ca(table_auto)

print(fit) # basic results 

summary(fit) # extended results 

plot(fit) # symmetric map

plot(fit, mass = TRUE, contrib = "absolute", map =
       "rowgreen", arrows = c(FALSE, TRUE)) # asymmetric map