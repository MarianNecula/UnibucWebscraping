# API package for HTTP verbs
library(httr)

# GET
response <- GET("https://example.com/api/resource")
content <- content(response, "text")
print(content)

# POST
response <- POST("https://example.com/api/resource", body = list(name = "John", age = 30))
content <- content(response, "text")
print(content)

# PUT
response <- PUT("https://example.com/api/resource/1", body = list(name = "John", age = 31))
content <- content(response, "text")
print(content)


# DELETE
response <- DELETE("https://example.com/api/resource/1")
status <- status_code(response)
print(status)