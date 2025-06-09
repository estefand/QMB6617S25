# QMB6617: Business Analytics for Managers
## Summer 2025

# Assignment 5

Save your scripts and materials in a folder called ```assignment_05``` in your GitHub repository.

For this Assignment, as for the last one, you can work in groups. 
Only one team member must submit the code for the assignment, 
while another can submit a table of results and the recommended model, 
through the quiz called *Machine Learning Model Evaluation*. 


## Names of Team Members:

1. Name
2. Name
3. Name
4. Name


## Instructions

This analysis is a second follow-up of the analysis completed for the final exam of 
QMB6315: Python for Business Analytics. 
The data have the same format, except the tables are provided in separate csv files. 
The goal is to further evaluate the potential to fit the data with more sophisticated models, 
rather than thinking of clever ways to transform the variables. 

1. Read in the data from the csv files in this folder.
2. Select the subset of the data corresponding to the year 2022. This is the sample from which you will estimate some regression models.
3. Using the 2022 sample, estimate three machine learning models to predict:
  a. regression (on either purchases, utilization, or log-odds of utilization, whichever is better)
  b. decision tree (on purchases directly)
  c. random forest (on purchases directly)
  d. gradient boosted machines (on purchases directly)
4. For each the years 2023 and 2024, calculate each of the four predictions of the variables above, and transform as follows: 
  a. For the prediction of purchases, no transformation is necessary.
  b. For utilization, calculate predicted purchases by multiplying utilization by credit lines.
  c. For log-odds of utilization, apply the logistic transformation logit(x) = exp(x)/(1+exp(x)), 
  where exp(x) is the exponential function, which can be calculated with the exp() function in R or the math.exp() function in Python, after importing the math module.
5. After step 4, all predictions should be in units of purchases. 
  Now evaluate the models by calculating the mean absolute errors (MAE). 
  That is, subtract the observed purchases from the predicted purchases.
  Then calculate the absolute value of the differences.
6. Compare the MAE from each model in each sample. Collect the result in a 3x5 table
  for each sample year (2022, 2023, and 2024) 
  and for each machine learning model (regression, decision tree, random forest, and gradient boosted machines).
7. Notice that each of the machine-learning models use different values of hyperparameters, such as ```trees```, ```min_n```, ```tree_depth```, and so on. Estimate the machine learning models several times by trying different values for these hyperparameters. Find the best-fitting combination of hyperparameters for each machine-learning model. 
8. Recommend a machine learning model, along with your winning set of hyperparameters, based on the performance out-of-sample over the years 2023 and 2024. Lower MAE is more accurate, since the errors are smaller.


One group member should submit the table and the recommended model.
Another can submit the repository with the code. 

## More Information

For more information about the ```tidymodels``` library, 
please see [The Tidymodels Webpage](https://www.tidymodels.org/)

### Decision Trees

A description of decision trees can be found on [GeeksForGeeks](https://www.geeksforgeeks.org/decision-tree/)

For examples of syntax for decision trees, see The Parsnip Page on [Decision Trees](https://parsnip.tidymodels.org/reference/decision_tree.html) 

### Random Forest

A description of random forest can be found on [IBM Random Forest](https://www.ibm.com/think/topics/random-forest)

For examples of syntax for random forest, see 
[Random forest](https://parsnip.tidymodels.org/reference/rand_forest.html)

### Gradient Boosted Trees

A description of gradient boosted trees can be found on [Machine Learning +](https://www.machinelearningplus.com/machine-learning/an-introduction-to-gradient-boosting-decision-trees/)

For examples of syntax for gradient boosted trees, see 
[Boosted trees via xgboost](https://parsnip.tidymodels.org/reference/details_boost_tree_xgboost.html)
