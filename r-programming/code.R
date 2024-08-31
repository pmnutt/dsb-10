library(tidyverse)
library(caret)

mtcars

# split data 70:20

split_data <- function(data){
  set.seed(1412)
  n <- nrow(data) 
  id <- sample(1:n,size = 0.7*n)
  train_df <-  data[id,]
  test_df <- data[-id,]
  return(list(train = train_df,
              test = test_df))
}
prep_df <-  split_data(mtcars)

#k-fold cross validation
set.seed(1412)

grid_k <- data.frame(k=c(3,5))

ctrl <- trainControl(method = "repeatedcv",number = 5,repeats = 5 ,verboseIter = TRUE)
knn <-train(mpg~.,data = prep_df$train, 
            method ="knn",
            metric = "MAE",
            trControl =ctrl,
            tuneLegth = 4
            )

