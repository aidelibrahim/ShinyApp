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
# Define server logic required to draw a histogram
function(input, output) {
 data1 = read.csv(file ="bid_2015.csv",sep=",",header = TRUE)
  data2 = read.csv(file="CS.csv",sep=",",header = TRUE)  
 # data1 = bid_2015
#  data2 = CS
  tt = table(data1$Bidang,data1$UA)

  
  output$graf = reactivePlot(function(){
    
     uni = data1[data1$UA == input$UA,1]
     bid = data1[data1$UA == input$UA,2]
     enrol = data1[data1$UA == input$UA,3]
     e3 = data1[data1$UA == input$UA,4]
     e4 = data1[data1$UA == input$UA,5]
     
     gg = data.frame(uni,bid,enrol,e3,e4)
     axi = as.character(bid)
     
     p = ggplot(gg,aes(bid,enrol),ylab ="Enrolment" , xlab="Courses",label = TRUE)+geom_point(size=7 , aes(colour = factor(bid)))
     
     print(p)
    
  })
  
  output$year = reactivePlot(function(){
    uni = data1[data1$UA == input$UA,1]
    bid = data1[data1$UA == input$UA,2]
    enrol = data1[data1$UA == input$UA,3]
    e3 = data1[data1$UA == input$UA,4]
    e4 = data1[data1$UA == input$UA,5]
    gg = data.frame(uni,bid,enrol,e3,e4)
    axi = as.character(bid)
    
    p = ggplot(gg,aes(bid,y=value,color=variable)) + geom_point(aes(y=enrol,col="2015"),size=7)+geom_point(aes(y=e3,col="2014"),size=7)+geom_point(aes(y=e4,col="2013"),size=7)
    print(p)
  })
  
  
  output$view <- reactiveTable(function(){
    
    if(input$UA != "ALL"){
      data1 = data1[data1$UA == input$UA]
      
    }
    if(input$bid != "ALL"){
      data1= data1[data1$Bidang == input$bid]
      
    }
    #data1
    
    head(data1,n=input$obs)
  })
  
  output$tt = reactivePlot({
    plot(data2$Gender,data2$desired.degree.courses)
  })
  
  
  output$view1 <- renderPlot({
   # head(data2,input$obs)
    plot(data2$Gender,data2$UA.chose.for.CS,labels = TRUE) 
  })
  
  
  output$summary <- renderPrint({
    summary(data1)})
  
}
