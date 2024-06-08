library(rvest)
library(plyr)


url_CD <- "https://www.cdep.ro"

url_PM <- "https://www.cdep.ro/pls/parlam/structura2015.de?idl=1"

pm_links <- read_html(url_PM) %>% html_nodes("table > tbody > tr > td > b >  a") %>% html_attrs()


results <- lapply(pm_links[1:50], function(x){
  link <- paste0(url_CD, x)
  
  Sys.sleep(runif(1, 0, 3))
  
  resource_HTML <- read_html(link)
  
  name <- resource_HTML %>% html_node("div.boxTitle") %>% html_text()
  
  constituency <-  resource_HTML %>% html_node(".boxStiri> div:nth-child(2)") %>% html_text() 
  
  activity <- try(expr = {
    activity <- resource_HTML %>% html_nodes("table") %>% html_table()
    
  }, silent = TRUE)
  
  list(name =name, constituency = constituency, activity = activity[[length(activity)]] )
})

save(results, file = "MP.RData")
