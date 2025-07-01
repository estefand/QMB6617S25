
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
# Take inventory of all varialbes
################################################################################

summary(tractor_prod)

# These variables are continuous.
cts_var_names <- c('age', 'enghours', 'horsepower')
# Note that changes in squared_horsepower are captured in horsepower.

# Convert these into categorical variables to create histograms.
n_bins <- 6


for (var_name in cts_var_names) {
  
  quantiles_2000 <- quantile(tractor_2000[, var_name], 
                             0:n_bins/n_bins)
  
  var_name_bins <- paste(c(var_name, '_cat'), collapse = '')
  tractor_prod[, var_name_bins] <- cut(tractor_prod[, var_name], 
                                                   quantiles_2000, 
                                                   labels = seq(n_bins))
  # Assign extreme values to correct bins.
  sel_rows <- tractor_prod[, var_name] <= quantiles_2000[1]
  tractor_prod[sel_rows, var_name_bins] <- 1
  sel_rows <- tractor_prod[, var_name] >= quantiles_2000[n_bins]
  tractor_prod[sel_rows, var_name_bins] <- n_bins
  
  
  
}

summary(tractor_prod[, cts_var_names])
summary(tractor_prod[, sprintf('%s_cat', cts_var_names)])


# Convert all categorical variables into factors,
# leaving room for the possibility of missing values.

cat_var_names <- c("johndeere", 
                   "diesel", "fwd", "manual", 
                   "cab", "cab_orig", 
                   "spring", "summer", "winter",  
                   # Note that this also includes the binned numerical variables.
                   'age_cat', 'enghours_cat', 'horsepower_cat')


for (var_name in cat_var_names) {
  
  level_names <- unique(c(NA, tractor_prod[, var_name]))
  
  
  var_name_bins <- paste(c(var_name, '_bins'), collapse = '')
  tractor_prod[, var_name_bins] <- factor(tractor_prod[, var_name], 
                                          levels = level_names, 
                                          exclude = NULL)

}


summary(tractor_prod[, cat_var_names])
summary(tractor_prod[, sprintf('%s_bins', cat_var_names)])


################################################################################
# Calculate Population Stability Indices
################################################################################


cat_var_names <- c("johndeere", 
                   "diesel", "fwd", "manual", 
                   "cab",
                   "cab_orig", 
                   "spring", "summer", "winter",  
                   # Note that this also includes the binned numerical variables.
                   'age_cat', 'enghours_cat', 'horsepower_cat')


year_list <- seq(min(tractor_prod[, 'year']), 
                 max(tractor_prod[, 'year']))

PSI_Chi_Square <- data.frame(matrix(nrow = length(year_list), 
                                    ncol = length(cat_var_names) + 1))
colnames(PSI_Chi_Square) <- c('year', cat_var_names)

PSI_Chi_Square[, 'year'] <- year_list

PSI_KL_Divergence <- PSI_Chi_Square

# Set a minimum value in each bin, in case zero are observed.
min_prop <- 10^(-6)


# Copy columns from training sample in year 2000.
tractor_2000 <- tractor_prod[tractor_prod[, 'year'] == 2000, ]
# Compare the probabilities in this sample with all future years.


# Loop on list of categorical variables.
for (var_name in cat_var_names) {
  
  bin_var_name <- sprintf('%s_bins', var_name)
  level_names <- levels(tractor_prod[, bin_var_name])
  num_bins <- length(level_names)
  
  # Create a data.frame to store proportions in same columns.
  prop_df <- data.frame(matrix(min_prop, nrow = 2, ncol = length(level_names)))
  rownames(prop_df) <- c('bench', 'this_year')
  # colnames(prop_df) <- c('NA', level_names(2:length(level_names)))
  colnames(prop_df) <- paste(level_names)
  
  
  # Calculate the probabilities of observations in each bin, 
  # in the estimation sample.
  bench_proportions <- 
    table(tractor_2000[, bin_var_name], useNA = 'ifany')/nrow(tractor_2000)
  # Overwrite NA with "NA" character string.
  names(bench_proportions) <- paste(names(bench_proportions))
  
  prop_df['bench', names(bench_proportions)] <- bench_proportions
  prop_df['bench', prop_df['bench', ] == 0] <- min_prop
  
  
  for (year_num in 1:length(year_list)) {
    
    # Get sample for this year.
    this_year <- year_list[year_num]
    tractor_prod_sel <- tractor_prod[, 'year'] == this_year
    num_obs_year <- sum(tractor_prod_sel)
    tractor_prod_year <- tractor_prod[tractor_prod_sel, ]
    
    # Calculate the probabilities of observations in each bin, 
    # in the estimation sample.
    this_year_proportions <- 
      table(tractor_prod_year[, bin_var_name], useNA = 'ifany')/num_obs_year
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
  level_names <- levels(tractor_prod[, bin_var_name])
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
  level_names <- levels(tractor_prod[, bin_var_name])
  num_bins <- length(level_names)
  
  # Select a subset of data for plotting figures.
  fig_data <- tractor_prod[, c('year', bin_var_name)]
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

