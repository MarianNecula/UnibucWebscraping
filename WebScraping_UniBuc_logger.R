install.packages("log4r")

library(log4r)
logger <- create.logger()

logfile(logger) <- "webscraper.log"

level(logger) <- "INFO"

info(logger, "Starting web scraping...")
tryCatch({
  url <- "https://example.com"
  response <- httr::GET(url)
  info(logger, paste("Requested URL:", url))
  info(logger, paste("Status Code:", httr::status_code(response)))
  if (httr::status_code(response) == 200) {
    data <- httr::content(response, "text")
    info(logger, "Data successfully retrieved.")
  } else {
    warn(logger, "Failed to retrieve data.")
  }
}, error = function(e) {
   error(logger, paste("Error occurred:", e$message))
})
info(logger, "Web scraping completed.")
