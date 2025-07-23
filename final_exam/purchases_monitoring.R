##################################################
#
# QMB 6617.0081 Business Analytics for Managers
#
# Final Examination: Model Monitoring
#
# Lealand Morin, Ph.D.
# Adjunct Professor
# College of Business
# University of Central Florida
#
# June 29, 2025
#
##################################################
#
# purchases_monitoring creates figures for monitoring 
#   the performance of a model after the model is built
#   and used for decision making later. 
#   The example is based on a linear regression model built
#   on a dataset of purchases made on credit cards.
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


# setwd("~/GitHub/QMB6617S25_LM/final_exam")

setwd("C:/Users/estef/OneDrive/Desktop/2025 Summer Semester/Business Analytics for Managers/QMB6617S25/final_exam")


# Now, RStudio should know where your files are.



# The tidymodels library is required.
library(tidyverse)
library(tidymodels)
# Other models for machine-learning models could also be used.
library(randomForest)
library(xgboost)


# The csv file used below must be in the working directory.
# If you an error message, make sure that the file is
# located in your working directory.
# Also make sure that the name has not changed.


##################################################
# Loading the Data
##################################################

# First, read in the production data.
purchases_prod <- read.csv('purchases_prod.csv')

summary(purchases_prod)




##################################################
# Create new variables
##################################################

# Account for missing FICO scores.
purchases_prod[, 'fico_orig'] <- purchases_prod[, 'fico']
purchases_prod[is.na(purchases_prod[, 'fico_orig']), 'fico'] <- 0
purchases_prod[, 'fico_missing'] <- as.numeric(is.na(purchases_prod[, 'fico_orig']))



# Other variables might be useful for analysis or estimation.
purchases_prod[, 'utilization'] <- 
  purchases_prod[, 'purchases']/purchases_prod[, 'credit_limit']

summary(purchases_prod[, 'utilization'])


purchases_prod[, 'log_odds_util'] <- 
  log(purchases_prod[, 'utilization']/(1 - purchases_prod[, 'utilization']))

summary(purchases_prod[, 'log_odds_util'])

summary(purchases_prod)





################################################################################
# Estimate model and calculate predictions.
# This script will use the tidymodels workflow
################################################################################

# We estimated many models and this was the model we settled on.
purchases_2002 <- purchases_prod[purchases_prod[, 'year'] == 2002, ]


##################################################
# Define Model Recipe(s)
##################################################


# Define model recipe to predict purchases.
model_recipe_purch <- recipe(
  purchases ~ fico + fico_missing +
    income + homeownership + 
    num_late + past_def + num_bankruptcy +
    avg_income + density, 
  data = purchases_2002) %>%
  step_dummy(homeownership) # %>% 
# step_dummy(num_late) %>%  
# step_dummy(past_def) %>%
# step_dummy(num_bankruptcy)

# Need number of variables for R-squared below.
num_vars <- 9

##################################################
# Define Model Workflow(s)
##################################################

# For linear regression:
# Define model specification.
my_model <- linear_reg() %>% 
  set_mode("regression") %>%
  set_engine("lm")


# # For XGboost:
# my_model <-
#   boost_tree(trees = 100,
#              min_n = 5,
#              tree_depth = 2,
#              learn_rate = 0.1,
#              loss_reduction = 0.1,
#              sample_size = 0.4) %>%
#   set_mode("regression") %>%
#   set_engine("xgboost")


##################################################
# Estimate selected model
##################################################

# Define model workflow.
my_model_wflow <- 
  workflow() %>% 
  add_model(my_model) %>% 
  add_recipe(model_recipe_purch)

# Fit the model to the training data.
model_fit <- 
  my_model_wflow %>% 
  fit(data = purchases_2002) # Make sure this is the sample, not the full dataset.

# Join predictions and rename for this model.
purchases_prod <- model_fit %>% 
  predict(purchases_prod) %>%
  bind_cols(purchases_prod) %>%
  mutate(
    pred_purchases = .pred, 
    # If dependent variables is not purchases (such as utilization)
    # be sure to transform it back to purchases.
    error_purchases = pred_purchases - purchases
  ) %>%
  select(-c(.pred))

summary(purchases_prod)


# Calculate MAE on predictions
purchases_prod %>%
  filter(year <= 2005) %>%
  group_by(year) %>%
  summarize(
    MAE = mean(abs(error_purchases))
  )
