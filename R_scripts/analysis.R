# first step --------------------------------------------------------------

data <- read_csv("https://raw.githubusercontent.com/holtzy/R-graph-gallery/master/DATA/data_2.csv")

summary(data)

print(round(mean(subset(na.omit(data), species == "Adelie" & island == "Torgersen")$bill_length_mm),2))
print(round(mean(subset(na.omit(data), species == "Adelie" & island == "Biscoe")$bill_length_mm),2))
print(round(mean(subset(na.omit(data), species == "Adelie" & island == "Dream")$bill_length_mm),2))


# Plot
penguins_clean <- na.omit(data)
plot(penguins_clean$bill_length_mm, penguins_clean$bill_depth_mm, type='n', xlab='Bill Length (mm)', ylab='Bill Depth (mm)', main='Penguin Bill Dimensions')
points(
  penguins_clean$bill_length_mm[penguins_clean$species  ==  "Adelie"], penguins_clean$bill_depth_mm[penguins_clean$species == "Adelie"], col='red', pch=16)
points(penguins_clean$bill_length_mm[penguins_clean$species == "Chinstrap"], penguins_clean$bill_depth_mm[penguins_clean$species == "Chinstrap"], col='green', pch=17)
points(penguins_clean$bill_length_mm[penguins_clean$species == "Gentoo"],
       penguins_clean$bill_depth_mm[penguins_clean$species == "Gentoo"], col='blue', pch=18)
legend("topright", legend=unique(penguins_clean$species),
       col=c('red'
             , 'green',
             'blue'), pch=c(16, 17, 18))

# second step -------------------------------------------------------------

library(tidyverse)
library(readxl)

# Read data using readr
data = read_excel("input/data.xlsx", na = "NA")
#data = readr::read_csv("input/data.csv")

# Summary
summary(data)

# Calculating mean bill length for different species and islands using dplyr
data %>%
  filter(species == "Adelie") %>%
  group_by(island) %>%
  summarize(mean_bill_length = num(mean(bill_length_mm, na.rm = TRUE), digits=2))

# Plot using ggplot2
data %>% na.omit() %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species, shape = species)) +
  geom_point() +
  labs(x = 'Bill Length (mm)', y = 'Bill Depth (mm)', title = 'Penguin Bill Dimensions') +
  scale_shape_manual(values = c("Adelie" = 16, "Chinstrap" = 17, "Gentoo" = 18))

# functions ---------------------------------------------------------------

multiply_by_234 <- function(random_number) {
  return(random_number * 234)
}
multiply_by_234(311)



add_numbers <- function(random_number1, random_number2) {
  return(random_number1 + random_number2)
}
add_numbers(3256, 8934)



# # plot function
# create_scatterplot <- function(data, selected_species, selected_island) {
#   # Filter the data for the specified species and island
#   filtered_data <- data %>%
#     na.omit() %>%
#     filter(species == selected_species, island == selected_island)
#   
#   # Create the scatterplot
#   plot <- ggplot(
#     filtered_data,
#     aes(x = bill_length_mm, y = bill_depth_mm, color = species, shape = species)
#   ) +
#     geom_point() +
#     labs(
#       x = "Bill Length (mm)",
#       y = "Bill Depth (mm)",
#       title = paste("Penguin Bill Dimensions -", selected_species, "-", selected_island)
#     )
#   
#   return(plot)
# }

source("R/functions.R")
# Use the function
create_scatterplot(data, "Adelie", "Torgersen")

# third step --------------------------------------------------------------
library(tidyverse)

# Source functions
source(file="R/functions.R")

# Read the clean dataset
data <- readRDS(file = "input/clean_data.rds")

# Summary
summary(data)

# Calculating mean bill length for different species and islands using dplyr
data %>%
  filter(species == "Adelie") %>%
  group_by(island) %>%
  summarize(mean_bill_length = round(mean(bill_length_mm, na.rm = TRUE), 2))

# Use the function in functions.R
create_scatterplot(data, "Adelie", "Torgersen")