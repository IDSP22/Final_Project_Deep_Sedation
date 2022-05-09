#This file contains the prototype for the visualization of disparities in 
#dead after 90 days of receiving deep sedation across ethnicity.

#Libraries

library(dplyr)
library(ggplot2)
#remotes::install_github("feddelegrand7/ddplot", build_vignettes = TRUE) #installs ddplot
library(ddplot) #https://feddelegrand7.github.io/ddplot/reference/barChartRace.html

#Read data of the simulation 

deep_sedation <- read.csv("data/simulation.csv")

#Restricting to patients that where deep sedated and variables of interest. 
#Variables of interest: ethnicity, received deep sedation, died. 

visualization_data <- deep_sedation %>%
  select(Ethnicity, Received.deep.sedation, Died.within.90.Days) %>%
  filter(Received.deep.sedation == 1)

#Proportions of dead by ethnicity

#Black

sum(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "Black"])/length(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "Black"])

#Hispanic

sum(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "Hispanic"])/length(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "Hispanic"])

#Other

sum(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "Other"])/length(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "Other"])

#White

sum(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "White"])/length(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "White"])


#Proportions of dead across ethnicity

#Black

sum(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "Black"])/length(visualization_data$Died.within.90.Days[visualization_data$Died.within.90.Days == 1])

#Hispanic

sum(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "Hispanic"])/length(visualization_data$Died.within.90.Days[visualization_data$Died.within.90.Days == 1])

#Other

sum(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "Other"])/length(visualization_data$Died.within.90.Days[visualization_data$Died.within.90.Days == 1])

#White

sum(visualization_data$Died.within.90.Days[visualization_data$Ethnicity == "White"])/length(visualization_data$Died.within.90.Days[visualization_data$Died.within.90.Days == 1])

##NOTE: This results differ from the ones in the model and could be because 
##of the simulation of the data or because we are not controlling for as 
##many factors as in the multilevel models.

#Proposals for the visualization

# 1. Of the total people that died what was the proportion of dead.

viz_dat <- visualization_data %>%
  filter(Died.within.90.Days == 1)

h <- as.numeric(sum(viz_dat$Ethnicity == "Hispanic"))
w <- as.numeric(sum(viz_dat$Ethnicity == "White")) #Note that there are more white people in the sample, so this is not necessarily an accurate representation. 
b <- as.numeric(sum(viz_dat$Ethnicity == "Black"))
o <- as.numeric(sum(viz_dat$Ethnicity == "Other"))

cum_sum_h <- cumsum(viz_dat$Died.within.90.Days[viz_dat$Ethnicity == "Hispanic"])
cum_sum_w <- cumsum(viz_dat$Died.within.90.Days[viz_dat$Ethnicity == "White"])
cum_sum_b <- cumsum(viz_dat$Died.within.90.Days[viz_dat$Ethnicity == "Black"])
cum_sum_o <- cumsum(viz_dat$Died.within.90.Days[viz_dat$Ethnicity == "Other"])

cum_sum_h <- c(cum_sum_h, rep(h,(w-h)))
cum_sum_b <- c(cum_sum_b, rep(b,(w-b)))
cum_sum_o <- c(cum_sum_o, rep(o,(w-o)))

viz_dat_1 <- data.frame(ethnicity = c(rep("Hispanic", w), rep("White", w),
                                    rep("Black", w), rep("Other", w)),
                      cum_dead = c(cum_sum_h, cum_sum_w, cum_sum_b, cum_sum_o),
                      count = c(1:w, 1:w, 1:w, 1:w))
  

viz_dat_1 %>%
  barChartRace(x = "cum_dead", y = "ethnicity", time = "count",
               xtitle = "Cumulative deads within 90 days",
               title = "Comparison dead accross Ethnicity",
               panelcol = "white",
               bgcol = "white",
               timeLabel = FALSE)


# 2. Using proportions by ethnicity

#Total od participants by ethnicity
h_2 <- as.numeric(sum(visualization_data$Ethnicity == "Hispanic"))
w_2 <- as.numeric(sum(visualization_data$Ethnicity == "White"))
b_2 <- as.numeric(sum(visualization_data$Ethnicity == "Black"))
o_2 <- as.numeric(sum(visualization_data$Ethnicity == "Other"))

#Proportions by ethnicity
cum_sum_h_2 <- cum_sum_h/h_2
cum_sum_w_2 <- cum_sum_w/w_2
cum_sum_b_2 <- cum_sum_b/b_2
cum_sum_o_2 <- cum_sum_b/o_2

viz_dat_2 <- viz_dat_1 %>%
  mutate(cum_dead = c(cum_sum_h_2, cum_sum_w_2, cum_sum_b_2, cum_sum_o_2))
  

#White delays because it has a larger sample size
viz_dat_2 %>%
  barChartRace(x = "cum_dead", y = "ethnicity", time = "count",
               xtitle = "Cumulative deads within 90 days",
               title = "Comparison dead accross Ethnicity",
               panelcol = "white",
               bgcol = "white",
               timeLabel = FALSE)

