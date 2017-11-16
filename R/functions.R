#' Concatenate all elements and surround the result by ()
#'
#' Concatenate the elements in x into a string and surround the result by parentheses.
#' This does not add single quote to each element
#'
#' @param x vector
#'
#' @return a character string
add_paren <- function(x){
    middle <- paste(x, collapse = ",")
    paste0("(", middle, ")")
}


#' Put each element in single quotes
#'
#' @param x vector
#'
#' @return a character string
single_quote_each <- function(x){
    paste0("'", x, "'")
}


#' Surround the elements in parenthesis with optional single quotes
#'
#' Mainly to use with SQL IN operator.
#' Surround the elements in parenthesis.
#' Each element will be single quoted depending on the data type.
#'
#' @param x vector
#'
#' @return a character string
#' @export
#'
#' @examples
#' paren(1:5)
#' paren(letters[1:5])
#' # Use as follows to build SQL queries
#' paste("select * from schema.table where id in", paren(1:5), ";")
#' paste("select * from schema.table where id in", paren(letters[1:6]), ";")
paren <- function(x){
    if(is.numeric(x)){
        add_paren(x)
    }  else {
        add_paren(single_quote_each(x))
    }
}


#' Concatenate by comma
#'
#' @param vars character vector
#'
#' @return string with comma separated
comma_concat <- function(vars){
    paste(vars, collapse = ", ")
}


#' Count the cases for the combination of variables from the table
#'
#' @param vars character vector of variable names
#' @param table_name string of table name
#'
#' @return sql query string
#' @export
#'
#' @examples
#' library(magrittr)
#' c("x", "y") %>%
#' count_from("table_name")
count_from <- function(vars, table_name){
    vars_cat <- comma_concat(vars)
    query <- paste(
        "select", vars_cat, ", count(*) as n",
        "from", table_name,
        "group by", vars_cat, ";")
    query
}


#' Count number of rows in a table
#'
#' @param table_name table name
#'
#' @return SQL query of counting the number of rows
#' @export
#'
#' @examples
#' count_rows("schema.table")
count_rows <- function(table_name){
    paste("select count(*) as n_row from", table_name, ";")
}


#' Remove semicolon
#'
#' @param x string or query
#'
#' @return string without semicolon
remove_semicolon <- function(x){
    stringr::str_replace_all(x, ";", "")
}


#' add limit n in SQL query
#'
#' @param query SQL statement
#' @param n number of observations
#'
#' @return query with added limit
#' @importFrom magrittr '%>%'
#' @export
#'
#' @examples
#' library(magrittr)
#' "select * from schema.table;" %>% add_limit(100)
add_limit <- function(query, n = 100){
    query %>%
        remove_semicolon() %>%
        paste("limit", n)
}
