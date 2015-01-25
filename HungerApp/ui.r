shinyUI(fluidPage(
  titlePanel("Global Childhood Malnourishment"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select region, gender and time range of interest"),
      
      selectInput("reg", label = "Region", 
                  choices = list("Africa", "Americas",
                                 "Eastern Mediterranean", "Europe", 
                                 "South-East Asia", "Western Pacific"), 
                  selected = "Africa"),
      
      selectInput("gen", label = "Gender", 
                  choices = list("Male", "Female",
                                 "Both"), 
                  selected = "Male"),
      
      sliderInput("Year", label="Year", 
                  min=1985, max=2011, value=1985, step=1,
                  format="###0",animate=TRUE)
    ),
    
    mainPanel(plotOutput("map"), 
              textOutput("text1"),
              textOutput("text2")
              )
  )
))