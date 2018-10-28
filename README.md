# Projects from DataCamp and Others
This repository contains my solutions to multiple projects I conducted. The repository will be updated.

### Skills
I focus on continuously improving my skills in **R** to work on multiple projects. One of the major advantages of using R is its infinite possibilities of analyzing endless data sprawling out around the world.

A quote from the famous dplyr and ggplot2 inventor Hadley Wickham:
>"The bad news is that whenever you learn a new skill you're going to suck. It's going to be frustrating. The good news is that is typical and happens to everyone and it is only temporary. You can't go from knowing nothing to becoming an expert without going through a period of great frustration and great suckiness."


---
title: "Econometric_Basic"
output: 
  html_document:
    df_print: kable
---

# Basic Econometric

This is my basic practice at working with Econometric learned in the class.
First, we will donwload packages *moments*, *PoEdata*, and *tidyverse*.
```{r, messages = FALSE, warning = FALSE}
require(moments)
require(PoEdata)
require(tidyverse)
```

## Extract Data and Analyze in terms of Wage and Education

Now, let's extract a data of CPS from PoEdata:
```{r}
data(cps)
head(cps,6)
```

Notice that columns except wage, education, age, and experience are **Categorical Variables**.

Next, create a linear model to see the releationship between Wage and Education:
```{r}
# Create a linear model
cpsm = lm(wage ~ educ, data = cps)
summary(cpsm)
```
**Interpretation:** For additional year of education, the average wage is expected to increase by $0.17.
Hence, the linear model formula is:

$$Education = 11.608 + 0.166Wage$$

However, note that $R^2 =$ 19.24%, so each variation of y does not seem to explain the model well.

For simplicity,
```{r}
smod1 <- summary(cpsm)
smod1$coefficients
```

## Graph the Linear Model

Next, we are going to plot a scatter plot to compare Wage and Education:
```{r}
# Regular Linear Model
ggplot(cpsm, aes(x = educ, y = wage)) +
  geom_point() +
  labs(x = "Years of Education",
       y = "Wage ($)") +
  theme_minimal() +
  geom_smooth(method = "lm", se = FALSE)

# Changing The line as Quadratic Curve
ggplot(cpsm, aes(x = educ, y = wage)) +
  geom_point() +
  labs(x = "Years of Education",
       y = "Wage ($)") +
  theme_minimal() +
  geom_smooth(method = "lm", formula = y ~ I(x^2), se = FALSE)
```

By seeing the graph, making the line quadratic instead of linear does not make the graph better. It seems there is a problem with residuals as we can notice **heteroskedasticity**.

To confirm, check residuals graph.
```{r}
# Residual Graph
cpsm.res = resid(cpsm)
ggplot(cpsm, aes(x = wage, y = cpsm.res)) +
  geom_point() +
  labs(x = "Wage",
       y = "Residuals",
       title = "Residuals in terms of Wage") +
  theme_minimal()
```

Notice that residuals are congested around 0 in terms of **Wages**.
This result means residuals are not randomly distributed.
Hence, residuals are not doing a good job a fitting the model with data.

## Conclusion
Considering the fact that coefficient of determination is 19.23% and
residuals are not randomly distributed,
this data may not be an ideal data to create a linear regression model.
The scatter points for the graph model did not seem to show a pattern,
showing that Education is not really depended by education.
