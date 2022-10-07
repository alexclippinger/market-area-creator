# Market Area Creator #

This R Shiny application uses the HERE Isoline Routing API to create a market area around a specified place of interest. 

### Setup ###

To use the app, a file named `HERE_API_KEY` needs to be created in the repository that contains a HERE API key (no quotes, just paste in the key).

To run the app, open any of the `server.R`, `ui.R`, or `global.R` scripts in RStudio and click "Run App". 

### Potential Improvements ###

- Allow input of coordinates or address for place of interest

- Change units from seconds to minutes and meters to miles

- Improve download formats

- Improve zip code querying

- Add more flexibility to drive time isoline (i.e. car vs. truck, time of day routing, etc.)
