#### Put together geo_salary csv file
Skills <- read.csv("~/git_root/BayesHack2016/reshaped_data/skills_importance.csv")

library(dplyr)
library(Rbnb)

Skills

OESM <- read.csv("~/git_root/BayesHack2016/oesm15all/all_data_M_2015_cleaned.csv")
summary(OESM)
OESM$X <- c()

OESM$a_median <- as.numeric(OESM$a_median)

OESM_reshaped <- OESM %>%
  filter(area_type==2
         , ! group %in% c("total","major")) %>% 
  mutate(state = gsub(" ", "_",tolower(area_title))) %>% 
  group_by(state) %>% 
  mutate(jobrankscore = rank(ifelse(is.na(jobs_1000), 0, jobs_1000))/n()) %>% 
  select(occ.code
         , occ.title
         , state
         , jobrankscore
         , jobs1k = jobs_1000
#         , jobsquo = loc_quotient
         , salary = a_median
  ) %>% 
  gather("attribute","value", 4:6) %>%
  unite(attribute_state, attribute, state) %>% 
  spread(attribute_state, value)

names(OESM_reshaped)[1:2] <- c("occ_code","occ_title")

missing_fun <- function(x){return(ifelse(is.na(x),0,x))}
OESM_reshaped[,3:104] <- OESM_reshaped[,3:104] %>% 
  mutate_each(funs(missing_fun))

summary(OESM_reshaped)

OESM %>% 
  filter(area_type==1
         , naics_title == "Cross-industry"
         ) %>%
  select(occ.code, a_median) %>% 
  ggplot() +
  geom_histogram(aes(x = a_median))

salary_national <- OESM %>% 
  filter(area_type==1
         , naics_title == "Cross-industry"
  ) %>%
  select(occ_code = occ.code, salary_us = a_median) 

OESM_reshaped %<>% 
  inner_join(salary_national, by = "occ_code")

Skills %<>%
  mutate(occ.code = substr(O.NET.SOC.Code,1,7))

OESM_reshaped %>% 
  filter(occ.code %in% setdiff(OESM_reshaped$occ.code, Skills$occ.code)) %>% 
  select(occ.title) %>% as.data.frame()

write.csv(OESM_reshaped,file = "geo_salary.csv", row.names = FALSE)

#### Find the cutoff for job1k of geo filter
OESM_long <- OESM %>%
  filter(area_type==2
         , ! group %in% c("total","major")) %>% 
  mutate(state = gsub(" ", "_",area_title)) %>% 
  select(occ.code
         , occ.title
         , state
         , jobs1k = jobs_1000
         , jobsquo = loc_quotient
         , salary = a_median
  )

OESM_long %>% 
  group_by(occ.code
           , occ.title) %>% 
  summarise(min(jobs1k, na.rm= TRUE)
            , quantile(jobs1k, 0.1, na.rm= TRUE)
            , quantile(jobs1k, 0.25, na.rm= TRUE)
            , quantile(jobs1k, 0.5, na.rm= TRUE)
            , quantile(jobs1k, 0.75, na.rm= TRUE)
            , quantile(jobs1k, 0.9, na.rm= TRUE)
            , max_jobs1k = max(jobs1k, na.rm= TRUE)) %>% 
  ggplot() +
  geom_histogram(aes(x=max_jobs1k)
                 , binwidth = 0.1)+
  scale_x_continuous(limit = c(0,5))

OESM_long %>% 
  group_by(state) %>% 
  summarise(min(jobs1k, na.rm= TRUE)
            , quantile(jobs1k, 0.1, na.rm= TRUE)
            , quantile(jobs1k, 0.25, na.rm= TRUE)
            , quantile(jobs1k, 0.5, na.rm= TRUE)
            , quantile(jobs1k, 0.75, na.rm= TRUE)
            , quantile(jobs1k, 0.9, na.rm= TRUE)
            , max_jobs1k = max(jobs1k, na.rm= TRUE)) %>% as.data.frame()
  ggplot() +
  geom_histogram(aes(x=max_jobs1k))+
  scale_x_continuous(limit = c(0,5))
  
