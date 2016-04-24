library(Rbnb)
library(readxl)

# setwd("~/Desktop/Bayes Hack")

desc <- read_excel("ed_descriptions.xlsx")

desc %>% 
  filter(`Scale ID` == "RL") %>% 
  select(Category, `Category Description`) -> descriptions

df <- read.csv("education.csv")

df %>% 
  filter(Scale.ID == "RL") %>% 
  select(O.NET.SOC.Code, Title, Category, Data.Value) %>% 
  group_by(Title) %>% 
  mutate(cs = cumsum(Data.Value), min_cs = cs > 25) %>% 
  filter(min_cs == TRUE) %>% 
  filter(rank(cs, ties.method="first")==1) %>% 
  select(O.NET.SOC.Code, Title, Category) %>% 
  merge(., descriptions, by="Category") %>% 
  select(O.NET.SOC.Code, Title, education_level_required=Category, 
    education_level_required_description = `Category Description`) -> df2

write.csv(df2, "education_required_25pctl.csv")
