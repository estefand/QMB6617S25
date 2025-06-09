##################################################
#
# QMB 6617.0081 Business Analytics for Managers
#
# Model Evaluation and Selection
# Tidyverse and Tidymodels Edition
# with Machine Learning Models
#
# Lealand Morin, Ph.D.
# Adjunct Professor
# College of Business
# University of Central Florida
#
# June 9, 2025
#
##################################################
#
# tidymodels_example gives an example of a model evaluation
#   for three specifications by considering out-of-sample validation
#   on a dataset of purchases from credit-card applications.
# This version uses the tidymodels package and other operations 
#   from the tidyverse to estimate machine-learning models. 
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# You need to set the working directory to the location
# of your files.
# setwd("/path/to/your/folder")
# Find this path as follows:
# 1. Click on the "File" tab in the bottom right pane.
# 2. Browse to the folder on your computer that contains your R files.
# 3. Click the gear icon and choose the option "Set as Working Directory."
# 4. Copy the command from the Console in the bottom left pane.
# 5. Paste the command below:


# setwd("~/GitHub/QMB6617F25_LM/assignment_04")

# Now, RStudio should know where your files are.



# The tidymodels library is required.
library(tidyverse)
library(tidymodels)
# Other models for machine-learning models are also required.
library(randomForest)


# The csv file used below must be in the working directory.
# If you an error message, make sure that the file is
# located in your working directory.
# Also make sure that the name has not changed.


##################################################
# Loading the Data
##################################################

applications <- read.csv('applications_full.csv')

# Inspect the contents.
summary(applications)
# Make sure there are no problems with the data.

credit_bureau <- read.csv('credit_bureau_full.csv')

# Inspect the contents.
summary(credit_bureau)
# Make sure there are no problems with the data.

demographic <- read.csv('demographic_full.csv')

# Inspect the contents.
summary(demographic)
# Make sure there are no problems with the data.



##################################################
# Join into a single dataset
##################################################

# Join the credit data first.
purchases_full <- merge(applications, credit_bureau,
                        by = c('ssn', 'year'))
# Join by SSN and year but not by (possibly stale) zip code. 

summary(purchases_full)


# Join the dempgraphic data by application zip code (not credit bureau).
purchases_full <- merge(purchases_full, demographic,
                        by.x = c('zip_code.x', 'year'),
                        by.y = c('zip_code', 'year'))

summary(purchases_full)


##################################################
# Create new variables
##################################################


purchases_full[, 'utilization'] <- 
  purchases_full[, 'purchases']/purchases_full[, 'credit_limit']

summary(purchases_full[, 'utilization'])


purchases_full[, 'log_odds_util'] <- 
  log(purchases_full[, 'utilization']/(1 - purchases_full[, 'utilization']))

summary(purchases_full[, 'log_odds_util'])



##################################################
# Separate into training and testing datasets
##################################################


# Training sample (for estimation) is from year 2022.
sel_rows <- purchases_full[, 'year'] == 2022

purchases_2022 <- purchases_full[sel_rows, ]


summary(purchases_2022)


# No need for the other data frames, will automate later. 


##################################################
# Define Model Recipes
##################################################


# Define model recipe to predict purchases.
model_recipe_purch <- recipe(
  purchases ~ fico + income + homeownership + 
    num_late + past_def + num_bankruptcy +
    avg_income + density, 
  data = purchases_2022) %>%
  step_dummy(homeownership) # %>% 
# step_dummy(num_late) %>%  
# step_dummy(past_def) %>%
# step_dummy(num_bankruptcy)


# Define model recipe to predict utilization.
model_recipe_util <- recipe(
  utilization ~ fico + income + homeownership + 
    num_late + past_def + num_bankruptcy +
    avg_income + density, 
  data = purchases_2022) %>% 
  step_dummy(homeownership) # %>% 
# step_dummy(num_late) %>%  
# step_dummy(past_def) %>%
# step_dummy(num_bankruptcy)


# Define model recipe to predict log-odds of utilization.
model_recipe_log_odds <- recipe(
  log_odds_util ~ fico + income + homeownership + 
    num_late + past_def + num_bankruptcy +
    avg_income + density, 
  data = purchases_2022) %>% 
  step_dummy(homeownership) # %>% 
# step_dummy(num_late) %>%  
# step_dummy(past_def) %>%
# step_dummy(num_bankruptcy)






##################################################
# Estimate models on training data (2022 sample)
##################################################

#-------------------------------------------------
# First model predicts utilization with linear regression.
#-------------------------------------------------

# Define model specification.
model_lm <- linear_reg() %>% 
  set_mode("regression") %>%
  set_engine("lm")

# Define model workflow.
model_wflow_lm_purch <- 
  workflow() %>% 
  add_model(model_lm) %>% 
  add_recipe(model_recipe_purch)

# Fit the model to the training data.
model_fit_lm_purch <- 
  model_wflow_lm_purch %>% 
  fit(data = purchases_full)


# Inspect results.
model_fit_lm_purch %>%
  extract_fit_parsnip() %>%
  tidy() 

# Join predictions and rename for this model.
purchases_full <- model_fit_lm_purch %>% 
  predict(purchases_full) %>%
  bind_cols(purchases_full) %>%
  mutate(
    pred_lm_purch = .pred, 
    error_lm_purch = pred_lm_purch - purchases
  ) %>%
  select(-c(.pred))

summary(purchases_full)




#-------------------------------------------------
# Second model predicts utilization with linear regression.
#-------------------------------------------------

