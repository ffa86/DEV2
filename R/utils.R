#' Génère un dictionnaire des données pour un dataset donné
#'
#' Cette fonction prend un data.frame en entrée et retourne un data.frame
#' décrivant chaque variable : nom, type, nombre de valeurs manquantes (NA),
#' et un exemple de valeur.
#'
#' @param data Un data.frame contenant les données à analyser.
#' @return Un data.frame décrivant chaque variable du dataset.
#' @examples
#' data_dict <- generate_data_dictionary(mtcars)
#' print(data_dict)
generate_data_dictionary <- function(data) {
  result <- data.frame(
    Variable = character(),
    Type = character(),
    NA_Count = numeric(),
    Example = character(),
    stringsAsFactors = FALSE
  )
  
  for (col_name in names(data)) {
    col_data <- data[[col_name]]
    col_type <- class(col_data)
    na_count <- sum(is.na(col_data))
    
    # Calcul de l'exemple de valeur en fonction du type de données
    if (is.numeric(col_data)) {
      example_value <- mean(col_data, na.rm = TRUE)
    } else if (is.character(col_data) || is.factor(col_data)) {
      unique_values <- unique(col_data)
      if (length(unique_values) > 0) {
        example_value <- as.character(unique(na.omit(col_data))[1])
      } else {
        example_value <- NA
      }
    } else {
      example_value <- NA
    }
    
    # Ajout de la ligne au résultat
    result <- rbind(
      result,
      data.frame(
        Variable = col_name,
        Type = col_type,
        NA_Count = na_count,
        Example = example_value,
        stringsAsFactors = FALSE
      )
    )
  }
  
  return(result)
}
