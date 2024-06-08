library(httr)
library(jsonlite)
library(dplyr)
library(stringr)
library(openxlsx)

judeteMnemonic <- c("AB", "AR", "AG", "BC", "BH", "BN", "BT", "BR", "BV", "BZ", 
                    "CL", "CJ", "CS", "CT", "CV", "DB", "DJ", "GL", "GR", "GJ", "HR", 
                    "HD","IL", "IS", "IF", "MM", "MH", "B", "MS", "NT", "OT", 
                    "PH", "SJ", "SM", "SB", "SV", "TR", "TM", "TL", "VL", "VS", 
                    "VN")


# Candidati

urlCandidati <- c("http://admitere.edu.ro/2023/repartizare/", "/data/candidate.json?_=")


candidati <- lapply(judeteMnemonic, function(x){
  t <- as.numeric(as.POSIXct(Sys.Date()))
  urlAdmitere <- paste0(urlCandidati[1], x, urlCandidati[2], t)
  rezultate <- GET(urlAdmitere)
  rezultate <- fromJSON(content(rezultate, as = "text", encoding = "UTF-8"), simplifyDataFrame = TRUE)
})


rezultateCandidati <- do.call('rbind', candidati)


# Licee

urlLicee <- c("http://admitere.edu.ro/2023/repartizare/", "/data/specialization.json?_=")


licee <- lapply(judeteMnemonic, function(x){
  t <- as.numeric(as.POSIXct(Sys.Date()))
  urlAdmitere <- paste0(urlLicee[1], x, urlLicee[2], t)
  rezultate <- GET(urlAdmitere)
  rezultate <- fromJSON(content(rezultate, as = "text", encoding = "UTF-8"), simplifyDataFrame = TRUE)
})


rezultateLicee <- do.call('rbind', licee)


# Adrese licee

urlAdreseLicee <- c("http://admitere.edu.ro/2023/repartizare/", "/data/highschool.json?_=")

adreseLicee <- lapply(judeteMnemonic, function(x){
  t <- as.numeric(as.POSIXct(Sys.Date()))
  urlAdmitere <- paste0(urlAdreseLicee[1], x, urlAdreseLicee[2], t)
  rezultate <- GET(urlAdmitere)
  rezultate <- fromJSON(content(rezultate, as = "text", encoding = "UTF-8"), simplifyDataFrame = TRUE)
})

rezultateAdreseLicee <- do.call('rbind', adreseLicee)


# adrese scoli

urlAdreseScoli <- c("http://admitere.edu.ro/2023/repartizare/", "/data/school.json?_=")


adreseScoli <- lapply(judeteMnemonic, function(x){
  t <- as.numeric(as.POSIXct(Sys.Date()))
  urlAdmitere <- paste0(urlAdreseScoli[1], x, urlAdreseScoli[2], t)
  rezultate <- GET(urlAdmitere)
  rezultate <- fromJSON(content(rezultate, as = "text", encoding = "UTF-8"), simplifyDataFrame = TRUE)
})

rezultateAdreseScoli <- do.call('rbind', adreseScoli)


# locuri neocupate

locuriNeocupate <- c("http://admitere.edu.ro/2023/repartizare/", "/data/empty-seats.json?_=")


locuri <- lapply(judeteMnemonic, function(x){
  t <- as.numeric(as.POSIXct(Sys.Date()))
  urlAdmitere <- paste0(locuriNeocupate[1], x, locuriNeocupate[2], t)
  rezultate <- GET(urlAdmitere)
  rezultate <- fromJSON(content(rezultate, as = "text", encoding = "UTF-8"), simplifyDataFrame = TRUE)
})

rezultateLocuriNeocupate <- do.call('rbind', locuri)


fn <- "rezultateAdmitere2021.xlsx"


listOfDatasets <- list("RezultateCandidati" = rezultateCandidati,
                       "RezultateLicee" = rezultateLicee,
                       "RezultateAdreseLicee" = rezultateAdreseLicee,
                       "RezultateAdreseScoli" = rezultateAdreseScoli,
                       "Locuri neocupate" = rezultateLocuriNeocupate)


write.xlsx(listOfDatasets, fn)
