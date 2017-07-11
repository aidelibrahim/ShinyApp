#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  tags$head(
    tags$style(HTML("
                    @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                    
                    h1 {
                    font-family: 'Lobster', cursive;
                    font-weight: 500;
                    line-height: 1.1;
                    color: #5d0284;
                    }

                    body {
                    background-color: #ebc2fc;
                    }
                    
                    "))
  ),
  
  # Application title
  headerPanel("Courses Enrollment App"),
  helpText ("Feel free to explore our data!"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel("sidebar panel",
                 fluidRow(
                   column(4,
                          selectInput("UA","Universiti :",
                                      c("ALL" ,
                                        unique(as.character(data1$UA))))),
                   column(4,
                          selectInput("bid","Bidang :",
                                      c("ALL",
                                        unique(as.character(data1$Bidang)))))
                   
                 ),
                 
                 selectInput("select",label = h3("Select View type"),
                             choices = list("Data Table" = 1,"Graph "=2),
                             selected = 1),
                 
                 
                 sliderInput("obs", "Number of views:", 
                             min=0, max=201, value=10),  # Define the sidebar with slider input
                 
                 submitButton("Go!")
                 
                 
                 
    ),
    mainPanel(
      
      tabsetPanel(                
        tabPanel(h5("Dataset"),
                 helpText ("These are the data of students' enrolment based on universities and courses."),
                 tableOutput("view"),
                 conditionalPanel(condition="input.select ==1", shiny::dataTableOutput("table1")),
                 conditionalPanel(condition="input.select ==2", shiny::plotOutput("graf"))),
        
        tabPanel(h5("Computer Science"),
                 helpText ("These are the data of students' enrolment in computer science"),
                 plotOutput("view1")),tableOutput("tt"),
        
        tabPanel(h5("By Year"),
                 plotOutput("year")),
        
        tabPanel(h5("Statistics"), 
                 helpText("Here are the detailed statistics about each of the attributes and variables"), verbatimTextOutput("summary")),
        
        tabPanel(h5("Documentation"), 
                 helpText ("Courses Enrollment App provides the best functions to explore the datasets about 
                          Malaysia's Public University Enrollments. The data include the courses and amount 
                          of students who took that courses on the certain year based on university. This 
                          app allows user to choose which university and courses and choose type of observations."), 
                 helpText ("The summary ( ) function provides basic descriptive statistics and frequencies."),
                 helpText ("The View( ) function opens a data frame in a new window in a spreadsheet style format 
                          that can be scrolled for viewing the data. The head ( ) and tail ( ) functions also 
                          allow us to view the first few and last few rows of the data."),
                 helpText ("'graf' interprets the data in a visual way like the plot and ggplot."))
        
        
      )
    )
  )
))
