setwd("~/Rfiles/DataProducts")
hungerdat <- read.csv("data/hunger.csv")
library(plyr)

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
hdatdisplfinal$Country <- gsub("Viet Nam", "Vietnam", hdatdisplfinal$Country)
hdatdisplfinal <- hdatdisplfinal[hdatdisplfinal$Year >= 1985,]
hdatdisplfinal$WHO.region <- as.character(hdatdisplfinal$WHO.region)

library(maps)
library(mapproj)
source("helpers.R")

shinyServer(function(input, output) { 
  
  output$map <- renderPlot({
    
    data <- hdatdisplfinal[hdatdisplfinal$Year==input$Year,] 
    
    regions <- data$Country
    
    data1 <- switch(input$gen, 
                   "Male" = data$male_rate,
                   "Female" = data$female_rate,
                   "Both" = data$total_rate) 
    
    color <- switch(input$gen, 
                    "Male" = "purple",
                    "Female" = "green",
                    "Both" = "brown")
    
    legend <- switch(input$gen, 
                     "Male" = "% Male",
                     "Female" = "% Female", 
                     "Both" = "Total %")
    
    percent_map(var=data1, color= color, regions=regions, legend.title= legend) 
    
    output$text1 <- renderText({
      paste("Children aged <5 years underweight in", input$Year)
    })
    output$text2 <- renderText({
      
      data <- hdatdisplfinal[hdatdisplfinal$Year==input$Year & 
                               hdatdisplfinal$WHO.region==input$reg,]
      
      paste("Average rate of children <5 years underweight in", input$reg, ":", 
            round(mean(data$total_rate), 2),"%")
    })
  })
})