# Define model workflow.
model_wflow_lm_util <- 
  workflow() %>% 
  add_model(model_lm) %>% 
  add_recipe(model_recipe_util)

# Fit the model to the training data.
model_fit_lm_util <- 
  model_wflow_lm_util %>% 
  fit(data = purchases_full)

# Inspect results.
model_fit_lm_util %>%
  extract_fit_parsnip() %>%
  tidy() 

# Join predictions and rename for this model.
purchases_full <- model_fit_lm_util %>% 
  predict(purchases_full) %>%
  bind_cols(purchases_full) %>%
  mutate(
    pred_lm_util = .pred, 
    pred_lm_purch_util = pred_lm_util*credit_limit, 
    error_lm_purch_util = pred_lm_purch_util - purchases
  ) %>%
  select(-c(.pred))

summary(purchases_full)


#-------------------------------------------------
# Third model predicts purchases with a decision tree.
#-------------------------------------------------

model_dt <- decision_tree(
  mode = "regression",
  engine = "rpart",
  cost_complexity = 0.1,
  tree_depth = 2,
  min_n = 5
)

# Define model workflow.
model_wflow_dt <- 
  workflow() %>% 
  add_model(model_dt) %>% 
  add_recipe(model_recipe_purch)

# Fit the model to the training data.
model_fit_dt <- 
  model_wflow_dt %>% 
  fit(data = purchases_full)

# Join predictions and rename for this model.
purchases_full <- model_fit_dt %>% 
  predict(purchases_full) %>%
  bind_cols(purchases_full) %>%
  mutate(
    pred_dt = .pred, 
    error_dt = pred_dt - purchases
  ) %>%
  select(-c(.pred))

summary(purchases_full)
# Calculate MAE on predictions
purchases_full %>%
  group_by(year) %>%
  summarize(
    MAE_lm_purch = mean(abs(error_lm_purch)), 
    MAE_lm_util = mean(abs(error_lm_purch_util)), 
    MAE_dt = mean(abs(error_dt))
  )


#-------------------------------------------------
# Fourth model predicts purchases using random forest.
#-------------------------------------------------

model_rf <- rand_forest(mtry = 8,
                     trees = 100,
                     min_n = 5) %>%
  set_mode("regression") %>%
  set_engine("randomForest") 


# Define model workflow.
model_wflow_rf <- 
  workflow() %>% 
  add_model(model_rf) %>% 
  add_recipe(model_recipe_purch)

# Fit the model to the training data.
model_fit_rf <- 
  model_wflow_rf %>% 
  fit(data = purchases_full)

# Join predictions and rename for this model.
purchases_full <- model_fit_rf %>% 
  predict(purchases_full) %>%
  bind_cols(purchases_full) %>%
  mutate(
    pred_rf = .pred, 
    error_rf = pred_rf - purchases
  ) %>%
  select(-c(.pred))

summary(purchases_full)

# Calculate MAE on predictions
purchases_full %>%
  group_by(year) %>%
  summarize(
    MAE_lm_purch = mean(abs(error_lm_purch)), 
    MAE_lm_util = mean(abs(error_lm_purch_util)), 
    MAE_rf = mean(abs(error_rf))
  )


#-------------------------------------------------
# Fourth model predicts purchases using random forest.
#-------------------------------------------------

model_xgb <-
  boost_tree(trees = 100,
             min_n = 5,
             tree_depth = 2,
             learn_rate = 0.1,
             loss_reduction = 0.1,
             sample_size = 0.4) %>%
  set_mode("regression") %>%
  set_engine("xgboost")


# Define model workflow.
model_wflow_xgb <- 
  workflow() %>% 
  add_model(model_xgb) %>% 
  add_recipe(model_recipe_purch)

# Fit the model to the training data.
model_fit_xgb <- 
  model_wflow_xgb %>% 
  fit(data = purchases_full)

# Join predictions and rename for this model.
purchases_full <- model_fit_xgb %>% 
  predict(purchases_full) %>%
  bind_cols(purchases_full) %>%
  mutate(
    pred_xgb = .pred, 
    error_xgb = pred_xgb - purchases
  ) %>%
  select(-c(.pred))

summary(purchases_full)


# Calculate MAE on predictions
purchases_full %>%
  group_by(year) %>%
  summarize(
    MAE_lm_purch = mean(abs(error_lm_purch)), 
    MAE_lm_util = mean(abs(error_lm_purch_util)), 
    MAE_xgb = mean(abs(error_xgb))
  )


##################################################
# Calculate MAE to Compare Models Across Samples
##################################################

purchases_full %>%
  group_by(year) %>%
  summarize(
    MAE_lm_purch = mean(abs(error_lm_purch)), 
    MAE_lm_util = mean(abs(error_lm_purch_util)), 
    # MAE_log_odds = mean(abs(error_purch_log_odds)),  # Skipped.
    MAE_dt = mean(abs(error_dt)), 
    MAE_rf = mean(abs(error_rf)), 
    MAE_xgb = mean(abs(error_xgb))
  )

# Now remember, we obtained these results using particular choices of hyperparameters, 
# such as:
# trees = 100,
# min_n = 5,
# tree_depth = 2,
# learn_rate = 0.1,
# loss_reduction = 0.1,
# sample_size = 0.4

# Can you try using different values of the hyperparameters to
# obtain a better fit?
# Try some combinations 
# Report the winning algorithm with the winning combination of hyperparameter values.




##################################################
# End
##################################################