OESM_long %>% 
  group_by(state) %>% 
  mutate(jobrankscore = rank(ifelse(is.na(jobs1k), 0, jobs1k))/n()) %>% 
  filter(state == "California") %>% 
  select(occ.title, jobsquo, jobrankscore,jobs1k) %>% 
  arrange(jobrankscore) %>% head(25) %>% as.data.frame()
  
#### Search ranking function for Shiny
database_df = read.csv("~/git_root/airjobs/reshaped_data/database.csv", header = TRUE)
get_jobs <- function(
  database_df = database_df
  ,  skill_col_1 = NA
  ,  skill_col_2 = NA
  ,  skill_col_3 = NA
  ,  skill_col_4 = NA
  ,  skill_col_5 = NA
  
  , skill_weight_1 = NA
  , skill_weight_2 = NA
  , skill_weight_3 = NA
  , skill_weight_4 = NA
  , skill_weight_5 = NA
  
  ,  interest_1 = NA
  ,  interest_2 = NA
  ,  interest_3 = NA
  
  , interest_weight_1 = NA
  , interest_weight_2 = NA
  , interest_weight_3 = NA
  
  ,  knowledge_1 = NA
  ,  knowledge_2 = NA
  ,  knowledge_3 = NA
  ,  knowledge_4 = NA
  ,  knowledge_5 = NA
  
  ,  knowledge_weight_1 = NA
  ,  knowledge_weight_2 = NA
  ,  knowledge_weight_3 = NA
  ,  knowledge_weight_4 = NA
  ,  knowledge_weight_5 = NA
  
  ,  state_1 = NA
  ,  state_2 = NA
  ,  state_3 = NA

  , education_level = NA

  , max_wage = NA
  , min_wage = NA
){
  num_jobs <- dim(database_df)[1]
  skills_col_index = c(10:45)[na.omit(match(c(skill_col_1,skill_col_2,skill_col_3,skill_col_4,skill_col_5),substring(names(database_df)[10:45],first = 8)))]
  interest_col_index = c(4:9)[na.omit(match(c(interest_1,interest_2,interest_3),substring(names(database_df)[4:9],first=11)))]
  knowledge_col_index = c(46:78)[na.omit(match(c(knowledge_1,knowledge_2,knowledge_3,knowledge_4,knowledge_4,knowledge_5),substring(names(database_df)[46:78],first = 11)))]
  jobrank_col_index = c(82:132)[na.omit(match(c(state_1, state_2, state_3),substring(names(database_df)[82:132], first = 14)))]
  geo_col_index = c(133:183)[na.omit(match(c(state_1, state_2, state_3),substring(names(database_df)[133:183],first = 8)))]
  salary_col_index = c(184:235)[na.omit(match(c(state_1, state_2, state_3),substring(names(database_df)[184:235],first=8)))]

  skills_weights = na.omit(c(skill_weight_1,skill_weight_2,skill_weight_3,skill_weight_4,skill_col_5))
  interest_weights = na.omit(c(interest_weight_1,interest_weight_2,interest_weight_3))
  knowledge_weights = na.omit(c(knowledge_weight_1,knowledge_weight_2,knowledge_weight_3, knowledge_weight_4, knowledge_weight_5))
  
  score1 <- rep(0,num_jobs)
  if(length(skills_col_index>0)){
    score1 <- score1 + as.matrix(database_df[,skills_col_index])%*%skills_weights
  }
  if(length(interest_col_index>0)){
    score1 <- score1 + as.matrix(database_df[,interest_col_index])%*%interest_weights
  }
  if(length(knowledge_col_index>0)){
    score1 <- score1 + as.matrix(database_df[,knowledge_col_index])%*%knowledge_weights
  }
  score1 <- score1/(max(score1)-min(score1))
  
  score2 <- rep(0,num_jobs)
  if(length(jobrank_col_index) >= 2){
    score2 <- score2 + rowMeans(database_df[,jobrank_col_index]) 
  } else if (length(jobrank_col_index)==1) {
    score2 <- score2 + database_df[,jobrank_col_index]
  }
  
  output_df <- data.frame(database_df[,c("o_net_soc_code","title","education_level_required","salary_us")]
                          , database_df[,c(skills_col_index
                                           ,interest_col_index
                                           ,knowledge_col_index
                                           ,geo_col_index
                                           ,salary_col_index)]
                          , score = score1+score2)
  
  return(output_df)
    # returns df before filtering
}
