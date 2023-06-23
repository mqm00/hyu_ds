library(shiny)
library(magrittr)
library(dplyr)
library(ggplot2)
library(palmerpenguins)
library(DT)
library(rsconnect)

ui = fluidPage(
  
  titlePanel("펭귄 데이터 분석"),
  sidebarLayout(
    
    sidebarPanel(
      checkboxGroupInput("penguin", label = '펭귄 종류를 선택하세요',
                         choices = list('Adelie', 'Gentoo', 'Chinstrap'),
                         selected = 'Adelie'),
      selectInput("x", "x축을 선택하세요.", choices = list('bill_length_mm', 'bill_depth_mm', 'flipper_length_mm', 'body_mass_g'),
                  selected = 'bill_length_mm'
                  ),
      selectInput("y", "y축을 선택하세요.", choices = list('bill_length_mm', 'bill_depth_mm', 'flipper_length_mm', 'body_mass_g'),
                  selected = 'body_mass_g'
      ),
      sliderInput("slider", "점 크기를 선택하세요", min = 1, max = 10, value = 5),
    ),
    
    mainPanel(
      DT::dataTableOutput('penguins_table'),
      plotOutput('penguins_plot')
    )
  )
)

server = function(input, output, session) {
  
  sel_penguins = reactive({
    penguins %>%
      filter(species %in% input$penguin)
  })
  
  output$penguins_table = DT::renderDataTable({
    
    datatable(sel_penguins())
  })
  
  output$penguins_plot = renderPlot({
    sel_penguins() %>%
      ggplot(aes_string(input$x, input$y, color = 'species', shape = 'sex')) +
      geom_point(size = input$slider)
    
  })
  
}
shinyApp(ui, server)