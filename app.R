library(shiny)
library(dplyr)

data <- read.csv("aac_shelter_cat_outcome_eng.csv")

data <- data %>% 
  group_by(color) %>%
  summarise()

breed <- c("Samoyed",
           "Chocolate Lab",
           "Yello Lab",
           "Malamute",
           "Australian Shepherd")
# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Dogs on Instagram"),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "type",
                  label = "What breed do you like:",
                  choices = breed),
      
      # Input: Numeric entry for number of obs to view ----
      selectInput(inputId = "account",
                   label = "Who would you like to see:",
                   choices = )
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Verbatim text for data summary ----
      verbatimTextOutput("summary"),
      
      # Output: HTML table with requested number of observations ----
      tableOutput("view")
      
    )
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  # Return the requested dataset ----
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # Show the first "n" observations ----
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
}

shinyApp(ui, server)
