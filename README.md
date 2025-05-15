---
  output: github_document
---

```{r, echo = FALSE}
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>")
```

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/RegionalConsistency)](https://cran.r-project.org/package=RegionalConsistency)
[![downloads](http://cranlogs.r-pkg.org/badges/grand-total/RegionalConsistency)](https://cranlogs.r-pkg.org/badges/grand-total/RegionalConsistency)



# RegionalConsistency




## Overview




`RegionalConsistency` is an R package that calculates approximate regional consistency probabilities for multi-regional clinical trials using methods proposed by [the Japanese
    Ministry of Health, Labor and Welfare (2007)](https://www.pmda.go.jp/files/000153265.pdf). The package implements both Method 1 and Method 2 approaches and can calculate:




1. Unconditional regional consistency probabilities
2. Joint regional consistency probabilities
3. Conditional regional consistency probabilities




For technical details about the methodology, please refer to [Homma (2024)](https://doi.org/10.1002/pst.2358).




## Installation




You can install the development version of RegionalConsistency from GitHub with:




```r
# install.packages("devtools")
devtools::install_github("gosukehommaEX/RegionalConsistency")
```




## Usage




```r
library(RegionalConsistency)




# Calculate regional consistency probabilities
result <- regional.consistency.probs(
  f.s = c(0.1, 0.45, 0.45),  # Proportion of patients in each region
  PI = 0.5,                  # Threshold for Method 1
  alpha = 0.025,             # One-sided significance level
  power = 0.8,               # Target power
  seed = 123                 # Seed for reproducibility
)




# View results
print(result)
```




## References




Homma, G. (2024). Cautionary note on regional consistency evaluation in multi-regional clinical trials with binary outcomes. *Pharmaceutical Statistics*, [https://doi.org/10.1002/pst.2358](https://doi.org/10.1002/pst.2358).




Ministry of Health, Labor and Welfare (2007). Basic principles on global clinical trials, [https://www.pmda.go.jp/files/000153265.pdf](https://www.pmda.go.jp/files/000153265.pdf).
