rm(list=ls()) # remove all variables
cat("\014")  # clear Console
if (dev.cur()!=1) {dev.off()} # clear R plots if exists

# Install required libraries if you haven't already
# install.packages("httr")
# install.packages("jsonlite")

library(httr)
library(jsonlite)

# Define the URL
url <- "https://api.data.gov.sg/v1/transport/carpark-availability"

# Fetch the data
response <- GET(url)

# Check if the request was successful
if (status_code(response) == 200) {
  # Parse the JSON content
  data <- fromJSON(content(response, "text"), flatten = TRUE)
  
  # Inspect the structure of the parsed data
  str(data)
  
  # Extract and flatten the data
  carpark_info_list <- lapply(data$items, function(x) {
    if (!is.null(x$carpark_data)) {
      return(as.data.frame(x$carpark_data))
    } else {
      return(NULL)
    }
  })
  
  # Combine all the data frames into one
  flattened_data <- do.call(rbind, carpark_info_list)
  
  # View the first few rows of the DataFrame
  print(head(flattened_data))
  
  # Check the structure of the DataFrame
  print(str(flattened_data))
} else {
  stop(paste("Failed to fetch data. Status code:", status_code(response)))
}
