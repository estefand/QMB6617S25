
# Model Monitoring: Stability

Monitoring for model stability is a set of procedures to track the 
factors that might influence or explain changes in 
the performance of a model over time. 

If one observes that the performance drops upon launch, 
due to some difference between the modeling framework and the real-world operation, 
one should know where the performance drop is coming from, so that a fix can be designed.
Over the medium term, some components might show a problem that should be addressed, 
which can be pinpointed to either the variables in the model, 
or the parameters in the model. 
Over the long term, the situation may change and a model can become outdated,
so these procedures are also useful to determine whether a model should be replaced, 
and, if so, what features and design components should be changed or excluded.


## Parameter Stability

This refers to the stability over time of the estimated parameters in a model.

### Statistical Methods

The statistical methods to detect parameter drift and ensure parameter stability
are usually based on estimated parameters from a regression model. 

#### Parameter Drift

This can be achieved by tracking the parameters of a model over time.
This might be achieved by estimating the model on the most recently observed sample. 
One could estimate the model each period and compare that model
against the original model being tested. 

#### Excess Predictive Value

A test for parameter stability could also be performed by running a regression model 
with the prediction included as an explanatory variable, 
along with other explanatory variables in the model, 
and potentially other variables *not* in the model. 
This would test whether some variables help to predict the outcome in excess of
the predictive ability of the variables in the original model.


If the original model is well specified, the only variable with explanatory power should be 
prediction from the original model. 
If the testing model shows that a variable that was *not* in the original model is 
statistically significant, it shows that that variable helps to predict
the outcome and could be added to the other predictors in a new model. 
If the testing model shows that a variable in the original model is 
statistically significant, it shows that this variable helps to predict beyond 
the prediction from the original model. 
This suggests that the model could be re-estimated with a new coefficient or 
functional form (e.g. log transformation) on this variable.

When the variable has a *statistically significant positive* effect, 
it indicates that the original model *underestimates* the effect of that variable
when predicting the outcome.
Conversely, when the variable has a *statistically significant negative* effect, 
it indicates that the original model *overestimates* the effect of that variable
when predicting the outcome.


### Graphical Methods

One could plot the estimated coefficients over time, which would reveal changes in
the relationship between explanatory variables and the predicted value. 
These can be plotted along with the standard errors for a model. 

#### Parameter Drift

This plot of parameters could be drawn for the parameters in a new regression model, 
including all variables, to test the stability of relationships with variables 
already in the model, as well as not included in the model. 
For those variables already included in the model, 
the estimated parameters should be compared against their coefficients 
in the original model being tested. 

#### Excess Predictive Value

The interpretation is different when one runs a regression 
to detect excess predictive value, while including 
the predictions from the original model as an explanatory variable. 
In this case, the variables that are already in the model should have
zero excess predictive value beyond their role within the original model being tested.
Thus, the series of estimated coefficients for excess prediction
should be compared against the value of zero. 
That is, simply tested for statistical significance.

#### Nonparametric Models

Some models do not use a parametric form, such as linear regression or logistic regression, 
in which coefficients (i.e. parameters) are used in a formula to calculate the prediction. 
Nonparametric models, such as kernel-smoothed models or machine-learning models 
follow algorithms that do not explicitly calculate a prediction from a formula. 
These tests might still be useful to detect changes in relationships
over time. 
In addition, for machine-learning models, one could plot the hyperparameters over time. 
In either case, the time series of parameters should be compared with the estimated values 
from the original model. 


## Input Stability


### Statistical Methods

This can be achieved by tracking a performance statistic, 
such as a goodness-of-fit statistic on the distributions of input variables. 
The goodness-of-fit statistic could be a Chi-squared statistic or
a Kullback-Leibler Divergence Criterion. 
Either could be used to construct a population stability index that can be plotted over time. 

#### Goodness-of-Fit Statistic

Although there are many choices, the most common  
[goodness-of-fit](https://en.wikipedia.org/wiki/Goodness_of_fit) statistic is 
[Pearson's Chi-Squared Test](https://en.wikipedia.org/wiki/Pearson%27s_chi-squared_test). 
It is designed for calculating differences between distributions for categorical variables. 
However, it could be used to calculate differences in distributions for continuous
variables by separating values into bins, like one does when drawing a histogram. 

The calculation of the statistic is as follows.

<img src="../Images/PearsonGOF.png" width="750"/>

The values of the inputs are the proportions of observations in each bin, 
from the null distribution and the comparison distribution. 
When checking whether a distribution has changed from that in the original model, 
the null distribution is that distribution of the variable that was in the original
sample from which the model was built. 
The comparison distribution is the distribution of the variable on future data, 
when the model is in use to make a decision. 
The statistic follows a Chi-squared distribution with degrees of freedom equal 
to the number of bins minus one. 

#### Kullback-Leibler Divergence Criterion

The theory for the Kullback-Leibler Divergence Criterion is more involved, 
and the behavior of this statistic is less intuitive, but it is more powerful 
in that it is more likely to detect certain types of changes in the distribution. 
It is based on the concept of relative entropy of two phenomena, 
which could be thought of as the degree of variation. 
The formal definition is as follows.


<img src="../Images/KLDformula.png" width="750"/>

In this expression, x is the outcome variable, Q represents the probabilities
under the null distribution and P represents the probabilities
under the distribution to be tested for equality. 

Aside from the more technical calculation from taking log transformations, 
this statistic has one major drawback combined with a super power.
This value becomes infinite when the new distribution has zero observations
where the null distribution has some probability mass. 
Thus, this would indicate with certainty that the distributions are different. 
In some sense this is perfect information that the distributions are different, 
beccause if two distributions do not agree on which outcomes are impossible
(i.e. have zero probability) then they are surely different


### Graphical Methods

As with parameter stability, 
one could plot the statistical measure over time, 
whether it is the Chi-squared statistic or
the Kullback-Leibler Information Criterion, 
to show how the distribution of input variables in the latest period
compares to the distribution of the variables in the sample for the original estimation. 
When the value of the difference becomes large, it indicates a significant change
in the distribution of the input variable. 
If the input variable has a different distribution, it might indicate that the meaning
of the variable has changed.
In any case, such a change might indicate that the relationship between the variable 
and the predicted outcome has changed, 
and that a new estimation of the model might be in order. 