# Be careful only to use the first couple of years to evaluate your model.
# Base your decision of the model design on the years 2002-2005.





################################################################################
# Tests for validity of predictions
################################################################################

# Initial data preparation.

# We could use the tidyverse to create the tables below, 
# but the already existed in base R, from the tractor and loan examples.
# Copy it back to a data.frame.
purchases_prod <- data.frame(purchases_prod)

# Copy columns from training sample in year 2002.
purchases_2002 <- purchases_prod[purchases_prod[, 'year'] == 2002, ]

#-------------------------------------------------------------------------------
# Plot R-squared and MAE by year.
#-------------------------------------------------------------------------------

year_list <- seq(min(purchases_prod[, 'year']), 
                 max(purchases_prod[, 'year']))


validity_stats <- data.frame(year = year_list, 
                             R_squared = numeric(length(year_list)), 
                             MAE = numeric(length(year_list)), 
                             avg_purchases = numeric(length(year_list)), 
                             Q1_purchases = numeric(length(year_list)), 
                             Q3_purchases = numeric(length(year_list)),
                             avg_pred_purchases = numeric(length(year_list)),
                             Q1_pred_purchases = numeric(length(year_list)),
                             Q3_pred_purchases = numeric(length(year_list)))

for (year_num in 1:length(year_list)) {
  
  # Get sample for this year.
  this_year <- year_list[year_num]
  purchases_prod_sel <- purchases_prod[, 'year'] == this_year
  num_obs_year <- sum(purchases_prod_sel)
  purchases_prod_year <- purchases_prod[purchases_prod_sel, ]
  
  # Calculate R_squared.
  R_squared <- 1 - 
    sum(( purchases_prod_year[, 'error_purchases'] )^2) / 
    sum((purchases_prod_year[, 'purchases'] - 
           mean(purchases_prod_year[, 'purchases']))^2)
  validity_stats[year_num, 'R_squared'] <- 
    1 - (1 - R_squared)*(num_obs_year - 1) / 
    (num_obs_year - num_vars - 1)
  
  # Calculate MAE.
  validity_stats[year_num, 'MAE'] <- mean(abs(purchases_prod_year[, 'error_purchases']))
  
  # Calculate average purchases, along with interquartile range. 
  validity_stats[year_num, 'avg_purchases'] <- mean(purchases_prod_year[, 'purchases'])
  validity_stats[year_num, 'Q1_purchases'] <- quantile(purchases_prod_year[, 'purchases'], 0.25)
  validity_stats[year_num, 'Q3_purchases'] <- quantile(purchases_prod_year[, 'purchases'], 0.75)
  
  # Calculate average predicted purchases.
  validity_stats[year_num, 'avg_pred_purchases'] <- mean(purchases_prod_year[, 'pred_purchases'])
  validity_stats[year_num, 'Q1_pred_purchases'] <- quantile(purchases_prod_year[, 'pred_purchases'], 0.25)
  validity_stats[year_num, 'Q3_pred_purchases'] <- quantile(purchases_prod_year[, 'pred_purchases'], 0.75)
  
  
}

validity_stats


# Plot Adjusted R_squared
fig_file <- "Figures/validity/R_squared.png"
png(fig_file)

plot(validity_stats[, 'year'], 
     validity_stats[, 'R_squared'], 
     main = 'R-Squared of Model in Production',
     xlab = 'Year', 
     ylab = 'Adjusted R_squared',
     lwd = 3, 
     type = 'l',
     col = 'blue', 
     ylim = c(0, 1)
)
abline(h = validity_stats[1, 'R_squared'], 
       lty = 'dashed', lwd = 2)
dev.off()


# Plot MAE.
fig_file <- "Figures/validity/MAE.png"
png(fig_file)

plot(validity_stats[, 'year'], 
     validity_stats[, 'MAE'], 
     main = 'Mean Absolute Error of Model in Production',
     xlab = 'Year', 
     ylab = 'Mean Absolute Error',
     lwd = 3, 
     type = 'l',
     col = 'blue', 
     ylim = c(0, 8000)
)
abline(h = validity_stats[1, 'MAE'], 
       lty = 'dashed', lwd = 2)
dev.off()


# Plot predictions against interquartile range of observed prices.
fig_file <- "Figures/validity/pred_vs_actual_IQR.png"
png(fig_file)

y_min <- min(c(validity_stats[, 'Q1_purchases'], 
               validity_stats[, 'Q1_pred_purchases']))
