#' DBson
#'
#' This function allows you to easily download data formated in json from DBnomics and converts it to data frame
#'
#' @param "slug" A \emph{string}. The slug provided on dbnomics.
#' @param frequency A \emph{boolean}. If you want a frequency column in your data frame.
#' @param source A \emph{boolean}. If you want a data provider column in your data frame.
#'
#' @return A \emph{long} data frame with at least 3 columns: \code{time values var}
#'
#' @export
#' @import jsonlite
#' @import dplyr
#' @examples
#' # Download USA GDP from OECD's Economic Outlook
#' DBson("oecd-eo-usa-gdp-q")
#'
#' @references \url{https://db.nomics.world/}

DBson <- function(slug, frequency=TRUE, source = FALSE){
  api <- "https://api.db.nomics.world/api/v1/json/series/"

  data <- fromJSON(paste0(api,slug), flatten=TRUE)
  db <- as.data.frame(data[["data"]][["values"]]) %>%
    transmute(time = period,
              values = value) %>%
    mutate(var = data[["data"]][["name"]])

  if(frequency){
    db <- mutate(db, freq = data[["data"]][["frequency"]])
  }
  if(source){
    db <- mutate(db, provider = data[["data"]][["provider_name"]])
  }

  return(db)
}
