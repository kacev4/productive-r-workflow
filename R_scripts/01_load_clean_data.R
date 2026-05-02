data <- read_excel("input/data.xlsx", na = "NA")

clean_data <- data %>% 
  slice(-c(23, 48))

saveRDS(clean_data, file = "input/clean_data.rds")
