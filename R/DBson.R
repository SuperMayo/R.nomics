#' DBson
#'
#' This function allows you to easily download data formated in json from DBnomics and converts it to data frame
#'
#' @param "slug" A \emph{string}. The slug provided on dbnomics. You can provide multiple slugs in \emph{list} format.
#' @param frequency A \emph{boolean}. If you want a frequency column in your data frame.
#' @param source A \emph{boolean}. If you want a data provider column in your data frame.
#' @param longtitle Exhaustive description of your data
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

DBson <- function(slug, frequency=TRUE, source = FALSE, longtitle = FALSE){
  api <- "https://api.db.nomics.world/api/v1/json/series/"
  db <- data_frame()
  for(link in slug) {
    data <- fromJSON(paste0(api,link), flatten=TRUE)
    df <- as.data.frame(data[["data"]][["values"]]) %>%
      transmute(time = period,
                values = value) %>%
      mutate(country = data[["data"]][["dimensions"]][["geo"]],
             var     = data[["data"]][["key"]])

    if(frequency){
      df <- mutate(df, freq = data[["data"]][["frequency"]])
    }
    if(source){
      df <- mutate(df, provider = data[["data"]][["provider_name"]])
    }
    if(longtitle){
      df <- mutate(df, title = data[["data"]][["name"]])
    }

    db <- rbind(db,df)
  }
  return(db)
}
