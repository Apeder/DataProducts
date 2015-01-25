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
              textOutput("text2"), 
              h2("Documentation"),
                p("This application shows childhood malnutrition rates based on the percentage of children under 5 years old who are underweight. Children who are underweight are likely malnourished and may also suffer from stunting that will gravely impact their lifetime health and productivity. The data was collected between 1985a and 2011 by the World Health Organization. Notably, the data covers only a small number of countries, and this illustrates the need for better global data collection on childhood nutrition."), 
              
                p("The app displays the average rate per region based on your selection in the first dropdown box, and the second drop down box toggles between male rates of malnutrition, female rates of malnutrition and the total combined rate expressed as a color gradient on the map. The slider shows data for the year selected.")
              )
  )
))