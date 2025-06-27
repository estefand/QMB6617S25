
##################################################
#
# QMB 6617.0081 Business Analytics for Managers
#
# Model Monitoring: Validity
#
# Lealand Morin, Ph.D.
# Adjunct Professor
# College of Business
# University of Central Florida
#
# June 20, 2025
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

loans_prod <- read.csv('loans_prod.csv')


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


#-------------------------------------------------------------------------------
# Plot predicted_probs and MAE by year.
# Include other stats to compare performance.
#-------------------------------------------------------------------------------

year_list <- seq(min(loans_prod[, 'year']), 
                 max(loans_prod[, 'year']))


validity_stats <- data.frame(year = year_list, 
                             prop_defaults = numeric(length(year_list)), 
                             predicted_probs = numeric(length(year_list)), 
                             AUROC = numeric(length(year_list)), 
                             MAE = numeric(length(year_list)))

for (year_num in 1:length(year_list)) {
  
  # Get sample for this year.
  this_year <- year_list[year_num]
  loans_prod_sel <- loans_prod[, 'year'] == this_year
  num_obs_year <- sum(loans_prod_sel)
  loans_prod_year <- loans_prod[loans_prod_sel, ]
  
  # Calculate proportion of defaults.
  validity_stats[year_num, 'prop_defaults'] <- 
    sum(loans_prod_year[, 'default']) / num_obs_year
  
  # Calculate predicted probabilities.
  validity_stats[year_num, 'predicted_probs'] <- 
    sum(loans_prod_year[, 'default_prob_logit_2']) / num_obs_year
  
  # Calculate AUROC.
  suppressWarnings(
    roc_object <- 
      roc(response = loans_prod_year[, 'default'],
          predictor = loans_prod_year[, 'default_prob_logit_2'])
  )
  validity_stats[year_num, 'AUROC'] <- roc_object$auc
  
  # Calculate MAE.
  loans_prod_year[, 'pred_error'] <- 
    loans_prod_year[, 'default'] - loans_prod_year[, 'default_prob_logit_2']
  validity_stats[year_num, 'MAE'] <- mean(abs(loans_prod_year[, 'pred_error']))
}

validity_stats


# Calculate proportion of defaults.
fig_file <- "Figures/prop_defaults.png"
png(fig_file)

plot(validity_stats[, 'year'], 
     validity_stats[, 'prop_defaults'], 
     main = 'Aggregate Proportion of Defaults for Model in Production',
     xlab = 'Year', 
     ylab = 'Aggregate Proportion of Defaults',
     lwd = 3, 
     type = 'l',
     col = 'blue', 
     ylim = c(0, 1)
)
abline(h = validity_stats[1, 'prop_defaults'], 
       lty = 'dashed', lwd = 2)
dev.off()



# Calculate predicted probabilities.
fig_file <- "Figures/predicted_probs.png"
png(fig_file)

plot(validity_stats[, 'year'], 
     validity_stats[, 'predicted_probs'], 
     main = 'Predicted Proportion of Defaults for Model in Production',
     xlab = 'Year', 
     ylab = 'Predicted Proportion of Defaults',
     lwd = 3, 
     type = 'l',
     col = 'blue', 
     ylim = c(0, 1)
)
abline(h = validity_stats[1, 'predicted_probs'], 
       lty = 'dashed', lwd = 2)
dev.off()


# Plot Adjusted R_squared
fig_file <- "Figures/AUROC.png"
png(fig_file)

plot(validity_stats[, 'year'], 
     validity_stats[, 'AUROC'], 
     main = 'Area Under ROC Curve for Model in Production',
     xlab = 'Year', 
     ylab = 'AUROC',
     lwd = 3, 
     type = 'l',
     col = 'blue', 
     ylim = c(0, 1)
)
abline(h = validity_stats[1, 'AUROC'], 
       lty = 'dashed', lwd = 2)
dev.off()


# Plot MAE.
fig_file <- "Figures/MAE.png"
png(fig_file)

plot(validity_stats[, 'year'], 
     validity_stats[, 'MAE'], 
     main = 'Mean Absolute Error of Model in Production',
     xlab = 'Year', 
     ylab = 'Mean Absolute Error',
     lwd = 3, 
     type = 'l',
     col = 'blue', 
     ylim = c(0, 0.75)
)
abline(h = validity_stats[1, 'MAE'], 
       lty = 'dashed', lwd = 2)