y_max <- max(validity_stats[, 'Q3_purchases'], 
             validity_stats[, 'Q3_pred_purchases'])
plot(validity_stats[, 'year'], 
     validity_stats[, 'avg_pred_purchases'], 
     main = 'Predictions vs Observed Quantiles for Model in Production',
     xlab = 'Year', 
     ylab = 'Purchases',
     lwd = 3, 
     type = 'l',
     col = 'blue', 
     ylim = c(0 - y_min, y_max)
)
abline(h = 0)
# Add the original average prediction.
abline(h = validity_stats[1, 'avg_pred_purchases'], 
       lty = 'dashed', lwd = 2)
# Add the upper and lower quartiles of predictions.
lines(validity_stats[, 'year'], 
      validity_stats[, 'Q1_pred_purchases'], 
      lwd = 3, 
      lty = 'dashed',
      col = 'blue', 
)
lines(validity_stats[, 'year'], 
      validity_stats[, 'Q3_pred_purchases'], 
      lwd = 3, 
      lty = 'dashed',
      col = 'blue', 
)
# Add the original average observed values.
lines(validity_stats[, 'year'], 
      validity_stats[, 'avg_purchases'], 
      lwd = 3, 
      col = 'red', 
)
# Add the upper and lower quartiles.
lines(validity_stats[, 'year'], 
      validity_stats[, 'Q1_purchases'], 
      lwd = 3, 
      lty = 'dashed',
      col = 'red', 
)
lines(validity_stats[, 'year'], 
      validity_stats[, 'Q3_purchases'], 
      lwd = 3, 
      lty = 'dashed',
      col = 'red', 
)
legend("bottom", 
       legend = c('Predicted', 'Observed'), 
       fill = c("blue", "red"), 
       cex = 0.75, 
       ncol = 1)
dev.off()


#-------------------------------------------------------------------------------
# Calculate lift charts.
#-------------------------------------------------------------------------------


# Convert to binned form in 10 quantiles.
n_bins <- 10
quantiles_2002 <- quantile(purchases_2002[, 'pred_purchases'], 
                           0:n_bins/n_bins)
# Note that the quantiles are based on the predictions in the training sample.

purchases_prod[, 'pred_purchases_bins'] <- cut(purchases_prod[, 'pred_purchases'], 
                                                 quantiles_2002, 
                                                 labels = seq(n_bins))


table(purchases_prod[, 'pred_purchases_bins'], useNA = 'ifany')
# Note that the bins do not have equal proportions 
# because the predictions may shift over time.
# Some lie beyond the outer quantiles.
sel_rows <- is.na(purchases_prod[, 'pred_purchases_bins'])
purchases_prod[sel_rows, 'pred_purchases']

# Assign extreme values to correct bins.
sel_rows <- purchases_prod[, 'pred_purchases'] <= quantiles_2002[1]
purchases_prod[sel_rows, 'pred_purchases_bins'] <- 1
sel_rows <- purchases_prod[, 'pred_purchases'] >= quantiles_2002[n_bins]
purchases_prod[sel_rows, 'pred_purchases_bins'] <- n_bins

table(purchases_prod[, 'pred_purchases_bins'], useNA = 'ifany')



# Calculate a lift chart for each year. 
# Plot average prices by prediction bins.

# Prime with year for training sample.
year_num <- 1
this_year <- year_list[year_num]
purchases_prod_sel <- purchases_prod[, 'year'] == this_year
# num_obs_year <- sum(purchases_prod_sel)
purchases_prod_year <- purchases_prod[purchases_prod_sel, ]
# Calculate average log_saleprice by prediction bin.
avg_purchases <- aggregate(x = purchases_prod_year[, 'purchases'], 
                                by = list(purchases_prod_year[, 'pred_purchases_bins']), 
                                FUN = "mean")
colnames(avg_purchases) <- c('pred_purchases_bins', 'avg_purchases')

# Plot lift chart for this year.
fig_file <- "Figures/validity/lift_chart_all.png"
png(fig_file)

plot(as.numeric(avg_purchases[, 'pred_purchases_bins']), 
     avg_purchases[, 'avg_purchases'], 
     main = 'Lift Charts for Model in Production',
     xlab = 'Prediction Bin', 
     ylab = 'Average Purchases',
     lwd = 1, 
     type = 'l',
     col = 'black', 
     ylim = c(0, 20000)
)



