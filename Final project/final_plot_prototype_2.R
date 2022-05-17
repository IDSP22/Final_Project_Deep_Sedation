#This file contains the prototype for the visualization of disparities in 
#receiving deep sedation across ethnicity.

#Code plot idea taken from https://rpubs.com/haginta/709479

#Primary stakeholder 

#Libraries

library(tidyverse)
library(gganimate)
library(gifski)
library(ggthemes)

#Read data of the simulation 

deep_sedation <- read.csv("data/simulation.csv")

#Restricting to patients variables of interest. 
#Variables of interest: ethnicity, received deep sedation. 

visualization_data <- deep_sedation %>%
  select(Ethnicity, Received.deep.sedation) 

#Proportions of deep sedation by ethnicity

#Black

sum(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "Black"])/length(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "Black"])

#Hispanic

sum(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "Hispanic"])/length(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "Hispanic"])

#Other

sum(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "Other"])/length(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "Other"])

#White

sum(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "White"])/length(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "White"])


#Proportions of dead across ethnicity

#Black

sum(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "Black"])/length(visualization_data$Received.deep.sedation[visualization_data$Received.deep.sedation == 1])

#Hispanic

sum(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "Hispanic"])/length(visualization_data$Received.deep.sedation[visualization_data$Received.deep.sedation == 1])

#Other

sum(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "Other"])/length(visualization_data$Received.deep.sedation[visualization_data$Received.deep.sedation == 1])

#White

sum(visualization_data$Received.deep.sedation[visualization_data$Ethnicity == "White"])/length(visualization_data$Received.deep.sedation[visualization_data$Received.deep.sedation == 1])

##NOTE: This results differ from the ones in the model and could be because 
##of the simulation of the data or because we are not controlling for as 
##many factors as in the multilevel models.

#Proposals for the visualization

#Visualization by ethnicity.
##Seems the most fair since there are more Whites in the sample.
#Preparing data 

viz_dat <- visualization_data %>%
  mutate(b = if_else(Ethnicity == "Black" & Received.deep.sedation==1, 1,0),
         h = if_else(Ethnicity == "Hispanic" & Received.deep.sedation==1, 1,0),
         o = if_else(Ethnicity == "Other" & Received.deep.sedation==1, 1,0),
         w = if_else(Ethnicity == "White" & Received.deep.sedation==1, 1,0),
         cum_b = cumsum(b),
         cum_h = cumsum(h),
         cum_o = cumsum(o),
         cum_w = cumsum(w),
         prop_b = cum_b/sum(Ethnicity == "Black"),
         prop_h = cum_h/sum(Ethnicity == "Hispanic"),
         prop_o = cum_o/sum(Ethnicity == "Other"),
         prop_w = cum_w/sum(Ethnicity == "White"), 
         prop = case_when(Ethnicity == "Black" ~ prop_b,
                          Ethnicity == "Hispanic" ~ prop_h,
                          Ethnicity == "Other" ~ prop_o,
                          Ethnicity == "White" ~ prop_w)) %>%
  select(Ethnicity, prop) %>%
  arrange(Ethnicity) 

#Create the same amount of rows per Ethnicity
viz_dat <- rbind(viz_dat, viz_dat[rep(70, 232), ])
viz_dat <- rbind(viz_dat, viz_dat[rep(118, 254), ])
viz_dat <- rbind(viz_dat, viz_dat[rep(169, 251), ])

#Preparing data for visualization
viz_dat <- viz_dat %>%
  arrange(Ethnicity) %>%
  mutate(n=rep(1:302,4)) %>%
  group_by(n) %>%
  mutate(rank=rank(-prop),
         prop_lbl=paste0("", round(prop*100,0), "%")) %>%
  ungroup() %>%
  mutate(Ethnicity= unlist(Ethnicity),
         prop_lbl= unlist(prop_lbl))

#Plot

fill <- c("#ffffcc", "#a1dab4", "#41b6c4", "#225ea8")

static_plot <- ggplot(viz_dat, aes(rank), group=Ethnicity) +
  geom_tile(aes(y=prop/2,
                height=prop, fill=Ethnicity, 
                width=0.9), alpha=0.8, color=NA) +
  geom_text(aes(y=0, label=paste(Ethnicity,"")), vjust=0.2, hjust=1) +
  geom_text(aes(y=prop, label=prop_lbl, hjust=0)) + #label of the proportions
  geom_text(aes(x=5, y=max(prop) , label = as.factor(n)), vjust = 0.2, alpha = 0.5,  col = "gray", size = 20) +
  coord_flip(clip = "off", expand = FALSE) +#flipping the plot
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  scale_fill_manual(values = fill)+
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position = "none",
        panel.background=element_rect(fill = "#CCCCCC"),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x=element_line(size=0.1, color = "grey"),
        panel.grid.minor.x=element_line(size=0.1, color = "grey"),
        plot.title=element_text(size = 25, hjust = 0, face = "bold",
                                  colour = "black", vjust = -1),
        plot.subtitle=element_text(size=18, hjust=1, 
                                     face="italic", color="grey"),
        plot.caption=element_text(size=14, hjust=1, face="italic", color="grey"),
        plot.background=element_rect(fill = "#CCCCCC"),
        plot.margin=margin(2,2,2,4,"cm"))


#Animate plot

animation <- static_plot +
  transition_states(n, transition_length = 3,
                    state_length = 0, wrap = FALSE) +
  view_follow(fixed_x = TRUE)+
  ease_aes('linear')+
  enter_fade()+
  exit_fade()
  

animate(animation, 331, fps = 5, end_pause = 30, width = 1500, height = 1000,
        renderer = gifski_renderer("anim_ds.gif"))
