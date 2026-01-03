library(shiny)
library(testthat)

# Teste si l'application démarre sans erreur
test_that("L'application démarre sans erreur", {
  expect_silent(load("app.R"))
})

# Teste si les données sont disponibles
test_that("Les données mtcars et iris sont disponibles", {
  expect_true(exists("mtcars"))
  expect_true(exists("iris"))
})