# Repeat for other years.
color_list <- rainbow(length(year_list) - 1)
for (year_num in 2:length(year_list)) {
  
  # Get sample for this year.
  this_year <- year_list[year_num]
  purchases_prod_sel <- purchases_prod[, 'year'] == this_year
  num_obs_year <- sum(purchases_prod_sel)
  purchases_prod_year <- purchases_prod[purchases_prod_sel, ]
  
  
  # Calculate average log_saleprice by prediction bin.
  avg_purchases <- aggregate(x = purchases_prod_year[, 'purchases'], 
                                  by = list(purchases_prod_year[, 'pred_purchases_bins']), 
                                  FUN = "mean")
  colnames(avg_purchases) <- c('pred_purchases_bins', 'avg_purchases')
  
  # Plot lift chart for this year.
  lines(as.numeric(avg_purchases[, 'pred_purchases_bins']), 
        avg_purchases[, 'avg_purchases'], 
        lwd = 3, 
        col = color_list[year_num]
  )
  
  
}
# Plot the original one more time on top.
year_num <- 1
this_year <- year_list[year_num]
purchases_prod_sel <- purchases_prod[, 'year'] == this_year
# num_obs_year <- sum(purchases_prod_sel)
purchases_prod_year <- purchases_prod[purchases_prod_sel, ]
# Calculate average log_saleprice by prediction bin.
avg_purchases <- aggregate(x = purchases_prod_year[, 'purchases'], 
                                by = list(purchases_prod_year[, 'pred_purchases_bins']), 
                                FUN = "mean")
colnames(avg_purchases) <- c('pred_purchases_bins', 'avg_purchases')
lines(as.numeric(avg_purchases[, 'pred_purchases_bins']), 
      avg_purchases[, 'avg_purchases'], 
      lwd = 4, 
      col = 'black', 
      lty = 'dotted'
)

legend("top", 
       legend = year_list, 
       fill = c("black", color_list), 
       cex = 0.75, 
       ncol = 5)
dev.off()


################################################################################
# Tests for stability of parameter estimates
################################################################################


#-------------------------------------------------------------------------------
# Plot estimates of parameters by year.
#-------------------------------------------------------------------------------

param_stability_vars <- c("(Intercept)", 
                          "income", "homeownership", "credit_limit", 
                          "fico", "fico_missing", 
                          "num_late", "past_def", "num_bankruptcy", 
                          "avg_income", "density")
param_stability_fmla <- 
  as.formula(paste("purchases ~ ", 
                   paste(param_stability_vars[2:length(param_stability_vars)], 
                         collapse = " + ")))

# Adjust for categorical homeownership.
param_stability_vars <- c("(Intercept)", 
                          "income", "homeownershipRent", "credit_limit", 
                          "fico", "fico_missing", 
                          "num_late", "past_def", "num_bankruptcy", 
                          "avg_income", "density")

# Create a data.frame for storing estimates.
param_stability_est <- data.frame(matrix(ncol = length(param_stability_vars) + 1, 
                                         nrow = length(year_list)))
colnames(param_stability_est) <- c("year", param_stability_vars)
param_stability_est[, 'year'] <- year_list

# Create a data.frame for storing estimates.
param_stability_CI_U <- param_stability_est
param_stability_CI_L <- param_stability_est

# Repeat estimation each year and store estimates and confidence intervals.
for (year_num in 1:length(year_list)) {
  
  # Get sample for this year.
  this_year <- year_list[year_num]
  purchases_prod_sel <- purchases_prod[, 'year'] == this_year
  num_obs_year <- sum(purchases_prod_sel)
  purchases_prod_year <- purchases_prod[purchases_prod_sel, ]
  
  # Estimate a full regression model for this year.
  lm_model_stability <- lm(data = purchases_prod_year,
                           formula = param_stability_fmla
  )
  
  # Record the parameter values.
  year_sel <- param_stability_est[, 'year'] == this_year
  lm_model_stability_summary <- summary(lm_model_stability)
  lm_model_stability_coef <- lm_model_stability_summary$coefficients
  
  # Estimates.
  param_stability_est[year_sel, rownames(lm_model_stability_coef)] <- 
    lm_model_stability_summary$coefficients[, 'Estimate']
  # Upper and lower confidence intervals.
  param_stability_CI_U[year_sel, rownames(lm_model_stability_coef)] <- 
    lm_model_stability_summary$coefficients[, 'Estimate'] + 
    1.96 * lm_model_stability_summary$coefficients[, 'Std. Error']
  param_stability_CI_L[year_sel, rownames(lm_model_stability_coef)] <- 
    lm_model_stability_summary$coefficients[, 'Estimate'] - 
    1.96 * lm_model_stability_summary$coefficients[, 'Std. Error']
  
  
}


