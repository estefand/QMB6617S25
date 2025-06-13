
# Model Monitoring: Validity

Monitoring for model validity is a set of procedures to track the performance of a model over time. One will want to know whether the performance drops upon launch, 
due to some difference between the modeling framework and the real-world operation.
Over the medium term, some components might show a problem that should be addressed. 
Over the long term, the situation may change and a model can become outdated,
so these procedures are also useful to determine whether a model should be replaced.


## Regression Models for Continuous Variables

### Statistical Methods

This can be achieved by tracking a performance statistic, such as R-squared over time. 


### Graphical Methods

One could plot the statistical measure over time, or one could plot a lift chart, 
to show the different outcomes that occur for different levels of prediction. 

For example, plot the average outcome across predicted outcomes. 
Perhaps the predicted outcomes could be sorted into bins before plotting
the trend in line charts. 


## Classification Models for Categorical Variables

Classification models often assign a set proportion to a finite number of outcomes.
The most common of which is a binary outcome: whether some event has happened or not. 

### Statistical Methods

This can be achieved by tracking a performance statistic, 
such as Area under the ROC curve over time. 


### Graphical Methods

As with continuous variables, 
one could plot the statistical measure over time, or one could plot a lift chart, 
to show the different outcomes that occur for different levels of predicted probabilities. 

For example, plot the proportion of events across predicted probabilities. 
Perhaps the predicted outcome probabilities could be sorted into bins before plotting
the trend in line charts. 




