##############################################################
####             Kelsey Jiang 04/24/2016                  #### 
##############################################################
library(tidyr)
library(dplyr)

#### Data #### 
Skills <- read.csv("~/Desktop/BayesHack/Skills.csv")
Knowledge <- read.csv("~/Desktop/BayesHack/Knowledge.csv")
Interests <- read.csv("~/Desktop/BayesHack/Interests.csv")
geo_salary <- read.csv("~/airjobs/reshaped_data/geo_salary.csv")
  geo_salary <- geo_salary[ , -2]
education_required_25pctl <- read.csv("~/airjobs/reshaped_data/education_required_25pctl.csv")
  education_required_25pctl <- education_required_25pctl[ , -1]
  
####  Reshape the data #### 
Skills_importance <- 
  Skills %>%
  filter(Scale.Name == 'Importance') %>%
  select(O.NET.SOC.Code, Title, Element.Name, Data.Value) %>%
  spread(Element.Name, Data.Value)  %>%
  data.frame()
Skills_importance$dim <- 'Importance'
colnames(Skills_importance)[-c(1,2)] <- paste0('skills_',colnames(Skills_importance))[-c(1,2)]

Skills_level <- 
  Skills %>%
  filter(Scale.Name == 'Level') %>%
  select(O.NET.SOC.Code, Title, Element.Name, Data.Value) %>%
  spread(Element.Name, Data.Value)  %>%
  data.frame()
Skills_level$dim <- 'Level'
colnames(Skills_level)[-c(1,2)] <- paste0('skills_',colnames(Skills_level))[-c(1,2)]

Knowledge_importance <- 
Knowledge %>%
  filter(Scale.Name == 'Importance') %>%
  select(O.NET.SOC.Code, Title, Element.Name, Data.Value) %>%
  spread(Element.Name, Data.Value)  %>%
  data.frame()
colnames(Knowledge_importance)[-c(1,2)] <- paste0('knowledge_',colnames(Knowledge_importance))[-c(1,2)]

Knowledge_level <- 
  Knowledge %>%
  filter(Scale.Name == 'Level') %>%
  select(O.NET.SOC.Code, Title, Element.Name, Data.Value) %>%
  spread(Element.Name, Data.Value)  %>%
  data.frame()
colnames(Knowledge_level)[-c(1,2)] <- paste0('knowledge_',colnames(Knowledge_level))[-c(1,2)]

Interests_OI <- 
  Interests %>%
  filter(Scale.ID == 'OI') %>%
  select(O.NET.SOC.Code, Title, Element.Name, Data.Value) %>%
  mutate(Data.Value = Data.Value * 5 / 7) %>%
  spread(Element.Name, Data.Value)  %>%
  data.frame()
colnames(Interests_OI)[-c(1,2)] <- paste0('interests_',colnames(Interests_OI))[-c(1,2)]

#### Assemble the database ####
database <-
Interests_OI  %>% 
  full_join(Skills_importance, by = c('O.NET.SOC.Code' = 'O.NET.SOC.Code', 'Title' = 'Title')) %>%
  full_join(Knowledge_importance, by = c('O.NET.SOC.Code' = 'O.NET.SOC.Code', 'Title' = 'Title'))  %>%
  full_join(education_required_25pctl, by = c('O.NET.SOC.Code' = 'O.NET.SOC.Code', 'Title' = 'Title')) %>%
  mutate(O.NET.SOC.Code_short = substr(as.character(O.NET.SOC.Code), 1, 7)) %>%
  left_join(geo_salary, by = c('O.NET.SOC.Code_short' = 'occ_code'))

#### Process NAs ####
database[, 9:43] <-
database %>% 
  select(matches('skills_'), -skills_dim) %>%
  mutate_each(funs(mysum = ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>% 
  data.frame()

database[ , 'skills_dim'] <- "Importance"

database[, 'education_level_required'] <-
  database %>% 
  select(education_level_required) %>%
  mutate_each(funs(mysum = ifelse(is.na(.), 1, .))) %>% 
  data.frame()

database[, 'education_level_required_description'] <-
  database %>% 
  select(education_level_required_description) %>%
  mutate(education_level_required_description = ifelse(is.na(education_level_required_description), 'Less than a High School Diploma', as.character(education_level_required_description))) %>% 
  data.frame()

colnames(database) <- gsub("[.]", "_", colnames(database))
colnames(database) <- tolower(colnames(database))

database[, 45:77] <-
  database %>% 
  select(matches('knowledge_')) %>%
  mutate_each(funs(mysum = ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>% 
  data.frame()

database[, 183:234] <-
  database %>% 
  select(matches('salary_')) %>%
  mutate_each(funs(mysum = ifelse(is.na(.), salary_us, .)), -salary_us) %>% 
  data.frame()

#### Output #### 
#write.csv(Skills_importance, file = 'skills_importance.csv')
#write.csv(Skills_level, file = 'skills_level.csv')
#write.csv(Knowledge_importance, file = 'knowledge_importance.csv')
#write.csv(Knowledge_level, file = 'knowledge_level.csv')
#write.csv(Interests_OI, file = 'interests_OI.csv')
#write.csv(database, file = '~/airjobs/reshaped_data/database.csv')