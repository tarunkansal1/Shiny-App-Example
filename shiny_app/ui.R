#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(e1071)
# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Prediction of Species"),

    sidebarLayout(
        sidebarPanel(
            sliderInput("Sepal.Length","Sepal Length: ",min = 0,max = 10,value = 5,step = 0.1),
            sliderInput("Sepal.width","Sepal Width: ",min=0,max=5,value = 2.5,step = 0.1),
            sliderInput("Petal.Length","Petal Length: ",min=0,max=10,value = 5,step = 0.1),
            sliderInput("Petal.width","Petal Width: ",min=0,max=3,value = 1.2,step = 0.1)
                    ),
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs",
                tabPanel("Description",br(),h1("Prediction of Species"),
                         p("In this app when you enter various inputs asked in 
                           sidebar pannel it will give a predicted result of the
                           species best suited according to the inputs."),
                         p("This prediction is based on the linear discriminant
                           analysis method in R with an accuracy of 97%"),
                         p("There are 3 species:"),
                         p("Setosa"),
                         p("Versicolor"),
                         p("Virginica")),
                tabPanel("plot",br(),h3("Prediction according to fitted model: "),
                         h3(textOutput("distPlot")),plotOutput("plot")),
                tabPanel("Code",br(),code("fit <- train(Species~.,data = iris,method = 'lda')"),br(),
                                          code("df <- data.frame(Sepal.Length = input$Sepal.Length,
                         Sepal.Width = input$Sepal.width,
                         Petal.Length = input$Petal.Length,
                         Petal.Width = input$Petal.width)
        levels(iris$Species)[ predict(fit,newdata = df)]"))
            )
        )
    )
))
