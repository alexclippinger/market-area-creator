
# Setup -------------------------------------------------------------------

library(shiny)
library(shinyBS)
library(shinyTime)
library(shinythemes)
library(shinydashboard)
library(shinycssloaders)
library(tidyverse)
library(tigris)
library(hereR)
library(tmap)
library(sf)

options(tigris_use_cache=TRUE)
tmap_mode("view")
set_key(read_file("HERE_API_KEY"))

# Functions ---------------------------------------------------------------

create_zip_data = function(epsg) {
  # Creates SF object with specified zip codes
  get_zips = zctas(cb = TRUE)
  zips = st_transform(st_as_sf(get_zips), epsg)
  
  return(zips)
}

mi_to_meters = function(mi) {
  return(mi*1609.344)
}

hrs_to_secs = function(hr) {
  return(hr*3600)
}

get_coords_from_address = function(address) {
  geocode = hereR::geocode(address)
  
  longitude = st_coordinates(geocode)[1]
  latitude = st_coordinates(geocode)[2]
  
  return(st_as_sf(tibble(latitude = latitude, longitude = longitude),
                  coords = c("longitude", "latitude"), 
                  crs = 4326))
}

# Inputs ------------------------------------------------------------------

poi_type = selectInput(
  inputId = "poi_type",
  label = "Coordinates or Address",
  choices = c("Coordinates", "Address")
)

poi_latitude = numericInput(
  inputId = "poi_latitude",
  label = "Specify latitude of POI",
  value = 34.42334
)

poi_longitude = numericInput(
  inputId = "poi_longitude",
  label = "Specify longitude of POI",
  value = -119.69979
)

poi_address = textInput(
  inputId = "poi_address",
  label = "Specify address",
  value = "140 E Carrillo St, Santa Barbara, CA 93101"
)

range_type = selectInput(
  inputId = "range_type",
  label = "Select range type",
  choices = c("Time", "Distance")
)

time_input = numericInput(
  inputId = "time_input",
  label = "Select travel time (hours)",
  min = 0.25,
  max = 3,
  value = 1
)

distance_input = numericInput(
  inputId = "distance_input",
  label = "Select travel distance (miles)",
  min = 1,
  max = 200,
  value = 20
)

time_of_departure = timeInput(
  inputId = "time_of_departure",
  label = "Enter departure time:",
  value = Sys.time(),
  seconds = FALSE,
  minute.steps = 5
)
