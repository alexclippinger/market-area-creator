
server = function(input, output) {
  
  poi = eventReactive(input$go,{
    if (input$poi_type == "Coordinates") {
      st_as_sf(
        tibble(latitude = input$poi_latitude, longitude = input$poi_longitude), 
        coords = c("longitude", "latitude"), 
        crs = 4326
      )
    }
    else if (input$poi_type == "Address") {
      get_coords_from_address(input$poi_address)
    }
  })
  
  service_area = eventReactive(input$go,{
    hereR::isoline(
      poi = poi(),
      datetime = input$time_of_departure,
      range = if (input$range_type == "Distance") {mi_to_meters(input$distance_input)} 
              else if (input$range_type == "Time") {hrs_to_secs(input$time_input)},
      range_type = str_to_lower(input$range_type)
    )
  })
  
  zipcodes = eventReactive(input$go,{
    create_zip_data(epsg = 4326)
  })
  
  service_area_zips = eventReactive(input$go,{
    zip_mask = lengths(st_intersects(zipcodes(), service_area())) > 0
    service_area_zips = zipcodes()[zip_mask, ]
    return(service_area_zips)
  })
  
  output$map = renderTmap({
    tm_shape(service_area_zips()) +
      tm_polygons(col = "darkgreen", alpha = 0.5, id = "GEOID10") +
    tm_shape(service_area()) +
      tm_polygons(col = "grey", alpha = 0.5, id = "Service Area") +
    tm_shape(poi()) +
      tm_dots()
  })
  
  output$download_zip_list = downloadHandler(
    filename = function() { 
      paste0("service_area-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(
        service_area_zips() %>% mutate(across(everything(), as.character)), 
        file)
    }
  )
  
  output$download_zip_shp = downloadHandler(
    filename = function() { 
      paste0("service_area_zips-", Sys.Date(), ".geojson")
    },
    content = function(file) {
      st_write(service_area_zips(), file)
    }
  )
  
  output$download_isoline_shp = downloadHandler(
    filename = function() { 
      paste0("service_area-", Sys.Date(), ".geojson")
    },
    content = function(file) {
      st_write(service_area(), file)
    }
  )
  
}