# Plot for selected variable.
param_num <- 1
param_name <- param_stability_vars[param_num]
y_max <- max(param_stability_CI_U[, param_name])
y_min <- min(param_stability_CI_L[, param_name])

# Plot estimates for each sample.
plot(param_stability_est[, 'year'], 
     param_stability_est[, param_name], 
     main = paste('Estimates and Confidence Intervals for Variable:', 
                  param_name),
     xlab = 'Year', 
     ylab = 'Parameter Estimate',
     lwd = 3, 
     type = 'l',
     col = 'blue', 
     ylim = c(y_min, y_max)
)
# Plot estimates from training sample.
abline(h = param_stability_est[1, param_name], 
       lty = 'dashed', lwd = 2)
# Plot upper and lower bounds of confidence interval.
lines(param_stability_CI_U[, 'year'], 
      param_stability_CI_U[, param_name], 
      col = 'blue', 
      lty = 'dashed') 
lines(param_stability_CI_L[, 'year'], 
      param_stability_CI_L[, param_name], 
      col = 'blue', 
      lty = 'dashed') 



# Plot and save for all variables.
for (param_num in 1:length(param_stability_vars)) {
  
  param_name <- param_stability_vars[param_num]
  y_max <- max(param_stability_CI_U[, param_name], na.rm = TRUE)
  y_min <- min(param_stability_CI_L[, param_name], na.rm = TRUE)
  
  fig_file <- sprintf("Figures/param_stability/est_param_%s.png", param_name)
  png(fig_file)
  
  # Plot estimates for each sample.
  plot(param_stability_est[, 'year'], 
       param_stability_est[, param_name], 
       main = paste('Estimates for Variable:', 
                    param_name),
       xlab = 'Year', 
       ylab = 'Parameter Estimate',
       lwd = 3, 
       type = 'l',
       col = 'blue', 
       ylim = c(y_min, y_max)
  )
  # Plot estimates from training sample.
  abline(h = param_stability_est[1, param_name], 
         lty = 'dashed', lwd = 2)
  # Plot upper and lower bounds of confidence interval.
  lines(param_stability_CI_U[, 'year'], 
        param_stability_CI_U[, param_name], 
        col = 'blue', 
        lty = 'dashed') 
  lines(param_stability_CI_L[, 'year'], 
        param_stability_CI_L[, param_name], 
        col = 'blue', 
        lty = 'dashed') 
  dev.off()
  
}



#-------------------------------------------------------------------------------
# Estimate excess parameters by year.
#-------------------------------------------------------------------------------

param_stability_vars <- c("(Intercept)", 
                          "income", "homeownership", "credit_limit", 
                          "fico", "fico_missing", 
                          "num_late", "past_def", "num_bankruptcy", 
                          "avg_income", "density")

excess_stability_fmla <- 
  as.formula(paste("error_purchases ~ ", 
                   paste(param_stability_vars[2:length(param_stability_vars)], 
                         collapse = " + ")))

# Adjust for categorical homeownership.
param_stability_vars <- c("(Intercept)", 
                          "income", "homeownershipRent", "credit_limit", 
                          "fico", "fico_missing", 
                          "num_late", "past_def", "num_bankruptcy", 
                          "avg_income", "density")

# Create a data.frame for storing estimates.
excess_stability_est <- data.frame(matrix(ncol = length(param_stability_vars) + 1, 
                                          nrow = length(year_list)))
colnames(excess_stability_est) <- c("year", param_stability_vars)
excess_stability_est[, 'year'] <- year_list

# Create a data.frame for storing estimates.
excess_stability_CI_U <- excess_stability_est
excess_stability_CI_L <- excess_stability_est

