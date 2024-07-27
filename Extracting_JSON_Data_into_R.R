rm(list=ls()) # remove all variables
cat("\014")  # clear Console
if (dev.cur()!=1) {dev.off()} # clear R plots if exists

# Install required libraries if you haven't already
# install.packages("httr")
# install.packages("jsonlite")

# Load the libraries
library(httr)
library(jsonlite)

# Define the API endpoint URL and your API key
api_key <- "a20f6269ad869afc20979578fe8b4e9e"  # Replace with your actual API key
city <- "Singapore"
url <- paste0("http://api.openweathermap.org/data/2.5/weather?q=", city, "&appid=", api_key)

# Make a GET request to the API
response <- GET(url)

# Check if the request was successful
if (status_code(response) == 200) {
  # Parse the JSON content
  data <- content(response, "text")
  parsed_data <- fromJSON(data, flatten = TRUE)
  
  # Extract the data into a data frame
  weather_data <- as.data.frame(parsed_data)
  
  # Print the first few rows of the data frame
  print(weather_data)
} else {
  # Print an error message if the request failed
  print(paste("Failed to fetch data. Status code:", status_code(response)))
}
