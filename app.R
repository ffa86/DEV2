#CHARGEMENT DES PACKAGES
library(shiny)
library(ggplot2)

#INTERFACE UTILISATEUR
ui <- fluidPage(
  titlePanel("Ma première application Shiny"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choisir un jeu de données :",
                  choices = c("mtcars", "iris")),
      textOutput("nbre_records")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Données", tableOutput("table")),
        tabPanel("Graphique", plotOutput("plot")),
        tabPanel("Dictionnaire", tableOutput("data_dictionary"))  # Nouvel onglet
      )
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
  
  output$nbre_records <- renderText({
    dataset <- get(input$dataset)
    paste("Nbre de records :", nrow(dataset))  # Affiche le nombre de lignes
  })
  
  # Ajout : dictionnaire des données
  output$data_dictionary <- renderTable({
    dataset <- get(input$dataset)
    generate_data_dictionary(dataset)
  }, striped = TRUE)
  
}


shinyApp(ui = ui, server = server)
