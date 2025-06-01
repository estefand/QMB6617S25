# QMB6617: Business Analytics for Managers
## Summer 2025

# Assignment 4

Save your scripts and materials in a folder called ```assignment_04``` in your GitHub repository.

For this Assignment, you can work in groups. 
Only one team member must submit the code for the assignment, 
while another can submit a table of results and the recommended model, 
through the quiz called *Model Evaluation and Selection*. 


## Names of Team Members:

1. Name
2. Name
3. Name
4. Name


## Instructions

This analysis follows up on the analysis completed for the final exam of 
QMB6315: Python for Business Analytics. 
The data have the same format, except the tables are provided in separate csv files. 
The goal is to further evaluate the model out of sample, using data observed later. 

1. Read in the data from the csv files in this folder.
2. Merge the data into one table, then separate it into three tables corresponding to the years 2022, 2023, and 2024.
3. Select the subset of the data corresponding to the year 2022. This is the sample from which you will estimate some regression models.
4. using the 2022 sample, estimate three regression models to predict:
  a. purchases
  b. utilization
  c. log-odds of utilization
4. For each the years 2023 and 2024, calculate each of the three predictions of the variables above, and transform as follows: 
  a. For the prediction of purchases, no transformation is necessary.
  b. For utilization, calculate predicted purchases by multiplying utilization by credit lines.
  c. For log-odds of utilization, apply the logistic transformation logit(x) = exp(x)/(1+exp()), 
  where exp(x) is the exponential function, which can be calculated with the exp() function in R or the mat.exp() function in Python, after importing the math module.
5. After step 4, all predictions should be in units of purchases. 
  Now evaluate the models by calculating the mean absolute errors (MAE). 
  That is, subtract the observed purchases from the predicted purchases.
  Then calculate the absolute value of the differences.
6. Compare the MAE from each model in each sample. Collect the result in a 3x3 table
  for each sample year (2022, 2023, and 2024) 
  and for each regression model (purchases, utilization, and log-odds of utilization).
7. Recommend a regression model based on the performance out-of-sample over the years 2023 and 2024. Lower MAE is more accurate, since the errors are smaller.


One group member should submit the table and the recommended model.
Another can submit the repository with the code. 

