<!-- README.md is generated from README.Rmd. Please edit that file -->
sql.helper
==========

The goal of sql.helper is to help building SQL queries in R

Install
-------

    # install.packages('devtools')
    devtools::install_github("taekyunk/sql.helper")

Example: `paren()`
------------------

This is a basic example of using `paren()` with SQL IN operator.

``` r
id_char <- as.character(1:5)
id_num <- 3:8

# paren() will add single quotes if the field is not numeric
paren(id_char)
#> [1] "('1','2','3','4','5')"
paren(id_num)
#> [1] "(3,4,5,6,7,8)"

# to match character with numeric
paren(as.numeric(id_char))
#> [1] "(1,2,3,4,5)"

# to match numeric with character
paren(as.character(id_num))
#> [1] "('3','4','5','6','7','8')"

# typical use case will be something like this
query <- paste("select * from tablename where id in", paren(id_num), ";")
print(query)
#> [1] "select * from tablename where id in (3,4,5,6,7,8) ;"
```

Example: `count_from()`
-----------------------

`count_from()` can be used to build SQL query to count the combination of variables.

``` r
library(tidyverse)
#> Loading tidyverse: ggplot2
#> Loading tidyverse: tibble
#> Loading tidyverse: tidyr
#> Loading tidyverse: readr
#> Loading tidyverse: purrr
#> Loading tidyverse: dplyr
#> Conflicts with tidy packages ----------------------------------------------
#> filter(): dplyr, stats
#> lag():    dplyr, stats
c("x", "y") %>% 
    count_from("schema.table")
#> [1] "select x, y , count(*) as n from schema.table group by x, y ;"
```

Example: `count_rows()`
-----------------------

`count_rows()` builds SQL query to count the number of observations in a table

``` r
count_rows("schema.table")
#> [1] "select count(*) as n_row from schema.table ;"
```
