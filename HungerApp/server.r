setwd("~/Rfiles/DataProducts")
hungerdat <- read.csv("data/hunger.csv")

attach(hungerdat)  
hungermale <- hungerdat[Sex=="Male", 4:8]
hungermale$male_rate <- hungermale$Display.Value
hungermale <- cbind(hungermale[, 1:3], hungermale[,6])
colnames(hungermale)[4] <- "male_rate"

hungerfmale <- hungerdat[Sex=="Female", 4:8]
hungerfmale$female_rate <- hungerfmale$Display.Value
hungerfmale <- cbind(hungerfmale[, 1:3], hungerfmale[,6])
colnames(hungerfmale)[4] <- "female_rate"

hungerboth <- hungerdat[Sex=="Both sexes", 4:8]
hungerboth$total_rate <- hungerboth$Display.Value
hungerboth <- cbind(hungerboth[, 1:3], hungerboth[,6])
colnames(hungerboth)[4] <- "total_rate"
  
hdatdispl <- join(hungermale, hungerfmale)
hdatdisplfinal <- join(hdatdispl, hungerboth)
hdatdisplfinal$Country <- as.character(hdatdisplfinal$Country)

library(maps)
library(mapproj)
source("helpers.R")

shinyServer(function(input, output) {
  
  output$map <- renderPlot({
    data <- switch(input$gen, 
                   "Male" = hdatdisplfinal$male_rate,
                   "Female" = hdatdisplfinal$female_rate,
                   "Both" = hdatdisplfinal$total_rate) 
    
    color <- switch(input$gen, 
                    "Male" = "blue",
                    "Female" = "pink",
                    "Both" = "purple")
    
    legend <- switch(input$gen, 
                     "Male" = "% Male",
                     "Female" = "% Female", 
                     "Both" = "Total %")
    
    percent_map(var=data, color= color, legend.title= legend, 
                max=input$Year, min=input$Year) 
    
    output$text1 <- renderText({
      paste("Children aged <5 years underweight in", input$Year)
    })
 })
})