dev.off()



#-------------------------------------------------------------------------------
# Calculate lift charts.
#-------------------------------------------------------------------------------


# Convert to binned form in 10 quantiles.
n_bins <- 10
quantiles_2005 <- quantile(loans_2005[, 'default_prob_logit_2'], 
                           0:n_bins/n_bins)
# Note that the quantiles are based on the predictions in the training sample.

loans_prod[, 'default_prob_logit_2_bins'] <- cut(loans_prod[, 'default_prob_logit_2'], 
                                                 quantiles_2005, 
                                                 labels = seq(n_bins))


table(loans_prod[, 'default_prob_logit_2_bins'], useNA = 'ifany')
# Note that the bins do not have equal proportions 
# because the predictions may shift over time.
# Some lie beyond the outer quantiles.
sel_rows <- is.na(loans_prod[, 'default_prob_logit_2_bins'])
table(loans_prod[sel_rows, 'default_prob_logit_2'], useNA = 'ifany')

# Assign extreme values to correct bins.
sel_rows <- loans_prod[, 'default_prob_logit_2'] <= quantiles_2005[1]
loans_prod[sel_rows, 'default_prob_logit_2_bins'] <- 1
sel_rows <- loans_prod[, 'default_prob_logit_2'] >= quantiles_2005[n_bins]
loans_prod[sel_rows, 'default_prob_logit_2_bins'] <- n_bins

table(loans_prod[, 'default_prob_logit_2_bins'], useNA = 'ifany')



#-------------------------------------------------------------------------------
# Calculate a lift chart for each year. 
# Plot average prices by prediction bins.
#-------------------------------------------------------------------------------


year_list <- seq(min(loans_prod[, 'year']), 
                 max(loans_prod[, 'year']))


fig_file <- "Figures/lift_chart_all.png"
png(fig_file)



# Prime with year for training sample.
year_num <- 1
this_year <- year_list[year_num]
loans_prod_sel <- loans_prod[, 'year'] == this_year
# num_obs_year <- sum(loans_prod_sel)
loans_prod_year <- loans_prod[loans_prod_sel, ]
# Calculate average default by prediction bin.
avg_default <- aggregate(x = loans_prod_year[, 'default'], 
                         by = list(loans_prod_year[, 'default_prob_logit_2_bins']), 
                         FUN = "mean")
colnames(avg_default) <- c('default_prob_logit_2_bins', 'avg_default')


# Plot lift chart for this year first.
plot(as.numeric(avg_default[, 'default_prob_logit_2_bins']), 
     avg_default[, 'avg_default'], 
     main = 'Lift Charts for Model in Production',
     xlab = 'Prediction Bin', 
     ylab = 'Average Default Rate',
     lwd = 1, 
     type = 'l',
     col = 'black', 
     ylim = c(0, 1)
)



# Repeat for other years.
color_list <- rainbow(length(year_list) - 1)
for (year_num in 2:length(year_list)) {
  
  # Get sample for this year.
  this_year <- year_list[year_num]
  loans_prod_sel <- loans_prod[, 'year'] == this_year
  num_obs_year <- sum(loans_prod_sel)
  loans_prod_year <- loans_prod[loans_prod_sel, ]
  
  
  # Calculate average default by prediction bin.
  avg_default <- aggregate(x = loans_prod_year[, 'default'], 
                           by = list(loans_prod_year[, 'default_prob_logit_2_bins']), 
                           FUN = "mean")
  colnames(avg_default) <- c('default_prob_logit_2_bins', 'avg_default')
  
  # Plot lift chart for this year.
  lines(as.numeric(avg_default[, 'default_prob_logit_2_bins']), 
        avg_default[, 'avg_default'], 
        lwd = 3, 
        col = color_list[year_num]
  )
  
  
}
# Plot the original one more time on top.
year_num <- 1
this_year <- year_list[year_num]
loans_prod_sel <- loans_prod[, 'year'] == this_year
# num_obs_year <- sum(loans_prod_sel)
loans_prod_year <- loans_prod[loans_prod_sel, ]
# Calculate average default by prediction bin.
avg_default <- aggregate(x = loans_prod_year[, 'default'], 
                         by = list(loans_prod_year[, 'default_prob_logit_2_bins']), 
                         FUN = "mean")
