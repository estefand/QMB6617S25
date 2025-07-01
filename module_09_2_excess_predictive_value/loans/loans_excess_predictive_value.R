
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
# loans_monitoring_validity gives examples of frameworks
#   the performance of a model after the model is built
#   and used for decision making later. 
#   The example is based on a logistic regression model built
#   on a dataset of loans and default status.
#
# The variables in the dataset loans_prod.csv are as follows:
#
#   default: 1 if borrower defaulted on a loan
#   bmaxrate: Maximum rate of interest on any part of the loan
#   amount: the amount funded on the loan
#   close: borrower takes the option of closing the listing
#     before it is fully funded
#   bankcardutil: the utilization rate on the borrower's
#     other credit card accounts (the percentage of the balance
#     divided by the credit limit).
#   rating: the borrower's credit rating category
#     which is divided into the following categories
#   AA: borrower's FICO score greater than 760
#   A: borrower's FICO score between 720 and 759
#   B: borrower's FICO score between 680 and 719
#   C: borrower's FICO score between 640 and 679
#   D: borrower's FICO score between 600 and 639
#   Missing: borrower's FICO score is unobserved
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


# setwd("~/GitHub/QMB6617S25_LM/module_07_2_model_validity")


# Now, RStudio should know where your files are.



# Load library for computing the AUROC.
# You will have to install this package the first time.
# Press the "Install" button or run the following (without the #):
# install.packages('pROC')
library(pROC)


# The csv file used below must be in the working directory.
# If you an error message, make sure that the file is
# located in your working directory.
# Also make sure that the name has not changed.

##################################################
# Loading the Data
##################################################

loans_prod <- read.csv('../../module_07_2_model_validity/loans/loans_prod.csv')


summary(loans_prod)

#------------------------------------------------------------
# Categorical (factor) Variables
#------------------------------------------------------------

# Use table() to tabulate categorical variables (AKA factor variables).
table(loans_prod[, 'rating'], useNA = 'ifany')

# Set the order of the factor labels.
loans_prod[, 'rating'] <- factor(loans_prod[, 'rating'],
                                 levels = c('AA', 'A', 'B', 'C', 'D', 'Missing'))

table(loans_prod[, 'rating'], useNA = 'ifany')


#------------------------------------------------------------
# Select original sample to build a model.
#------------------------------------------------------------

loans_2005 <- loans_prod[loans_prod[, 'year'] == 2005, ]



#-------------------------------------------------------------------------------
# Estimate model and calculate predictions.
#-------------------------------------------------------------------------------


##################################################
# Estimating a Logistic Regression Model
# Model 3: Logistic model for default probability
# Start with a full model that includes all variables.
##################################################

# Estimate a logistic regression model.
logit_model_1 <- glm(data = loans_2005,
                     formula = default ~ bmaxrate + amount +
                       close + bankcardutil + rating,
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)


# Calculate the predictions of this model.
loans_2005[, 'default_prob_logit_1'] <- predict(logit_model_1, type = 'response')

summary(loans_2005[, 'default_prob_logit_1'])
# Do these predictions seem plausible?
# Are there any above 1 or below zero?

# Measure model performance with AUROC.
roc(response = loans_2005[, 'default'],
    predictor = loans_2005[, 'default_prob_logit_1'])



##################################################
# Estimating a Logistic Regression Model
# Model 4: Logistic model for default probability
# Trim down the model by omitting variables.
##################################################

# Estimate a logistic regression model.
logit_model_2 <- glm(data = loans_2005,
                     formula = default ~
                       # Remove some variables from here:
                       rating +
                       bmaxrate +
                       # amount +
                       # bankcardutil +
                       close,
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_2)

# Calculate the predictions of this model.
loans_2005[, 'default_prob_logit_2'] <- predict(logit_model_2, type = 'response')

summary(loans_2005[, 'default_prob_logit_2'])



# Translate into link function.
loans_2005[, 'link'] <- log(loans_2005[, 'default_prob_logit_2'] / 
                              (1 - loans_2005[, 'default_prob_logit_2']))


# Measure model performance with AUROC.
roc(response = loans_2005[, 'default'],
    predictor = loans_2005[, 'default_prob_logit_2'])


# Now calculate the predictions of this model for the entire history.
loans_prod[, 'default_prob_logit_2'] <- predict(logit_model_2, type = 'response', 
                                                newdata = loans_prod)

# Calculate the error of these predictions to test later.
loans_2005[, 'error_default'] <- 
  loans_2005[, 'default_prob_logit_2'] - loans_2005[, 'default']
loans_prod[, 'error_default'] <- 
  loans_prod[, 'default_prob_logit_2'] - loans_prod[, 'default']


################################################################################
# Model Stability: Excess Predictive Value
################################################################################

year_list <- seq(min(loans_prod[, 'year']), 
                 max(loans_prod[, 'year']))

#-------------------------------------------------------------------------------
# Estimate excess parameters by year.
#-------------------------------------------------------------------------------

param_stability_vars <- c("(Intercept)", 
                          "bmaxrate", "amount", "close", 
                          "bankcardutil", "rating")

# Note that this will be a linear regression because we are testing against
# the prediction error, which is a numeric value.
excess_stability_fmla <- 
  as.formula(paste("error_default ~ ", 
                   paste(param_stability_vars[2:length(param_stability_vars)], 
                         collapse = " + ")))

#--------------------------------------------------------------------------------
# As above, since this regression has categorical variables, 
# estimate it first to get a list of the coefficients.
#--------------------------------------------------------------------------------

# Estimate a linear regression model for this year.
lm_model_stability <- lm(data = loans_2005,
                         formula = excess_stability_fmla)

summary(lm_model_stability)

# Store the regression output.
lm_model_stability_summary <- summary(lm_model_stability)
lm_model_stability_coef <- lm_model_stability_summary$coefficients


# Restate the list of coefficients in full model.
param_stability_vars <- rownames(lm_model_stability_coef)

#--------------------------------------------------------------------------------


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
  loans_prod_sel <- loans_prod[, 'year'] == this_year
  num_obs_year <- sum(loans_prod_sel)
  loans_prod_year <- loans_prod[loans_prod_sel, ]
  
  # Estimate a full regression model for this year.
  lm_model_stability <- lm(data = loans_prod_year,
                           formula = excess_stability_fmla)
  
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
  # Limit scale of axes, since some standard errors are large.
  # y_max <- max(param_stability_CI_U[, param_name], na.rm = TRUE)
  y_max <- max(pmin(excess_stability_CI_U[, param_name], 
                    excess_stability_est[, param_name] + 
                      4*excess_stability_est[, param_name]), na.rm = TRUE)
  # y_min <- min(param_stability_CI_L[, param_name], na.rm = TRUE)
  y_min <- min(pmax(excess_stability_CI_L[, param_name], 
                    excess_stability_est[, param_name] - 
                      4*excess_stability_est[, param_name]), na.rm = TRUE)
  
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


