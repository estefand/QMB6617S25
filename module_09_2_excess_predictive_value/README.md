
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


In a previous module, we considered the evolving relationship
between the explanatory variables and the outcome that is predicted.
This is an analysis of the changes in the estimates of parameters 
in repeated estimations of a model, a phenomenon known as *parameter drift*
or  *parameter stability*. 
Another approach focuses on a variable's *excess predictive value*.
This strategy directly evaluates the model prediction arises
from a statistical model with the model prediction as an explanatory variable, 
along with the explanatory variables in the original model, 
and potentially other models that could be included in a model rebuild. 
Thus, this approach is an analysis of a variable's *excess predictive value*, 
beyond its contribution to the prediction from within the model, 
or from potentially including the variable in a future model, 
if the variable is not already in the original model. 
Today we will focus on the analysis of the excess predictive value.


## Parameter Stability

This refers to the stability over time of the estimated parameters in a model.

### Statistical Methods

The statistical methods to detect parameter drift and ensure parameter stability
are usually based on estimated parameters from a regression model. 


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


#### Excess Predictive Value

The interpretation is different when one runs a regression 
to detect excess predictive value, while including 
the predictions from the original model as an explanatory variable. 
In this case, the variables that are already in the model should have
zero excess predictive value beyond their role within the original model being tested.
Thus, the series of estimated coefficients for excess prediction
should be compared against the value of zero. 
That is, simply tested for statistical significance.

### Nonparametric Models

For models that use a parametric form, such as linear regression or logistic regression, 
the which coefficients (i.e. parameters) are used in a formula to calculate the prediction, 
so this lends well to analyzing changes in the parameters in the model. 
Nonparametric models, such as kernel-smoothed models or machine-learning models 
follow algorithms that do not explicitly calculate a prediction from a formula. 
These tests might still be useful to detect changes in relationships
over time, in the form of potential *modifications* to the machine-learning  model. 
In this case, a discovery of siginficant predictive value beyond the prediction
from a machine-learning model would indicate the potential for a rebuild
of the machine-learning model, 
potentially with different variables included.