# Repeat estimation each year and store estimates and confidence intervals.
for (year_num in 1:length(year_list)) {
  
  # Get sample for this year.
  this_year <- year_list[year_num]
  purchases_prod_sel <- purchases_prod[, 'year'] == this_year
  num_obs_year <- sum(purchases_prod_sel)
  purchases_prod_year <- purchases_prod[purchases_prod_sel, ]
  
  # Estimate a full regression model for this year.
  lm_model_stability <- lm(data = purchases_prod_year,
                           formula = excess_stability_fmla
  )
  
  # Record the parameter values.
  year_sel <- param_stability_est[, 'year'] == this_year
  lm_model_stability_summary <- summary(lm_model_stability)
  lm_model_stability_coef <- lm_model_stability_summary$coefficients
  
  # Estimates.
  excess_stability_est[year_sel, rownames(lm_model_stability_coef)] <- 
    lm_model_stability_summary$coefficients[, 'Estimate']
  # Upper and lower confidence intervals.
  excess_stability_CI_U[year_sel, rownames(lm_model_stability_coef)] <- 
    lm_model_stability_summary$coefficients[, 'Estimate'] + 
    1.96 * lm_model_stability_summary$coefficients[, 'Std. Error']
  excess_stability_CI_L[year_sel, rownames(lm_model_stability_coef)] <- 
    lm_model_stability_summary$coefficients[, 'Estimate'] - 
    1.96 * lm_model_stability_summary$coefficients[, 'Std. Error']
  
  
}



#-------------------------------------------------------------------------------
# Plot excess parameters by year.
#-------------------------------------------------------------------------------

# Plot and save for all variables.
for (param_num in 1:length(param_stability_vars)) {
  
  param_name <- param_stability_vars[param_num]
  y_max <- max(excess_stability_CI_U[, param_name], na.rm = TRUE)
  y_min <- min(excess_stability_CI_L[, param_name], na.rm = TRUE)
  
  fig_file <- sprintf("Figures/excess_stability/est_excess_%s.png", param_name)
  png(fig_file)
  
  # Plot estimates for each sample.
  plot(excess_stability_est[, 'year'], 
       excess_stability_est[, param_name], 
       main = paste('Excess Predictive Value for Variable:', 
                    param_name),
       xlab = 'Year', 
       ylab = 'Excess Predictive Value',
       lwd = 3, 
       type = 'l',
       col = 'blue', 
       ylim = c(y_min, y_max)
  )
  # Plot estimates from training sample.
  abline(h = 0, 
         lty = 'dashed', lwd = 2)
  # Plot upper and lower bounds of confidence interval.
  lines(excess_stability_CI_U[, 'year'], 
        excess_stability_CI_U[, param_name], 
        col = 'blue', 
        lty = 'dashed') 
  lines(excess_stability_CI_L[, 'year'], 
        excess_stability_CI_L[, param_name], 
        col = 'blue', 
        lty = 'dashed') 
  dev.off()
  
}



################################################################################
# Tests for stability of distributions of explanatory variables
################################################################################


################################################################################
# Take inventory of all varialbes
################################################################################

summary(purchases_prod)

# These variables are continuous.
cts_var_names <- c('fico', 'credit_limit', 
                   'income', 
                   'avg_income', 'density')
# Note that changes in squared_horsepower are captured in horsepower.

# Convert these into categorical variables to create histograms.
n_bins <- 6


for (var_name in cts_var_names) {
  
  quantiles_2002 <- quantile(purchases_2002[, var_name], 
                             0:n_bins/n_bins)
  
  var_name_bins <- paste(c(var_name, '_cat'), collapse = '')
  purchases_prod[, var_name_bins] <- cut(purchases_prod[, var_name], 
                                       quantiles_2002, 
                                       labels = seq(n_bins))
  # Assign extreme values to correct bins.
  sel_rows <- purchases_prod[, var_name] <= quantiles_2002[1]
  purchases_prod[sel_rows, var_name_bins] <- 1
  sel_rows <- purchases_prod[, var_name] >= quantiles_2002[n_bins]
  purchases_prod[sel_rows, var_name_bins] <- n_bins
  
  
  
}

summary(purchases_prod[, cts_var_names])
summary(purchases_prod[, sprintf('%s_cat', cts_var_names)])


# Convert all categorical variables into factors,
# leaving room for the possibility of missing values.

cat_var_names <- c("homeownership", 
                   "fico_missing", 
                   "num_late", "past_def", "num_bankruptcy",  
                   # Note that this also includes the binned numerical variables.
                   'fico_cat', 'credit_limit_cat', 
                   'income_cat', 
                   'avg_income_cat', 'density_cat')


