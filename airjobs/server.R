require(shiny)
require(dplyr)
require(scales)

all_df <- read.csv("../reshaped_data/database.csv")

switch_importance <- function(importance){
  switch(importance,
        "Choose Importance" = "Choose Importance",
        "A Little Important" = 1,
        "Somewhat Important" = 2,
        "Very Important" = 3)
}

switch_education <- function(education_string){
  switch(education_string,
    "Choose Highest Education Level" = 13
    ,"Less than a High School Diploma" = 1
    ,"High School Diploma (or GED or High School Equivalence Certificate)" = 2
    ,"Post-Secondary Certificate" = 3
    ,"Some College Courses" = 4
    ,"Associate's Degree (or other 2-year degree)" = 5
    ,"Bachelor's Degree" = 6
    ,"Post-Baccalaureate Certificate" = 7
    ,"Master's Degree" = 8
    ,"Post-Master's Certificate" = 9
    ,"First Professional Degree" = 10
    ,"Doctoral Degree" = 11
    ,"Post-Doctoral Training" = 12)
}

switch_education_back <- function(education_num){
  switch(education_num,
    "1" = "Less than a High School Diploma"
    ,"2" = "High School Diploma"
    ,"3" = "Post-Secondary Certificate"
    ,"4" = "Some College Courses"
    ,"5" = "Associate's Degree (or other 2-year degree)"
    ,"6" = "Bachelor's Degree"
    ,"7" = "Post-Baccalaureate Certificate"
    ,"8" = "Master's Degree"
    ,"9" = "Post-Master's Certificate"
    ,"10" = "First Professional Degree" 
    ,"11" = "Doctoral Degree" 
    ,"12" = "Post-Doctoral Training")
}

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  output$var_table <- renderDataTable({
    
  },
    options = list(pagingType = "simple", searching = FALSE, paging = FALSE, searchable = FALSE)
  )

  output$table <- renderDataTable({

      job_output <- get_jobs(
        database_df = all_df
        ,  skill_col_1 = input$skill_col_1
        ,  skill_col_2 = input$skill_col_2
        ,  skill_col_3 = input$skill_col_3
        ,  skill_col_4 = input$skill_col_4
        ,  skill_col_5 = input$skill_col_5

        , skill_weight_1 = switch_importance(input$skill_weight_1)
        , skill_weight_2 = switch_importance(input$skill_weight_2)
        , skill_weight_3 = switch_importance(input$skill_weight_3)
        , skill_weight_4 = switch_importance(input$skill_weight_4)
        , skill_weight_5 = switch_importance(input$skill_weight_5)

        ,  interest_1 = input$interest_col_1
        ,  interest_2 = input$interest_col_2
        ,  interest_3 = input$interest_col_3

        , interest_weight_1 = switch_importance(input$interest_weight_1)
        , interest_weight_2 = switch_importance(input$interest_weight_2)
        , interest_weight_3 = switch_importance(input$interest_weight_3)

        ,  knowledge_1 = input$knowledge_col_1
        ,  knowledge_2 = input$knowledge_col_2
        ,  knowledge_3 = input$knowledge_col_3
        ,  knowledge_4 = input$knowledge_col_4
        ,  knowledge_5 = input$knowledge_col_5

        ,  knowledge_weight_1 = switch_importance(input$knowledge_weight_1)
        ,  knowledge_weight_2 = switch_importance(input$knowledge_weight_2)
        ,  knowledge_weight_3 = switch_importance(input$knowledge_weight_3)
        ,  knowledge_weight_4 = switch_importance(input$knowledge_weight_4)
        ,  knowledge_weight_5 = switch_importance(input$knowledge_weight_5)

        ,  state_1 = input$state_1
        ,  state_2 = input$state_2
        ,  state_3 = input$state_3

        , education_level = switch_education(input$education_level)

        , max_wage = input$max_wage
        , min_wage = input$min_wage
    )
    
      filter_output <- filter_jobs(job_output, 
        state_1 = input$state_1, 
        state_2 = input$state_2, 
        state_3 = input$state_3, 
        min_salary_input = as.numeric(input$min_wage), 
        max_salary_input = as.numeric(input$max_wage),
        education_level = switch_education(input$education_level)
        )
      
      
    },
    options = list(pagingType = "simple", 
      searching = FALSE, paging = FALSE, searchable = FALSE,
      order = list(list(2, 'desc'), list(4, 'asc'))
      )
    
  )
    
})


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

  output_df <- data.frame(database_df[,c("o_net_soc_code","title")]
    , score = score1+score2
    , database_df[,c("education_level_required","salary_us")]
    , database_df[,c(salary_col_index
      ,geo_col_index
      ,skills_col_index
      ,interest_col_index
      ,knowledge_col_index
      )])

  return(output_df)
  # returns df before filtering
}


filter_jobs <- function (df, state_1 = "NA", 
  state_2 = "NA", state_3 = "NA", min_salary_input = 0, max_salary_input = 1000000000, 
  education_level = 12){
  
  df %<>% 
    filter(education_level_required <= education_level)

  df_t <- 
    df %>% 
    select(matches('salary_')) %>% 
    select(matches(paste0('salary_', state_1)), 
      matches(paste0('salary_', state_2)), 
      matches(paste0('salary_', state_3))) 

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

  save_colnames <- colnames(df_res)
  
  # Round values
  df_res <- cbind(df_res[,c(1,2,3,4)],round(df_res[,c(-1,-2,-3,-4)],2))

  colnames(df_res) <- save_colnames
    
  # Turn education level into text
  df_res$education_level_required <- sapply(as.character(df_res$education_level_required), switch_education_back)
  
  # Fix currency column display output, pull salary fields together
  # for (i in 1:length(colnames(df_res))){
  #   if(grepl("salary_",colnames(df_res)[i])){
  #     df_res[,colnames(df_res)[i]] <- dollar(df_res[,colnames(df_res)[i]])
  #   }
  # }
  
  if(!is.na(df_res$score[1])){
    df_res$score = round((df_res$score/max(df_res$score))*100,2)
  }
  
  return(df_res)
}

