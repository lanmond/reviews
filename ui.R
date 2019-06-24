fluidPage(
  
  titlePanel(h4("Reviews on Womens Clothings")),
  
  sidebarLayout(
    sidebarPanel(
        selectizeInput(inputId = 'cateSelect',
                       label = 'Category Selection',
                       choices = c('Deptartment',
                                   'Division',
                                   'Top_Clothing_ID',
                                   'Class',
                                   'Rating',
                                   'Top_Clothing_Rating')
        ),
        selectizeInput(inputId = 'ageSelect',
                       label = 'Specific Age Group',
                       choices = c('All', unique(data$Age_Group)[order(unique(data$Age_Group))]),
                       selected = 'All'
        ),
        sliderInput(inputId = "bins",
                    label = "Age Distribution Demo: TAB2",
                    min = 1,
                    max = 50,
                    value = 30)
        ),
        mainPanel(tabsetPanel(
                          tabPanel('Frequency Distribution',
                                     plotOutput('catePlot')
                                  ),
                          
                          tabPanel('Age Distribution',
                                   fluidRow(
                                     column(12, plotOutput('distPlot')))
                                  )
                          
                            )
                  )
        )
  )    