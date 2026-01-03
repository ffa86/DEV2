#CHARGEMENT DES PACKAGES
library(shiny)
library(ggplot2)

#INTERFACE UTILISATEUR
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

#LOGIQUE SERVEUR
server <- function(input, output) {
  output$table <- renderTable({
    data <- get(input$dataset)
    print(head(data))  # Affiche les premières lignes dans la console
    data
  })
  
  output$plot <- renderPlot({
    if (input$dataset == "mtcars") {
      print("Génération du graphique pour mtcars")
      ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
    } else {
      print("Génération du graphique pour iris")
      ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + geom_point()
    }
  })
}


shinyApp(ui = ui, server = server)
