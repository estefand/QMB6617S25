
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






################################################################################
# End
################################################################################


