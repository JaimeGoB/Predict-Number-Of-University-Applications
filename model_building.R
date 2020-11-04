# 2. Consider College data from the ISLR package. 
# These are described on page 54 of the textbook. 
# We would like to predict the number of applications received using 
# the other variables. All data will be taken as training data.
library(ISLR)
library(ggplot2)
library(boot)
library(caret)
library(glmnet)
library(dplyr)
library(pls) #pls & pcr

# Private
# A factor with levels No and Yes indicating private or public university
# 
# Apps
# Number of applications received
# 
# Accept
# Number of applications accepted
# 
# Enroll
# Number of new students enrolled
# 
# Top10perc
# Pct. new students from top 10% of H.S. class
# 
# Top25perc
# Pct. new students from top 25% of H.S. class
# 
# F.Undergrad
# Number of fulltime undergraduates
# 
# P.Undergrad
# Number of parttime undergraduates
# 
# Outstate
# Out-of-state tuition
# 
# Room.Board
# Room and board costs
# 
# Books
# Estimated book costs
# 
# Personal
# Estimated personal spending
# 
# PhD
# Pct. of faculty with Ph.D.'s
# 
# Terminal
# Pct. of faculty with terminal degree
# 
# S.F.Ratio
# Student/faculty ratio
# 
# perc.alumni
# Pct. alumni who donate
# 
# Expend
# Instructional expenditure per student
# 
# Grad.Rate
# Graduation rate

# Reading in college dataset and normalizing
college <- College %>% mutate_if(is.numeric,scale)

#########################################################################
# (a) Fit a linear model using least squares and report the LOOCV estimate 
# of the test error. 
#########################################################################

#Fitting a model using LSE
full_model <- glm(Apps ~ .,data = college)

#Computing LOOCV - test error
train.control <- trainControl(method = "LOOCV")
loocv_full_model <- train(Apps ~ ., 
                     data = college, 
                     method = "lm",
                     trControl = train.control)

# MSE 0.08525488
loocv_full_model <- cv.glm(college, full_model)
test_error_full_model <- loocv_full_model$delta[1]


#########################################################################
# (b) Fit a ridge regression model with lambda chosen by LOOCV.
# Report the estimated test error.
#########################################################################

#Generating matrices for glmnet function
X <- model.matrix(Apps ~ ., college)[, -1]
Y <- college$Apps
N <- length(Y) 

#Creating a sequence of 100 values from range
grid = 10^seq(-5,10, length.out = 100)

#Perfoming loocv to get best lambda value for ridge coefficients
#with 100 diferrent values from lambda
set.seed(1234)
cv_ridge_regression <- cv.glmnet(X, Y, nfolds = N, alpha = 0, type.measure = "mse", lambda = grid)
plot(cv_ridge_regression)

#Getting best lambda value to fit ridge regression model
best_lambda_ridge_regression <- cv_ridge_regression$lambda.min

######  fit model with best value of lambda found ###### 
ridge_model <- glmnet(X, Y, alpha = 0, lambda = best_lambda_ridge_regression)

###### compute loocv test error rate. #######
test_error_ridge_model <- min(cv_ridge_regression$cvm)

#########################################################################
# (c) Fit a lasso model with lambda chosen by LOOCV. 
# Report the estimated test error. 
#########################################################################

#Perfoming loocv to get best lambda value for ridge coefficients
#with 100 diferrent values from lambda
set.seed(1234)
cv_lasso_regression <- cv.glmnet(X, Y, nfolds = N, alpha = 1, type.measure = "mse", lambda = grid)
plot(cv_lasso_regression)

#Getting best lambda value to fit ridge regression model
best_lambda_lasso_regression <- cv_lasso_regression$lambda.min

######  fit model with best value of lambda found ###### 
ridge_model <- glmnet(X, Y, alpha = 1, lambda = best_lambda_lasso_regression)

###### compute loocv test error rate. #######
test_error_lasso_model <- min(cv_lasso_regression$cvm)

#########################################################################
# (d) Fit a PCR model with M chosen by LOOCV. 
# Report the estimated test error.
#########################################################################

######  Fitting pcr model ###### 
pcr_model = pcr(Apps~., data = college, scale=T, validation="LOO") 
validationplot(pcr_model, val.type="MSEP")
summary(pcr_model)

###### Calculating MSE ###### 
Y_actual <- c(college$Apps)
pred_y_pcr = predict(pcr_model, college, ncomp = 5)
test_error_pcr = mean((pred_y_pcr - Y_actual)^2)

#########################################################################
# (e) Fit a PLS model with M chosen by LOOCV. 
# Report the estimated test error.
#########################################################################

###### Fitting a PLS Model  ###### 
pls_model = plsr(Apps~., data=college, scale=T, validation="LOO") 
validationplot(pls_model, val.type="MSEP")

###### Calculating MSE ###### 
Y_actual <- c(college$Apps)
pred_y_pls = predict(pls_model, college, ncomp = 5)
test_error_pls = mean((pred_y_pls - Y_actual)^2)

#########################################################################
# (f) Compare the results from the five models. Which model(s) would you recommend? 
# Justify your conclusion.
#########################################################################

MSE <- c(test_error_full_model, test_error_ridge_model, test_error_lasso_model, test_error_pcr, test_error_pls)
Model <- c("Full Model","Ridge Regression", "Lasso Regression", "PCR", "PLS")
results <-data.frame(rbind(Model, round(MSE, 6)))
results

