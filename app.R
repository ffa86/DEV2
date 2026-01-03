# =============================================================================
# CHARGEMENT DES PACKAGES ET FONCTIONS UTILITAIRES
# =============================================================================
library(shiny)
library(ggplot2)

# Chargement des fonctions utilitaires depuis le répertoire R/
source("R/utils.R")

# =============================================================================
# INTERFACE UTILISATEUR (UI)
# =============================================================================
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
        tabPanel("Dictionnaire", tableOutput("data_dictionary"))
      )
    )
  )
)

# =============================================================================
# LOGIQUE SERVEUR (SERVER)
# =============================================================================
server <- function(input, output) {
  
  # Affiche le dataset sélectionné sous forme de tableau
  output$table <- renderTable({
    data <- get(input$dataset)
    data
  })
  
  # Génère un graphique en fonction du dataset sélectionné
  output$plot <- renderPlot({
    if (input$dataset == "mtcars") {
      ggplot(mtcars, aes(x = wt, y = mpg)) +
        geom_point() +
        labs(title = "Relation entre poids et consommation",
             x = "Poids (wt)",
             y = "Consommation (mpg)")
    } else {
      ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
        geom_point() +
        labs(title = "Relation entre longueur et largeur des sépales",
             x = "Longueur des sépales (cm)",
             y = "Largeur des sépales (cm)")
    }
  })
  
  # Affiche le nombre d'enregistrements du dataset sélectionné
  output$nbre_records <- renderText({
    dataset <- get(input$dataset)
    paste("Nombre d'enregistrements :", nrow(dataset))
  })
  
  # Affiche le dictionnaire des données du dataset sélectionné
  output$data_dictionary <- renderTable({
    dataset <- get(input$dataset)
    generate_data_dictionary(dataset)
  }, striped = TRUE)
}

# =============================================================================
# LANCEMENT DE L'APPLICATION
# =============================================================================
shinyApp(ui = ui, server = server)
