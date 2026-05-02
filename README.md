# productive-r-workflow

---
title: "Penguin Analysis"
subtitle: "Demonstrating the capabilities of Quarto." 
description: "This document is a short analysis of the Penguin Dataset. It explores the relationship between bill length and bill depth and show how important it is to consider group effects."

author: 
  name: "Kiara Acevedo"
  affiliation: "Independent"
  email: kacev4@gmail.com

keywords: "Quarto, Data Analysis"
date: today

format: 
  html:
    toc: true
    toc-location: left
    number-sections: true
    code-fold: true 
    code-summary: "Show the code"
    code-tools: true
fig-cap-location: margin
title-block-banner: "#f0f3f5"
title-block-banner-color: "black"
css: style.css 
---

::: {.callout-caution collapse="true"}
## A few consideration about this doc

This Quarto document serves as a practical illustration of the concepts covered in the productive workflow online course. It's designed primarily for _educational purposes_, so the focus is on demonstrating Quarto techniques rather than on the rigor of its scientific content.
:::


## Introduction

This document offers a straightforward analysis of the well-known penguin dataset. It is designed to complement the [Productive R Workflow](https://www.productive-r-workflow.com) online course.

You can read more about the penguin dataset [here](https://allisonhorst.github.io/palmerpenguins/).

Let's load libraries before we start!

```{r, message=F, warning=F}
# load the tidyverse
library(tidyverse)
library(hrbrthemes)    # ipsum theme for ggplot2 charts
library(patchwork)     # combine charts together
library(DT)
library(knitr)
library(plotly)
```





## Loading data

The dataset has already been loaded and cleaned in the previous step of this pipeline.

Let's load the clean version, together with a few functions available in `functions.R`.

```{r}
# Source functions
source(file="functions.R")

# Read the clean dataset
data <- readRDS(file = "../input/clean_data.rds")
```


![Bill measurement explanation](asset/culmen_depth.png){width=300}

In case you're wondering how the original dataset looks like, here is a searchable version of it, made using the `DT` package:

```{r}
datatable(data, options = list(pageLength = 10), filter = "top")
```



## Bill Length and Bill Depth

Now, let's make some descriptive analysis, including **summary statistics** and **graphs**.

What's striking is the **slightly negative relationship** between `bill length` and `bill depth`. One could definitely expect the opposite.

```{r, fig.align = "center", fig.width=5, fig.height=5, warning=FALSE, fig.cap="Relationship between bill **length** and bill **depth**. **All** data points included."}
all_data_plot <- data %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) + 
  geom_point(color="#69b3a2") +
  labs(x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       title = paste("Surprising relationship?")) + 
  theme_ipsum_es()

ggplotly(all_data_plot)
```


It is also interesting to note that `bill length` a and `bill depth` are quite different from one specie to another. The average of a variable can be computed as follow:

$${\displaystyle Avg={\frac {1}{n}}\sum _{i=1}^{n}a_{i}={\frac {a_{1}+a_{2}+\cdots +a_{n}}{n}}}$$

`bill length` and `bill depth` averages are summarized in the 2 tables below.

```{r}
#| layout-ncol: 2

data %>%
 group_by(species) %>% 
  summarise(average_bill_length = mean(bill_length_mm, na.rm = TRUE)) %>% 
  kable(digits = round(2))

bill_length_adelie <- data %>%
 group_by(species) %>% 
  summarise(average_bill_length = mean(bill_length_mm, na.rm = TRUE)) %>%
  filter(species == "Adelie") %>%
  pull(average_bill_length) %>%
  round(2)
  
data %>%
 group_by(species) %>% 
  summarise(average_bill_depth = mean(bill_depth_mm, na.rm = TRUE)) %>% 
  kable(digits = round(2))
```
For instance, the average bill length for the specie `Adelie` is `r bill_length_adelie`.

Now, let's check the relationship between bill depth and bill length for the specie `Adelie` on the island `Torgersen`:

```{r, warning=FALSE, fig.height=3, fig.width=9, fig.cap="There is actually a positive correlation when split by species."}

# Use the function in functions.R
p1 <- create_scatterplot(data, "Adelie", "#6689c6")
p2 <- create_scatterplot(data, "Chinstrap", "#e85252")
p3 <- create_scatterplot(data, "Gentoo", "#9a6fb0")

p1 + p2 + p3
```
