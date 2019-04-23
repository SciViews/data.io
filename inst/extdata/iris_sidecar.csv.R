# Famous Anderson's iris dataset
# This is an example sidecar file that takes care of the reading() and correct
# formatting of the 'iris_sidecar.csv' file
#
# The current directory is the one where this file is located
# If you use read(), remember to use the sidecar_file = FALSE to avoid infinite
# loops, calling the sidecar file repeatedly
#
# You have access to:
# - 'lang': the string provided to the lang= argument,
# - 'full_lang': same as 'lang', but in lowercase,
# - 'main_lang': the main language. For instance if lang = EN_US,
#   full_lang = en_us and main_lang = en.
# - 'labels_only': do we translate only labels, units and comments, or do we
#   also change factor levels, etc.?
# You may want to use them to provide translations (examples here under).
# Also, you can set the variable 'comments' to suitable strings, depending on
# the lang.
#
# Finally, you **must** return the result in the variable 'dataset'
#
# This file must be encided in UTF-8.

# 1) Import data and rework variables
dataset <- data.io::read("iris_sidecar.csv", sidecar_file = FALSE, lang = lang)
dataset$Species <- factor(dataset$Species)

# 2) In case lang is not NULL, document the dataset (comment, label, units)
if (!is.null(lang)) {
  # The default "en" version: set labels, units and comments
  # Say you want to change the name of the variables to use snake_case
  # Was: "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"
  names(dataset) <-
    c("sepal_length", "sepal_width", "petal_length", "petal_width", "species")
  # Provide labels and units
  dataset <- labelise(dataset, self = FALSE,
    label = list(
      sepal_length = "Length of the sepals",
      sepal_width = "Width of the sepals",
      petal_length = "Length of the petals",
      petal_width = "Width of the petals",
      species = "Iris species"),
    units = list(
      sepal_length = "cm",
      sepal_width = "cm",
      petal_length = "cm",
      petal_width = "cm",
      species = NA)
  )
  # Add a comment
  comments <- "The famous Anderson's iris dataset"

  if (!isTRUE(labels_only)) {# We may want to change also content strings
    # For instance, let's change the levels of species to full latin names
    levels(dataset$species) <- c("I. setosa", "I. versicolor", "I. virginica")
    # ... could also translate other strings here...
  }

  # Now, for a variation on the language, say, in en_US, you want measurements
  # in inches instead (remember full_lang and main_lang are always in lowercase)
  if (full_lang == "en_us") {
    dataset[, 1:4] <- dataset[, 1:4] / 2.54 # Convert measurements into inches
    # You need to change only parts that are different from main_lang
    units(dataset$sepal_length) <- "in"
    units(dataset$sepal_width) <- "in"
    units(dataset$petal_length) <- "in"
    units(dataset$petal_width) <- "in"
    comments <- "Famous Anderson's iris (U.S. version, lengths in inches)"
    if (!isTRUE(labels_only)) {
      # Do something with content here...
    }
  }

  # Now, proceed with another language, say 'fr'
  if (main_lang == "fr") {
    dataset <- labelise(dataset, self = FALSE,
      label = list(
        sepal_length = "Longueur des sépales",
        sepal_width = "Largeur des sépales",
        petal_length = "Longueur des pétales",
        petal_width = "Largeur des pétales",
        species = "Espèces d'iris"),
      units = list(
        sepal_length = "cm",
        sepal_width = "cm",
        petal_length = "cm",
        petal_width = "cm",
        species = NA)
    )
    # Add a comment
    comments <- "Les fameuses iris d'Anderson"
    if (!isTRUE(labels_only)) {
      # Do something with content here...
    }
  }

  # Continue with sub-languages
  if (full_lang == "fr_be") {
    # Say we only want to change comments...
    comments <- "Les fameuses iris d'Anderson (Belgian version)"
  }

  # ... continue with other languages
}
