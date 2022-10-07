# Market Area Creator #

This R Shiny application uses the HERE Isoline Routing API to create a market area around a specified place of interest. 

### Setup ###

To use the app, a file named `HERE_API_KEY` needs to be created in the repository that contains a HERE API key (no quotes, just paste in the key). For information on how to obtain an API key, refer to the [HERE Developer Site](https://developer.here.com/tutorials/getting-here-credentials/).

To run the app, open any of the `server.R`, `ui.R`, or `global.R` scripts in RStudio and click "Run App". 

### Note ### 

There is limited monthly free use of HERE services. Notably, this application uses the HERE Isoline Routing API and (optionally, when specifying POI by address) HERE Geocoding. For information on pricing, refer to HERE's [pricing page](https://www.here.com/pricing).
