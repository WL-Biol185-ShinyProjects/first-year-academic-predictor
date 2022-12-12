library(readr)
library(tidyverse)
library(dplyr)

#Load and Refine Data Sets 
IPEDS_data <- read_csv("IPEDS_data.csv")

IPEDS_data_2 <- IPEDS_data[c(1, 2, 3, 4, 6, 7, 8, 22, 23, 24, 25, 27, 28, 29, 30, 31, 32, 42, 65, 66, 70, 73, 75, 80, 83, 84, 85, 86, 88, 89)]
IPEDS_data_2$`Total SAT 25th Percentile` <- IPEDS_data_2$`SAT Critical Reading 25th percentile score`+ IPEDS_data_2$`SAT Math 25th percentile score`
IPEDS_data_2$`Total SAT 75th Percentile` <- IPEDS_data_2$`SAT Critical Reading 75th percentile score`+ IPEDS_data_2$`SAT Math 75th percentile score`
IPEDS_data_2 <- IPEDS_data_2[!is.na(IPEDS_data_2$`Estimated freshman enrollment, full time`),]
IPEDS_data_2 <- IPEDS_data_2[!is.na(IPEDS_data_2$`Total SAT 25th Percentile`),]
IPEDS_data_2 <- IPEDS_data_2[!is.na(IPEDS_data_2$`Total SAT 75th Percentile`),]
IPEDS_data_2 <- IPEDS_data_2[!is.na(IPEDS_data_2$`Tuition and fees, 2013-14`),]

search_by_df <- IPEDS_data_2[, c(2, 8, 9, 19, 12:17)]