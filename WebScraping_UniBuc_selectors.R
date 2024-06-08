install.packages("rvest")

library(rvest)

tabel <- read_html("https://www.w3schools.com/cssref/css_selectors.php") %>% 
  html_element(".ws-table-all.notranslate") %>% 
  html_table()


MEPs <- read_html("https://www.europarl.europa.eu/meps/en/full-list/xml/a") %>% 
  html_elements(xpath = "//meps/mep") %>% 
  html_text()

View(MEPs)