for (var_name in cat_var_names) {
  
  level_names <- unique(c(NA, purchases_prod[, var_name]))
  
  
  var_name_bins <- paste(c(var_name, '_bins'), collapse = '')
  purchases_prod[, var_name_bins] <- factor(purchases_prod[, var_name], 
                                          levels = level_names, 
                                          exclude = NULL)
  
}


summary(purchases_prod[, cat_var_names])
summary(purchases_prod[, sprintf('%s_bins', cat_var_names)])


################################################################################
# Calculate Population Stability Indices
################################################################################


cat_var_names <- c("homeownership", 
                   "fico_missing", 
                   "num_late", "past_def", "num_bankruptcy",  
                   # Note that this also includes the binned numerical variables.
                   'fico_cat', 'credit_limit_cat', 
                   'income_cat', 
                   'avg_income_cat', 'density_cat')


year_list <- seq(min(purchases_prod[, 'year']), 
                 max(purchases_prod[, 'year']))

PSI_Chi_Square <- data.frame(matrix(nrow = length(year_list), 
                                    ncol = length(cat_var_names) + 1))
colnames(PSI_Chi_Square) <- c('year', cat_var_names)

PSI_Chi_Square[, 'year'] <- year_list

PSI_KL_Divergence <- PSI_Chi_Square

# Set a minimum value in each bin, in case zero are observed.
min_prop <- 10^(-6)


# Copy columns from training sample in year 2000.
purchases_2002 <- purchases_prod[purchases_prod[, 'year'] == 2002, ]
# Compare the probabilities in this sample with all future years.


# Loop on list of categorical variables.
for (var_name in cat_var_names) {
  
  bin_var_name <- sprintf('%s_bins', var_name)
  level_names <- levels(purchases_prod[, bin_var_name])
  num_bins <- length(level_names)
  
  # Create a data.frame to store proportions in same columns.
  prop_df <- data.frame(matrix(min_prop, nrow = 2, ncol = length(level_names)))
  rownames(prop_df) <- c('bench', 'this_year')
  # colnames(prop_df) <- c('NA', level_names(2:length(level_names)))
  colnames(prop_df) <- paste(level_names)
  
  
  # Calculate the probabilities of observations in each bin, 
  # in the estimation sample.
  bench_proportions <- 
    table(purchases_2002[, bin_var_name], useNA = 'ifany')/nrow(purchases_2002)
  # Overwrite NA with "NA" character string.
  names(bench_proportions) <- paste(names(bench_proportions))
  
  prop_df['bench', names(bench_proportions)] <- bench_proportions
  prop_df['bench', prop_df['bench', ] == 0] <- min_prop
  
  
  for (year_num in 1:length(year_list)) {
    
    # Get sample for this year.
    this_year <- year_list[year_num]
    purchases_prod_sel <- purchases_prod[, 'year'] == this_year
    num_obs_year <- sum(purchases_prod_sel)
    purchases_prod_year <- purchases_prod[purchases_prod_sel, ]
    
    # Calculate the probabilities of observations in each bin, 
    # in the estimation sample.
    this_year_proportions <- 
      table(purchases_prod_year[, bin_var_name], useNA = 'ifany')/num_obs_year
    names(this_year_proportions) <- paste(names(this_year_proportions))
    
    # Overwrite this_year with zero before recording next year.
    prop_df['this_year', ] <- min_prop
    prop_df['this_year', names(this_year_proportions)] <- this_year_proportions
    # Overwrite zeros with minimum proportion.
    prop_df['this_year', prop_df['this_year', ] == 0] <- min_prop
    
    
    
    # Calculate pearson's Chi-Squared statistic.
    # chi_squared <- sum((this_year_proportions - bench_proportions)^2 /
    #                      bench_proportions)
    chi_squared <- sum((prop_df['this_year', ] - prop_df['bench', ])^2 /
                         prop_df['bench', ]) * num_obs_year
    PSI_Chi_Square[year_num, var_name] <- chi_squared
    
    # Calculate the Kullback-Leibler Divergence statistic.
    # KLD_stat <- sum(bench_proportions * 
    #                   (log(this_year_proportions) - log(bench_proportions)))
    # PSI_KL_Divergence[year_num, var_name] <- KLD_stat
    KLD_stat <- 
      - sum(prop_df['bench', ] * 
              (log(prop_df['this_year', ]) - log(prop_df['bench', ]))) * num_obs_year
    PSI_KL_Divergence[year_num, var_name] <- KLD_stat
    
  }
  
}