colnames(avg_default) <- c('default_prob_logit_2_bins', 'avg_default')
lines(as.numeric(avg_default[, 'default_prob_logit_2_bins']), 
      avg_default[, 'avg_default'], 
      lwd = 4, 
      col = 'black', 
      lty = 'dotted'
)

legend("top", # "bottom", 
       legend = year_list, 
       fill = c("black", color_list), 
       cex = 0.75, 
       ncol = 5)
dev.off()



#-------------------------------------------------------------------------------
# Calculate a lift chart for selected years. 
# Plot average prices by prediction bins.
#-------------------------------------------------------------------------------


# Choose a few years to highlight a period of unusual performance.
# year_list_sel <- c(2005, 2006:2009) # Financial crisis
year_list_sel <- c(2005, 2019:2021) # Covid-19

# As with the version above with all years, the first year is assumed 
# to be the benchmark sample that was used for estimation.

# Choose an appropriate file name (a descriptive name).
# fig_file <- "Figures/lift_chart_2006_2009.png"
fig_file <- "Figures/lift_chart_2019_2021.png"
png(fig_file)



# Prime with year for training sample.
year_num <- 1
this_year <- year_list_sel[year_num]
loans_prod_sel <- loans_prod[, 'year'] == this_year
# num_obs_year <- sum(loans_prod_sel)
loans_prod_year <- loans_prod[loans_prod_sel, ]
# Calculate average default by prediction bin.
avg_default <- aggregate(x = loans_prod_year[, 'default'], 
                         by = list(loans_prod_year[, 'default_prob_logit_2_bins']), 
                         FUN = "mean")
colnames(avg_default) <- c('default_prob_logit_2_bins', 'avg_default')


# Plot lift chart for this year first.
plot(as.numeric(avg_default[, 'default_prob_logit_2_bins']), 
     avg_default[, 'avg_default'], 
     main = 'Lift Charts for Model in Production',
     xlab = 'Prediction Bin', 
     ylab = 'Average Default Rate',
     lwd = 1, 
     type = 'l',
     col = 'black', 
     ylim = c(0, 1)
)



# Repeat for other years.
color_list <- rainbow(length(year_list_sel) - 1)
for (year_num in 2:length(year_list_sel)) {
  
  # Get sample for this year.
  this_year <- year_list_sel[year_num]
  loans_prod_sel <- loans_prod[, 'year'] == this_year
  num_obs_year <- sum(loans_prod_sel)
  loans_prod_year <- loans_prod[loans_prod_sel, ]
  
  
  # Calculate average default by prediction bin.
  avg_default <- aggregate(x = loans_prod_year[, 'default'], 
                           by = list(loans_prod_year[, 'default_prob_logit_2_bins']), 
                           FUN = "mean")
  colnames(avg_default) <- c('default_prob_logit_2_bins', 'avg_default')
  
  # Plot lift chart for this year.
  lines(as.numeric(avg_default[, 'default_prob_logit_2_bins']), 
        avg_default[, 'avg_default'], 
        lwd = 3, 
        col = color_list[year_num]
  )
  
  
}
# Plot the original one more time on top.
year_num <- 1
this_year <- year_list_sel[year_num]
loans_prod_sel <- loans_prod[, 'year'] == this_year
# num_obs_year <- sum(loans_prod_sel)
loans_prod_year <- loans_prod[loans_prod_sel, ]
# Calculate average default by prediction bin.
avg_default <- aggregate(x = loans_prod_year[, 'default'], 
                         by = list(loans_prod_year[, 'default_prob_logit_2_bins']), 
                         FUN = "mean")
colnames(avg_default) <- c('default_prob_logit_2_bins', 'avg_default')
lines(as.numeric(avg_default[, 'default_prob_logit_2_bins']), 
      avg_default[, 'avg_default'], 
      lwd = 4, 
      col = 'black', 
      lty = 'dotted'
)

legend("top", # "bottom", 
       legend = year_list_sel, 
       fill = c("black", color_list), 
       cex = 0.75, 
       ncol = 5)
dev.off()


################################################################################
# End
################################################################################




