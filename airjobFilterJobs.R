##############################################################
####             Kelsey Jiang 04/24/2016                  #### 
##############################################################
library(tidyr)
library(dplyr)
#### Shiny User Interface Input Function ####
database <- read.csv("~/airjobs/reshaped_data/database.csv")

# Define get_jobs
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

# Example output 
tmpoutput <- get_jobs(database, skill_col_1 = "active_learning",skill_col_2 = "critical_thinking",skill_weight_1 = 3,skill_weight_2 = 1,knowledge_1 = "chemistry",knowledge_weight_1 = 3,interest_1 = "realistic",interest_weight_1 = 1,state_1 = "california",state_2 = "new_york")

# Define filter_jobs 
filter_jobs <- function (df, state_1 = "NA", state_2 = "NA", state_3 = "NA", min_salary_input = 0, max_salary_input = 1000000000) {
 df_t <- 
  df %>% 
    select(matches('salary_')) %>% 
    select(matches(paste0('salary_', state_1)), matches(paste0('salary_', state_2)), matches(paste0('salary_', state_3))) 
 
 if (dim(df_t)[2] == 0) {
   df_t$salary_min <- df$salary_us
   df_t$salary_max <- df$salary_us
  } else {
    df_t$salary_min <- apply(df_t, 1, min)
    df_t$salary_max <- apply(df_t, 1, max)
  }

df_all <- cbind(df,salary_min = df_t$salary_min, salary_max = df_t$salary_max)

df_res <- 
  df_all %>%
    filter(salary_min > min_salary_input & salary_max < max_salary_input) %>%
    select(., -c(salary_min, salary_max))

return(df_res)
}

# Example Output
db_filtered <- 
filter_jobs(tmpoutput, state_1 = 'california', state_2 = 'new_york', min_salary_input = 100000, max_salary_input = 140000)
write.csv(db_filtered, file = '~/airjobs/reshaped_data/database_output_example.csv')
