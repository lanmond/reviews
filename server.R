function(input,output)({
  
  data1 <- reactive({
    
    if(input$cateSelect == "Deptment"){
      data %>%
        count(.,Department_Name, Division_Name) %>% as.data.frame()
      }
  })
  
  
  output$catePlot = renderPlot({
    
    if (input$cateSelect == 'Deptartment'){  #plot1
      if(input$ageSelect != 'All'){
        data1 <- data %>% filter(Age_Group == input$ageSelect) %>% count(Department_Name) %>% mutate(num = n)
        
        # !!sym(input$cateSelect)
        ggplot(data1, aes(x=Department_Name, y=n)) + 
          geom_bar(aes(fill=Department_Name),stat = 'identity') +
          coord_flip() + 
          labs(x = data$Department_Name,
               y= 'Counts',
               title = 'Count of Category in Department Name')
      }
      else{
        data1 <- data %>% count(Department_Name) %>% mutate(num = n)
        
        # !!sym(input$cateSelect)
        ggplot(data1, aes(x=Department_Name, y=n)) + 
          geom_bar(aes(fill=Department_Name),stat = 'identity') +
          coord_flip() + 
          labs(x = data$Department_Name,
               y= 'Counts',
               title = 'Count of Category in Department Name')
      } 
    }
    else if (input$cateSelect == 'Division'){  #plot2
  
        data2 <- data %>% filter(Age_Group == input$ageSelect) %>% count(Division_Name) %>% mutate(num = n)
        
        # !!sym(input$cateSelect)
        data2 <- data.frame(data %>% count(Division_name))
        x2 <- as.factor(data2[,1])
        y2 <- data2[,2]
        
        ggplot(data2, aes(x= reorder(x2, y2), y=y2)) + 
          geom_bar(aes(fill=x2),stat = 'identity') +
          coord_flip() + 
          labs(x = data$Division_name,
               y= 'Counts',
               title = 'Count of Category in Division Name')
        
    }
    else if (input$cateSelect == 'Top_Clothing_ID'){ #plot3
        data3 <- data.frame(data %>% count(Clothing_ID) %>% top_n(n = 30))
        x <- as.factor(data3[,1])
        y <- data3[,2]
        
        #!!sym(input$cateSelect)
        ggplot(data3, aes(x= reorder(x, n), y=y)) + 
          geom_bar(aes(fill=x),stat = 'identity') +
          coord_flip() + 
          labs(x = data$Clothing_ID,
               y= 'Counts',
               title = 'Freqency Count of Top 30 Clothing ID:')
    }
    else if (input$cateSelect == 'Class'){ #plot5 
      data5 <- data.frame(data %>% count(Class_Name))
      x <- as.factor(data5[,1])
      y <- data5[,2]
      
      ggplot(data5, aes(x= reorder(x, n), y=y)) + 
        geom_bar(aes(fill=x),stat = 'identity') +
        coord_flip() + 
        labs(x = data$Class_Name,
             y= 'Counts',
             title = 'Freqency Count in Class Name')
    }
    else if (input$cateSelect == 'Rating'){ #plot5 
      data6 <- data.frame(data %>% count(Rating) %>% mutate(num = n)) 
      x <- as.factor(data6[,1])
      y <- data6[,2]
      
      ggplot(data6, aes(x= reorder(x, -n), y=y)) + 
        geom_bar(aes(fill=x),stat = 'identity') +
        labs(x = data$Rating,
             y= 'Counts',
             title = 'Rating')
    }
    else{ 
      data %>% 
        group_by(Rating,Clothing_ID) %>% 
        summarise(Count=n()) %>%
        arrange(desc(Count)) %>% 
        spread(Rating,Count) %>%
        rename('R1' = '1',
               'R2' = '2',
               'R3' = '3',
               'R4' = '4',
               'R5' = '5') %>% 
        na.omit() %>% 
        filter(R1==max(R1)|R2==max(R2)|R3==max(R3)|R4==max(R4)|R5==max(R5))
      
      data$Rating <- as.factor(data$Rating)
      data8 <- data %>% 
        group_by(Rating,Clothing_ID) %>% 
        summarise(Count=n()) %>% 
        top_n(n=5,wt = Count) %>% 
        ggplot(aes(x=Rating,y=Count)) + 
        geom_bar(aes(fill=Clothing_ID),position='dodge',stat='identity')
      ggplotly(data8)
    }
    })
  
  
  #tab2: count of categries in division name
 
  output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x <- data$Age
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        # draw the histogram with the specified number of bins
       hist(x, breaks = bins, col = 'darkgray', border = 'white')
      })
  
})