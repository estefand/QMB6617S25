##################################################
#
# QMB 6617.0081 Business Analytics for Managers
#
# Model Evaluation and Selection
# Tidyverse and Tidymodels Edition
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
#   from the tidyverse to estimate the regression model, 
#   as a step toward estimating machine-learning models. 
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



# Define model specification.
model_lm <- linear_reg() %>% 
  set_mode("regression") %>%
  set_engine("lm")




##################################################
# Estimate models on training data (2022 sample)
##################################################

#-------------------------------------------------
# First model predicts purchases.
#-------------------------------------------------

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


#-------------------------------------------------
# Second model predicts utilization.
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


#-------------------------------------------------
# Third model predicts log-odds of utilization.
#-------------------------------------------------

# Define model workflow.
model_wflow_lm_log_odds <- 
  workflow() %>% 
  add_model(model_lm) %>% 
  add_recipe(model_recipe_purch)

# Fit the model to the training data.
model_fit_lm_log_odds <- 
  model_wflow_lm_log_odds %>% 
  fit(data = purchases_full)


# Inspect results.
model_fit_lm_log_odds %>%
  extract_fit_parsnip() %>%
  tidy() 


##################################################
# Calculate MAE on predictions
##################################################

#--------------------------------------------------
# Linear model on purchases.
#--------------------------------------------------

# Join predictions and rename for this model.
purchases_full <- model_fit_lm_purch %>% 
  predict(purchases_full) %>%
  bind_cols(purchases_full) %>%
  mutate(
    pred_purch = .pred, 
    error_purch = pred_purch - purchases
  ) %>%
  select(-c(.pred))

summary(purchases_full)

#--------------------------------------------------
# Linear model on utilization.
#--------------------------------------------------

# Join predictions and rename for this model.
purchases_full <- model_fit_lm_util %>% 
  predict(purchases_full) %>%
  bind_cols(purchases_full) %>%
  mutate(
    pred_util = .pred, 
    pred_purch_util = pred_util*credit_limit, 
    error_purch_util = pred_purch_util - purchases
  ) %>%
  select(-c(.pred))

summary(purchases_full)

#--------------------------------------------------
# Linear model on log odds of utilization.
#--------------------------------------------------

# Join predictions and rename for this model.
purchases_full <- model_fit_lm_util %>% 
  predict(purchases_full) %>%
  bind_cols(purchases_full) %>%
  mutate(
    pred_log_odds = .pred, 
    pred_util_log_odds = exp(pred_log_odds) / (1 + exp(pred_log_odds)), 
    pred_purch_log_odds = pred_util_log_odds*credit_limit, 
    error_purch_log_odds = pred_purch_log_odds - purchases
  ) %>%
  select(-c(.pred))

summary(purchases_full)





##################################################
# Calculate MAE to Compare Models Across Samples
##################################################

purchases_full %>%
  group_by(year) %>%
  summarize(
    MAE_purch = mean(abs(error_purch)), 
    MAE_util = mean(abs(error_purch_util)), 
    MAE_log_odds = mean(abs(error_purch_log_odds))
  )



##################################################
# End
##################################################

