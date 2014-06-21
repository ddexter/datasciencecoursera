library(httr)

oauth_endpoints("github")

app <- oauth_app("github", "32b2c195f41d1caeac8e")
token <- oauth2.0_token(oauth_endpoints("github"), app)

req <- GET("https://api.github.com/users/jtleek/repos", config(token = token))
stop_for_status(req)

content <- content(req)

attributes(content)

