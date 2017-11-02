#' DBson
#'
#' This function allows you to easily download data formated in json from DBnomics and translate it to data frame
#' @param "slug" The slug provided on dbnomics
#' @keywords json
#' @export
#' @import jsonlite dplyr
#' @examples
#' # Download USA GDP from OECD's Economic Outlook
#' DBson("oecd-eo-usa-gdp-q")

DBson <- function(slug){
  api <- "https://api.db.nomics.world/api/v1/json/series/"

  data <- fromJSON(paste0(api,slug), flatten=TRUE)
  db <- as.data.frame(data[["data"]][["values"]]) %>%
    transmute(time = period,
              values = value) %>%
    mutate(var = data[["data"]][["name"]])

  return(db)
}
