
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

### Statistical Methods

This can be achieved by tracking the parameters of a model over time.
This might be achieved by estimating the model on the most recently observed sample. 


### Graphical Methods

One could plot the estimated coefficients over time, which would reveal whether
the relationship between explanatory variables and the predicted value has changed. 
These can be plotted along with the standard errors for a model. 


For machine-learning models, one could plot the hyperparameters over time. 

In either case, the time series of parameters should be compared with the estimated values 
from the origin model. 


## Input Stability


### Statistical Methods

This can be achieved by tracking a performance statistic, 
such as a goodness-of-fit statistic on the distributions of input variables. 
The goodness-of-fit statistic could be a Chi-squared statistic or
a Kullback-Leibler Information Criterion. 
Either could be used to construct a population stability index that can be plotted over time. 


### Graphical Methods

As with parameter stability, 
one could plot the statistical measure over time, 
to show how the distribution of input variables in the latest period
compares to the distribution of the variables in the sample for the original estimation. 



