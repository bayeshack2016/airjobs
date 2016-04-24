require(shiny)

# Fill out choices

importance_choices <- c(
  "Choose Importance",
  "A Little Important",
  "Somewhat Important",
  "Very Important")

education_levels <- c(
  "Choose Highest Education Level"
  ,"Less than a High School Diploma"
  ,"High School Diploma (or GED or High School Equivalence Certificate)"
  ,"Post-Secondary Certificate"
  ,"Some College Courses"
  ,"Associate's Degree (or other 2-year degree)"
  ,"Bachelor's Degree"
  ,"Post-Baccalaureate Certificate"
  ,"Master's Degree"
  ,"Post-Master's Certificate"
  ,"First Professional Degree"
  ,"Doctoral Degree"
  ,"Post-Doctoral Training")

all_df <- read.csv("../reshaped_data/database.csv")

states <- c("Choose State",
  gsub("salary_","", colnames(all_df)[which(grepl("salary_",colnames(all_df)))])[-52])

interest_list <- c("Choose Interest",
  gsub("interests_","", colnames(all_df)[which(grepl("interests_",colnames(all_df)))])
)

skill_list <- c("Choose Skill",
  gsub("skills_","", colnames(all_df)[which(grepl("skills_",colnames(all_df)))])[-36])

knowledge_list <- c("Choose Knowledge",
  gsub("knowledge_","", colnames(all_df)[which(grepl("knowledge_",colnames(all_df)))])
)

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(theme = "bootstrap.css",    
    
    # Give the page a title
    titlePanel("AirJobs"),
    
    ### Skills
    fluidRow(
      titlePanel("Skills")  
    ),
    fluidRow(
        column(2,
          selectInput("skill_col_1", "Skill 1", choices= skill_list)
          ),
        column(2,
          selectInput("skill_col_2", "Skill 2", choices= skill_list)
        ),
        column(2,
          selectInput("skill_col_3", "Skill 3", choices= skill_list)
        ),
        column(2,
          selectInput("skill_col_4", "Skill 4", choices= skill_list)
        ),
        column(2,
          selectInput("skill_col_5", "Skill 5", choices= skill_list)
        )
      ),

    fluidRow(
      column(2,
        selectInput("skill_weight_1", "Skill 1 Weight", importance_choices)
      ),
      column(2,
        selectInput("skill_weight_2", "Skill 2 Weight", importance_choices)
      ),
      column(2,
        selectInput("skill_weight_3", "Skill 3 Weight", importance_choices)
      ),
      column(2,
        selectInput("skill_weight_4", "Skill 4 Weight", importance_choices)
      ),
      column(2,
        selectInput("skill_weight_5", "Skill 5 Weight", importance_choices)
      ),

    br()
    ),

    
    ### Interests
    fluidRow(
      titlePanel("Interests")  
    ),
    
    fluidRow(
      column(2,
        selectInput("interest_col_1", "Interest 1", choices= interest_list)
      ),
      column(2,
        selectInput("interest_col_2", "Interest 2", choices= interest_list)
      ),
      column(2,
        selectInput("interest_col_3", "Interest 3", choices= interest_list)
      )
    ),
    
    fluidRow(
      column(2,
        selectInput("interest_weight_1", "Interest 1 Weight", importance_choices)
      ),
      column(2,
        selectInput("interest_weight_2", "Interest 2 Weight", importance_choices)
      ),
      column(2,
        selectInput("interest_weight_3", "Interest 3 Weight", importance_choices)
      )
    ),
    
    ### Knowledge
    
    fluidRow(
      titlePanel("Knowledge")  
    ),
    
    fluidRow(
      column(2,
        selectInput("knowledge_col_1", "Knowledge 1", choices= knowledge_list)
      ),
      column(2,
        selectInput("knowledge_col_2", "Knowledge 2", choices= knowledge_list)
      ),
      column(2,
        selectInput("knowledge_col_3", "Knowledge 3", choices= knowledge_list)
      ),
      column(2,
        selectInput("knowledge_col_4", "Knowledge 4", choices= knowledge_list)
      ),
      column(2,
        selectInput("knowledge_col_5", "Knowledge 5", choices= knowledge_list)
      )
    ),
    
    fluidRow(
      column(2,
        selectInput("knowledge_weight_1", "Knowledge 1 Weight", importance_choices)
      ),
      column(2,
        selectInput("knowledge_weight_2", "Knowledge 2 Weight", importance_choices)
      ),
      column(2,
        selectInput("knowledge_weight_3", "Knowledge 3 Weight", importance_choices)
      ),
      column(2,
        selectInput("knowledge_weight_4", "Knowledge 4 Weight", importance_choices)
      ),
      column(2,
        selectInput("knowledge_weight_5", "Knowledge 5 Weight", importance_choices)
      ),
      
      br()
    ),
    
    
    ## States
    
    fluidRow(
      titlePanel("States")  
    ),
    
    fluidRow(
      column(3,
        selectInput("state_1", "State 1", choices= states)
      ),
      column(3,
        selectInput("state_2", "State 2", choices= states)
      ),
      column(3,
        selectInput("state_3", "State 3", choices= states)
      )
    ),
    
    fluidRow(
      titlePanel("Education Level")  
    ),
    
    fluidRow(
      column(6,
        selectInput("education_level", "Highest Education Level", 
          choices= education_levels)
      )
    ),

    fluidRow(
      column(5,
        textInput("min_wage", label = h3("Minimum Wage (in $)"), value = "0")
      ),
      column(5,
        textInput("max_wage", label = h3("Maximum Wage (in $)"), value = "200000")
      )
    ),
    
    fluidRow(
      titlePanel("Recommended Jobs")  
    ),
    
    
    fluidRow(
      dataTableOutput("table")
    )
  )
)
