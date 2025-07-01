
##################################################
#
# QMB 6617.0081 Business Analytics for Managers
#
# Model Monitoring: Model Stability
# Excess Predictive Value
#
# Lealand Morin, Ph.D.
# Adjunct Professor
# College of Business
# University of Central Florida
#
# June 28, 2025
#
##################################################
#
# tractor_monitoring_validity gives examples of frameworks
#   for monitoring the performance of a model after the model 
#   is built and used for decision making later. 
#   The example is based on a linear regression model built
#   on a dataset of prices from the sale of used tractors.
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


# setwd("~/GitHub/QMB6617S25_LM/module_08_2_input_stability")


# Now, RStudio should know where your files are.



# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)


# The csv file used below must be in the working directory.
# If you an error message, make sure that the file is
# located in your working directory.
# Also make sure that the name has not changed.


##################################################
# Loading the Data
##################################################

# First, read in the production data.
tractor_prod <- read.csv('../../module_07_2_model_validity/tractors/tractor_prod.csv')
# Uses the same dataset as last week.

summary(tractor_prod)

# Calculate required variables.
tractor_prod[, 'log_saleprice'] <- log(tractor_prod[, 'saleprice'])
tractor_prod[, 'squared_horsepower'] <- tractor_prod[, 'horsepower']^2
tractor_prod[, 'cab_orig'] <- tractor_prod[, 'cab']
tractor_prod[is.na(tractor_prod[, 'cab_orig']), 'cab'] <- 0


summary(tractor_prod)

#-------------------------------------------------------------------------------
# Estimate model and calculate predictions.
#-------------------------------------------------------------------------------

# We estimated many models and this was the model we settled on.
tractor_2000 <- tractor_prod[tractor_prod[, 'year'] == 2000, ]

# Estimate a regression model.
lm_model_6 <- lm(data = tractor_2000,
                 formula = log_saleprice ~ horsepower + squared_horsepower +
                   age + enghours +
                   cab +
                   # diesel + 
                   fwd + johndeere)
num_vars <- 7

# Output the results to screen.
summary(lm_model_6)

# Calculate predictions from this model over all future samples.
tractor_prod[, 'pred_log_saleprice'] <- predict(lm_model_6, 
                                                newdata = tractor_prod)
# Calculate saleprice by inverting log transformation with exp().
tractor_prod[, 'pred_saleprice'] <- exp(tractor_prod[, 'pred_log_saleprice'])


# Calculate prediction errors.
tractor_prod[, 'error_log_saleprice'] <- tractor_prod[, 'pred_log_saleprice'] - 
  tractor_prod[, 'log_saleprice']
tractor_prod[, 'error_saleprice'] <- tractor_prod[, 'pred_saleprice'] - 
  tractor_prod[, 'saleprice']

summary(tractor_prod)



################################################################################
# Model Stability: Excess Predictive Value
################################################################################

year_list <- seq(min(tractor_prod[, 'year']), 
                 max(tractor_prod[, 'year']))

#-------------------------------------------------------------------------------
# Estimate excess parameters by year.
#-------------------------------------------------------------------------------

param_stability_vars <- c("(Intercept)", 
                          "horsepower", "squared_horsepower", 
                          "age", "enghours", 
                          "johndeere", "fwd", 
                          "cab", 
                          "diesel", 
                          "manual", 
                          "spring", "summer", "winter")
excess_stability_fmla <- 
  as.formula(paste("error_log_saleprice ~ ", 
                   paste(param_stability_vars[2:length(param_stability_vars)], 
                         collapse = " + ")))

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
  tractor_prod_sel <- tractor_prod[, 'year'] == this_year
  num_obs_year <- sum(tractor_prod_sel)
  tractor_prod_year <- tractor_prod[tractor_prod_sel, ]
  
  # Estimate a full regression model for this year.
  lm_model_stability <- lm(data = tractor_prod_year,
                           formula = excess_stability_fmla
  )
  
  # Record the parameter values.
  year_sel <- excess_stability_est[, 'year'] == this_year
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
  
  # fig_file <- sprintf("Figures/excess_stability/est_excess_%s.png", param_name)
  fig_file <- sprintf("Figures/est_excess_%s.png", param_name)
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
# End
################################################################################

