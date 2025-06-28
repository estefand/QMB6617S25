
##################################################
#
# QMB 6617.0081 Business Analytics for Managers
#
# Model Monitoring: Input Stability
#
# Lealand Morin, Ph.D.
# Adjunct Professor
# College of Business
# University of Central Florida
#
# June 27, 2025
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
# Take inventory of all varialbes
################################################################################

summary(loans_prod)

# These variables are continuous.
cts_var_names <- c("bmaxrate", "amount", 
                   "bankcardutil")
# Note that changes in squared_horsepower are captured in horsepower.

# Convert these into categorical variables to create histograms.
n_bins <- 6


for (var_name in cts_var_names) {
  
  quantiles_2005 <- quantile(loans_2005[, var_name], 
                             0:n_bins/n_bins)
  
  var_name_bins <- paste(c(var_name, '_cat'), collapse = '')
  loans_prod[, var_name_bins] <- cut(loans_prod[, var_name], 
                                       quantiles_2005, 
                                       labels = seq(n_bins))
  # Assign extreme values to correct bins.
  sel_rows <- loans_prod[, var_name] <= quantiles_2005[1]
  loans_prod[sel_rows, var_name_bins] <- 1
  sel_rows <- loans_prod[, var_name] >= quantiles_2005[n_bins]
  loans_prod[sel_rows, var_name_bins] <- n_bins
  
  
  
}

summary(loans_prod[, cts_var_names])
summary(loans_prod[, sprintf('%s_cat', cts_var_names)])


# Convert all categorical variables into factors,
# leaving room for the possibility of missing values.

cat_var_names <- c("close", 
                   "rating",  
                   # Note that this also includes the binned numerical variables.
                   "bmaxrate_cat", "amount_cat", 
                   "bankcardutil_cat")


for (var_name in cat_var_names) {
  
  if (class(loans_prod[, var_name]) == "factor") {
    level_names <- c(NA, levels(loans_prod[, var_name]))
  } else {
    level_names <- unique(c(NA, loans_prod[, var_name]))
  }
  
  
  var_name_bins <- paste(c(var_name, '_bins'), collapse = '')
  loans_prod[, var_name_bins] <- factor(loans_prod[, var_name], 
                                          levels = level_names, 
                                          exclude = NULL)
  
}


summary(loans_prod[, cat_var_names])
summary(loans_prod[, sprintf('%s_bins', cat_var_names)])


################################################################################
# Calculate Population Stability Indices
################################################################################


cat_var_names <- c("close", 
                   "rating",  
                   # Note that this also includes the binned numerical variables.
                   "bmaxrate_cat", "amount_cat", 
                   "bankcardutil_cat")


year_list <- seq(min(loans_prod[, 'year']), 
                 max(loans_prod[, 'year']))

PSI_Chi_Square <- data.frame(matrix(nrow = length(year_list), 
                                    ncol = length(cat_var_names) + 1))
colnames(PSI_Chi_Square) <- c('year', cat_var_names)

PSI_Chi_Square[, 'year'] <- year_list

PSI_KL_Divergence <- PSI_Chi_Square

# Set a minimum value in each bin, in case zero are observed.
min_prop <- 10^(-6)


# Copy columns from training sample in year 2005.
loans_2005 <- loans_prod[loans_prod[, 'year'] == 2005, ]
# Compare the probabilities in this sample with all future years.


# Loop on list of categorical variables.
for (var_name in cat_var_names) {
  
  bin_var_name <- sprintf('%s_bins', var_name)
  level_names <- levels(loans_prod[, bin_var_name])
  num_bins <- length(level_names)
  
  # Create a data.frame to store proportions in same columns.
  prop_df <- data.frame(matrix(min_prop, nrow = 2, ncol = length(level_names)))
  rownames(prop_df) <- c('bench', 'this_year')
  # colnames(prop_df) <- c('NA', level_names(2:length(level_names)))
  colnames(prop_df) <- paste(level_names)
  
  
  # Calculate the probabilities of observations in each bin, 
  # in the estimation sample.
  bench_proportions <- 
    table(loans_2005[, bin_var_name], useNA = 'ifany')/nrow(loans_2005)
  # Overwrite NA with "NA" character string.
  names(bench_proportions) <- paste(names(bench_proportions))
  
  prop_df['bench', names(bench_proportions)] <- bench_proportions
  prop_df['bench', prop_df['bench', ] == 0] <- min_prop
  
  
  for (year_num in 1:length(year_list)) {
    
    # Get sample for this year.
    this_year <- year_list[year_num]
    loans_prod_sel <- loans_prod[, 'year'] == this_year
    num_obs_year <- sum(loans_prod_sel)
    loans_prod_year <- loans_prod[loans_prod_sel, ]
    
    # Calculate the probabilities of observations in each bin, 
    # in the estimation sample.
    this_year_proportions <- 
      table(loans_prod_year[, bin_var_name], useNA = 'ifany')/num_obs_year
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
  level_names <- levels(loans_prod[, bin_var_name])
  num_bins <- length(level_names)
  
  # Plot Pearson's Chi-Squared
  # fig_file <- paste(c('Figures/input_stability/', var_name, '_ChiSq.png'))
  fig_file <- paste(c('Figures/', var_name, '_ChiSq.png'), collapse = '')
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
  # fig_file <- paste(c('Figures/input_stability/', var_name, '_KLD.png'))
  fig_file <- paste(c('Figures/', var_name, '_KLD.png'), collapse = '')
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
  level_names <- levels(loans_prod[, bin_var_name])
  num_bins <- length(level_names)
  
  # Select a subset of data for plotting figures.
  fig_data <- loans_prod[, c('year', bin_var_name)]
  colnames(fig_data) <- c('year', "binned_variable")
  
  
  
  # Plot a stacked bar graph of the counts of observations over time.
  # fig_file <- paste(c('Figures/input_stability/', var_name, '_bar.png'))
  fig_file <- paste(c('Figures/', var_name, '_bar.png'), collapse = '')
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
  # fig_file <- paste(c('Figures/input_stability/', var_name, '_prop_bar.png'))
  fig_file <- paste(c('Figures/', var_name, '_prop_bar.png'), collapse = '')
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


