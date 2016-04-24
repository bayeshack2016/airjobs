get_jobs <- function(
  database_df = database_df
  ,  skill_col_1 = "Choose"
  ,  skill_col_2 = "Choose"
  ,  skill_col_3 = "Choose"
  ,  skill_col_4 = "Choose"
  ,  skill_col_5 = "Choose"
  
  , skill_weight_1 = "Choose"
  , skill_weight_2 = "Choose"
  , skill_weight_3 = "Choose"
  , skill_weight_4 = "Choose"
  , skill_weight_5 = "Choose"
  
  ,  interest_1 = "Choose"
  ,  interest_2 = "Choose"
  ,  interest_3 = "Choose"
  
  , interest_weight_1 = "Choose"
  , interest_weight_2 = "Choose"
  , interest_weight_3 = "Choose"
  
  ,  knowledge_1 = "Choose"
  ,  knowledge_2 = "Choose"
  ,  knowledge_3 = "Choose"
  ,  knowledge_4 = "Choose"
  ,  knowledge_5 = "Choose"
  
  ,  knowledge_weight_1 = "Choose"
  ,  knowledge_weight_2 = "Choose"
  ,  knowledge_weight_3 = "Choose"
  ,  knowledge_weight_4 = "Choose"
  ,  knowledge_weight_5 = "Choose"
  
  ,  state_1 = "Choose"
  ,  state_2 = "Choose"
  ,  state_3 = "Choose"
  
  , education_level = "Choose"
  
  , max_wage = "Choose"
  , min_wage = "Choose"
){
  num_jobs <- dim(database_df)[1]
  col_names <- c(skill_col_1,skill_col_2,skill_col_3,skill_col_4,skill_col_5)
  col_names_nonna <- col_names[-grep("Choose",col_names)]
  skills_col_index = c(10:45)[na.omit(match(col_names_nonna,substring(names(database_df)[10:45],first = 8)))]
  skills_weights = as.numeric(c(skill_weight_1,skill_weight_2,skill_weight_3,skill_weight_4,skill_col_5)[-grep("Choose",col_names)])
  
  col_names <- c(interest_1,interest_2,interest_3)
  col_names_nonna <- col_names[-grep("Choose",col_names)]
  interest_col_index = c(4:9)[na.omit(match(col_names_nonna,substring(names(database_df)[4:9],first=11)))]
  interest_weights = as.numeric(c(interest_weight_1,interest_weight_2,interest_weight_3)[-grep("Choose",col_names)])
  
  col_names <- c(knowledge_1,knowledge_2,knowledge_3,knowledge_4,knowledge_4,knowledge_5)
  col_names_nonna <- col_names[-grep("Choose",col_names)]
  knowledge_col_index = c(46:78)[na.omit(match(col_names_nonna,substring(names(database_df)[46:78],first = 11)))]
  knowledge_weights = as.numeric(c(knowledge_weight_1,knowledge_weight_2,knowledge_weight_3, knowledge_weight_4, knowledge_weight_5)[-grep("Choose",col_names)])
  
  col_names <- c(state_1, state_2, state_3)
  col_names_nonna <- col_names[-grep("Choose",col_names)]
  jobrank_col_index = c(82:132)[na.omit(match(col_names_nonna,substring(names(database_df)[82:132], first = 14)))]
  geo_col_index = c(133:183)[na.omit(match(col_names_nonna,substring(names(database_df)[133:183],first = 8)))]
  salary_col_index = c(184:235)[na.omit(match(col_names_nonna,substring(names(database_df)[184:235],first=8)))]
  
  score1 <- rep(0,num_jobs)
  if(length(skills_col_index) > 0){
    score1 <- score1 + as.matrix(database_df[,skills_col_index])%*%skills_weights
  }
  if(length(interest_col_index) > 0){
    score1 <- score1 + as.matrix(database_df[,interest_col_index])%*%interest_weights
  }
  if(length(knowledge_col_index) > 0){
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
                          , score = score1 + score2)
  
  return(output_df)
  # returns df before filtering
}