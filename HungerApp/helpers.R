percent_map <- function(var, color, regions, legend.title, min = 0, max = 100) {

  # generate vector of fill colors for map
  shades <- colorRampPalette(c("white", color))(100)
  
  # constrain gradient to percents that occur between min and max
  percents <- as.integer(var)
  fills <- shades[percents]
 
  # overlay country borders
  map("world", col = "black", fill = FALSE, names=TRUE,
      lty = 1, lwd = 1, projection = "mercator", 
      myborder = 0, mar = c(0,0,0,0))
 
  # plot choropleth map
  map("world", regions=regions, fill = TRUE, col = fills, add=TRUE,
    resolution = 0, lty = 0, projection = "mercator", 
    myborder = 0, mar = c(0,0,0,0))
  
  # add a legend
  inc <- (max - min) / 4
  legend.text <- c(paste0(min),
    paste0(min + inc, " %"),
    paste0(min + 2 * inc, " %"),
    paste0(min + 3 * inc, " %"),
    paste0(max))
  
  legend("bottomleft", 
    legend = legend.text, 
    fill = shades[c(1, 25, 50, 75, 100)], 
    title = legend.title)
}