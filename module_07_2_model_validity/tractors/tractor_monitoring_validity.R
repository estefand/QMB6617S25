
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


# setwd("~/GitHub/QMB6617S25_LM/module_07_2_model_validity")


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
tractor_prod <- read.csv('tractor_prod.csv')

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

# Copy columns from training sample in year 2000.
tractor_2000 <- tractor_prod[tractor_prod[, 'year'] == 2000, ]

#-------------------------------------------------------------------------------
# Plot R-squared and MAE by year.
#-------------------------------------------------------------------------------

year_list <- seq(min(tractor_prod[, 'year']), 
                 max(tractor_prod[, 'year']))


validity_stats <- data.frame(year = year_list, 
                             R_squared = numeric(length(year_list)), 
                             MAE = numeric(length(year_list)))

for (year_num in 1:length(year_list)) {
  
  # Get sample for this year.
  this_year <- year_list[year_num]
  tractor_prod_sel <- tractor_prod[, 'year'] == this_year
  num_obs_year <- sum(tractor_prod_sel)
  tractor_prod_year <- tractor_prod[tractor_prod_sel, ]
  
  # Calculate R_squared.
  R_squared <- 1 - 
    sum(( tractor_prod_year[, 'error_log_saleprice'] )^2) / 
    sum((tractor_prod_year[, 'log_saleprice'] - 
           mean(tractor_prod_year[, 'log_saleprice']))^2)
  validity_stats[year_num, 'R_squared'] <- 
    1 - (1 - R_squared)*(num_obs_year - 1) / 
    (num_obs_year - num_vars - 1)
  
  # Calculate MAE.
  validity_stats[year_num, 'MAE'] <- mean(abs(tractor_prod_year[, 'error_saleprice']))
}

validity_stats


# Plot Adjusted R_squared
fig_file <- "Figures/R_squared.png"
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
     ylim = c(0, 20000)
)
abline(h = validity_stats[1, 'MAE'], 
       lty = 'dashed', lwd = 2)
dev.off()


#-------------------------------------------------------------------------------
# Calculate lift charts.
#-------------------------------------------------------------------------------


# Convert to binned form in 10 quantiles.
n_bins <- 10
quantiles_2000 <- quantile(tractor_2000[, 'pred_log_saleprice'], 
                           0:n_bins/n_bins)
# Note that the quantiles are based on the predictions in the training sample.

tractor_prod[, 'pred_log_saleprice_bins'] <- cut(tractor_prod[, 'pred_log_saleprice'], 
                                                 quantiles_2000, 
                                                 labels = seq(n_bins))


table(tractor_prod[, 'pred_log_saleprice_bins'], useNA = 'ifany')
# Note that the bins do not have equal proportions 
# because the predictions may shift over time.
# Some lie beyond the outer quantiles.
sel_rows <- is.na(tractor_prod[, 'pred_log_saleprice_bins'])
tractor_prod[sel_rows, 'pred_log_saleprice']

# Assign extreme values to correct bins.
sel_rows <- tractor_prod[, 'pred_log_saleprice'] <= quantiles_2000[1]
tractor_prod[sel_rows, 'pred_log_saleprice_bins'] <- 1
sel_rows <- tractor_prod[, 'pred_log_saleprice'] >= quantiles_2000[n_bins]
tractor_prod[sel_rows, 'pred_log_saleprice_bins'] <- n_bins

table(tractor_prod[, 'pred_log_saleprice_bins'], useNA = 'ifany')



# Calculate a lift chart for each year. 
# Plot average prices by prediction bins.

# Prime with year for training sample.
year_num <- 1
this_year <- year_list[year_num]
tractor_prod_sel <- tractor_prod[, 'year'] == this_year
# num_obs_year <- sum(tractor_prod_sel)
tractor_prod_year <- tractor_prod[tractor_prod_sel, ]
# Calculate average log_saleprice by prediction bin.
avg_log_saleprices <- aggregate(x = tractor_prod_year[, 'log_saleprice'], 
                                by = list(tractor_prod_year[, 'pred_log_saleprice_bins']), 
                                FUN = "mean")
colnames(avg_log_saleprices) <- c('pred_log_saleprice_bins', 'avg_log_saleprice')

# Plot lift chart for this year.
fig_file <- "Figures/lift_chart_all.png"
png(fig_file)

plot(as.numeric(avg_log_saleprices[, 'pred_log_saleprice_bins']), 
     avg_log_saleprices[, 'avg_log_saleprice'], 
     main = 'Lift Charts for Model in Production',
     xlab = 'Prediction Bin', 
     ylab = 'Average Log Prices',
     lwd = 1, 
     type = 'l',
     col = 'black', 
     ylim = c(7, 12)
)



# Repeat for other years.
color_list <- rainbow(length(year_list) - 1)
for (year_num in 2:length(year_list)) {
  
  # Get sample for this year.
  this_year <- year_list[year_num]
  tractor_prod_sel <- tractor_prod[, 'year'] == this_year
  num_obs_year <- sum(tractor_prod_sel)
  tractor_prod_year <- tractor_prod[tractor_prod_sel, ]
  
  
  # Calculate average log_saleprice by prediction bin.
  avg_log_saleprices <- aggregate(x = tractor_prod_year[, 'log_saleprice'], 
                                  by = list(tractor_prod_year[, 'pred_log_saleprice_bins']), 
                                  FUN = "mean")
  colnames(avg_log_saleprices) <- c('pred_log_saleprice_bins', 'avg_log_saleprice')
  
  # Plot lift chart for this year.
  lines(as.numeric(avg_log_saleprices[, 'pred_log_saleprice_bins']), 
        avg_log_saleprices[, 'avg_log_saleprice'], 
        lwd = 3, 
        col = color_list[year_num]
  )
  
  
}
# Plot the original one more time on top.
year_num <- 1
this_year <- year_list[year_num]
tractor_prod_sel <- tractor_prod[, 'year'] == this_year
# num_obs_year <- sum(tractor_prod_sel)
tractor_prod_year <- tractor_prod[tractor_prod_sel, ]
# Calculate average log_saleprice by prediction bin.
avg_log_saleprices <- aggregate(x = tractor_prod_year[, 'log_saleprice'], 
                                by = list(tractor_prod_year[, 'pred_log_saleprice_bins']), 
                                FUN = "mean")
colnames(avg_log_saleprices) <- c('pred_log_saleprice_bins', 'avg_log_saleprice')
lines(as.numeric(avg_log_saleprices[, 'pred_log_saleprice_bins']), 
      avg_log_saleprices[, 'avg_log_saleprice'], 
      lwd = 4, 
      col = 'black', 
      lty = 'dotted'
)

legend("bottom", 
       legend = year_list, 
       fill = c("black", color_list), 
       cex = 0.75, 
       ncol = 5)
dev.off()



################################################################################
# End
################################################################################


