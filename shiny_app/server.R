#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(caret)
library(gridExtra)
library(e1071)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    fit <- train(Species~.,data = iris,method = "lda")
    output$distPlot <- renderText({

        df <- data.frame(Sepal.Length = input$Sepal.Length,
                         Sepal.Width = input$Sepal.width,
                         Petal.Length = input$Petal.Length,
                         Petal.Width = input$Petal.width)
        levels(iris$Species)[ predict(fit,newdata = df)]

    })
    output$plot <- renderPlot({
       p1 <- ggplot(iris,aes(x=Petal.Length,y=Petal.Width,color = Species))+
            geom_point(aes(color= Species))
        p2 <- ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,color = Species))+
            geom_point(aes(color= Species))
        grid.arrange(p1,p2,nrow=2)
    })

})