PSI_Chi_Square

PSI_KL_Divergence



################################################################################
# Plot Population Stability Indices
################################################################################


# Loop on list of categorical variables.
for (var_name in cat_var_names) {
  
  bin_var_name <- sprintf('%s_bins', var_name)
  level_names <- levels(purchases_prod[, bin_var_name])
  num_bins <- length(level_names)
  
  # Plot Pearson's Chi-Squared
  fig_file <- paste(c('Figures/input_stability/', var_name, '_ChiSq.png'), collapse = '')
  # fig_file <- paste(c('Figures/', var_name, '_ChiSq.png'), collapse = '')
  png(fig_file)
  
  plot(PSI_Chi_Square[, 'year'], 
       PSI_Chi_Square[, var_name], 
       main = c(paste('Population Stability Index for', var_name), 
                "(PSI based on Pearson's Chi-Squared)"),
       xlab = 'Year', 
       ylab = 'Population Stability Index',
       lwd = 3, 
       type = 'l',
       col = 'blue', 
       ylim = c(0, max(max(PSI_Chi_Square[, var_name]), num_bins))
  )
  abline(h = PSI_Chi_Square[1, 'var_name'], 
         lty = 'dashed', lwd = 2)
  dev.off()
  
  
  # Calculate the Kullback-Leibler Divergence statistic.
  fig_file <- paste(c('Figures/input_stability/', var_name, '_KLD.png'), collapse = '')
  # fig_file <- paste(c('Figures/', var_name, '_KLD.png'), collapse = '')
  png(fig_file)
  
  plot(PSI_KL_Divergence[, 'year'], 
       PSI_KL_Divergence[, var_name], 
       main = c(paste('Population Stability Index for', var_name), 
                "(PSI based on Kullback-Leibler Divergence)"),
       xlab = 'Year', 
       ylab = 'Population Stability Index',
       lwd = 3, 
       type = 'l',
       col = 'blue', 
       ylim = c(0, max(max(PSI_KL_Divergence[, var_name]), num_bins))
  )
  abline(h = PSI_KL_Divergence[1, 'var_name'], 
         lty = 'dashed', lwd = 2)
  dev.off()
  
  
  
}





################################################################################
# Plot the changes in proportions
################################################################################

library(tidyverse)



# Loop on list of categorical variables.
for (var_name in cat_var_names) {
  
  bin_var_name <- sprintf('%s_bins', var_name)
  level_names <- levels(purchases_prod[, bin_var_name])
  num_bins <- length(level_names)
  
  # Select a subset of data for plotting figures.
  fig_data <- purchases_prod[, c('year', bin_var_name)]
  colnames(fig_data) <- c('year', "binned_variable")
  
  
  
  # Plot a stacked bar graph of the counts of observations over time.
  fig_file <- paste(c('Figures/input_stability/', var_name, '_bar.png'), collapse = '')
  # fig_file <- paste(c('Figures/', var_name, '_bar.png'), collapse = '')
  png(fig_file)
  
  distn_plot <- fig_data %>%
    group_by(year, binned_variable) %>%
    summarize(
      counts = n()
    ) %>%
    ggplot(aes(x = year, 
               y = counts, 
               fill = binned_variable)) +
    geom_bar(stat = "identity") +
    # theme(legend.position = "none") +
    ggtitle(paste("Frequency of", bin_var_name, "Over Time"))
  
  print(distn_plot)
  dev.off()
  
  
  
  # Plot a stacked bar graph of the proportions over time.
  fig_file <- paste(c('Figures/input_stability/', var_name, '_prop_bar.png'), collapse = '')
  # fig_file <- paste(c('Figures/', var_name, '_prop_bar.png'), collapse = '')
  png(fig_file)
  
  fig_data_years <- fig_data %>%
    group_by(year) %>%
    summarize(
      year_totals = n()
    )
  
  distn_plot <- fig_data %>%
    group_by(year, binned_variable) %>%
    summarize(
      counts = n()
    ) %>%
    left_join(fig_data_years) %>% 
    mutate(proportions = counts/year_totals) %>%
    ggplot(aes(x = year, 
               y = proportions, 
               fill = binned_variable)) +
    geom_bar(stat = "identity") +
    # theme(legend.position = "none") +
    ggtitle(paste("Distribution of", bin_var_name, "Over Time"))
  
  print(distn_plot)
  dev.off()
  
}



################################################################################
# End
################################################################################

