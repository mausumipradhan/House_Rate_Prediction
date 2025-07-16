library(shiny)
library(randomForest)
library(caTools)
library(ggplot2)

# Load and prepare data
housing.df <- read.table("housing.data", header = FALSE, sep = "")
names1 <- read.fwf("housing.names", skip = 30, n = 17, widths = c(-7,8,-60))
names2 <- as.character(names1[-c(3,6,15),])
names2 <- gsub(" ", "", names2)
names(housing.df) <- names2

# Train-test split
set.seed(12345)
sample <- sample.split(housing.df$MEDV, SplitRatio = 0.7)
train <- subset(housing.df, sample == TRUE)
test <- subset(housing.df, sample == FALSE)

# Train Random Forest model
model <- randomForest(MEDV ~ ., data = train)

# Define UI
ui <- fluidPage(
  titlePanel("🏡 House Price Predictor (Boston Housing Dataset)"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("CRIM", "Crime Rate (CRIM)", min = min(housing.df$CRIM), max = max(housing.df$CRIM), value = mean(housing.df$CRIM)),
      sliderInput("RM", "Average Number of Rooms (RM)", min = min(housing.df$RM), max = max(housing.df$RM), value = mean(housing.df$RM)),
      sliderInput("LSTAT", "Lower Status % (LSTAT)", min = min(housing.df$LSTAT), max = max(housing.df$LSTAT), value = mean(housing.df$LSTAT)),
      actionButton("predict", "Predict Price")
    ),
    mainPanel(
      h3("📊 Predicted Median House Price:"),
      verbatimTextOutput("priceOutput"),
      plotOutput("actualVsPred")
    )
  )
)

# Define Server
server <- function(input, output) {
  observeEvent(input$predict, {
    newdata <- data.frame(CRIM = input$CRIM,
                          ZN = mean(housing.df$ZN),
                          INDUS = mean(housing.df$INDUS),
                          CHAS = 0,
                          NOX = mean(housing.df$NOX),
                          RM = input$RM,
                          AGE = mean(housing.df$AGE),
                          DIS = mean(housing.df$DIS),
                          RAD = mean(housing.df$RAD),
                          TAX = mean(housing.df$TAX),
                          PTRATIO = mean(housing.df$PTRATIO),
                          B = mean(housing.df$B),
                          LSTAT = input$LSTAT)

    prediction <- predict(model, newdata)
    output$priceOutput <- renderText({
      paste("Predicted MEDV: $", round(prediction * 1000, 2))
    })
  })

  output$actualVsPred <- renderPlot({
    pred.rf <- predict(model, test)
    plot(pred.rf, test$MEDV, 
         xlab = "Predicted Price", ylab = "Actual Price", 
         pch = 3, col = "blue", main = "Actual vs Predicted Prices")
    abline(a = 0, b = 1, col = "red", lwd = 2)
  })
}

# Run the app
shinyApp(ui = ui, server = server)
