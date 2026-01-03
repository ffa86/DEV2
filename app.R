library(shiny)

ui <- fluidPage(
  titlePanel("Ma première application Shiny"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choisir un jeu de données :",
                  choices = c("mtcars", "iris"))
    ),
    mainPanel(
      tableOutput("table"),
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$table <- renderTable({
    get(input$dataset)
  }, striped = TRUE)
  
  output$plot <- renderPlot({
    if (input$dataset == "mtcars") {
      ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
    } else {
      ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + geom_point()
    }
  })
}

shinyApp(ui = ui, server = server)
