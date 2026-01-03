library(shiny)

ui <- fluidPage(
  titlePanel("Ma première application Shiny"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choisir un jeu de données :",
                  choices = c("mtcars", "iris"))
    ),
    mainPanel(
      tableOutput("table")
    )
  )
)

server <- function(input, output) {
  output$table <- renderTable({
    get(input$dataset)
  }, striped = TRUE)
}

shinyApp(ui = ui, server = server)
