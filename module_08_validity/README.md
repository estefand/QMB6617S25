
# Model Monitoring: Validity

Monitoring for model validity is a set of procedures to track the performance of a model over time. One will want to know whether the performance drops upon launch, 
due to some difference between the modeling framework and the real-world operation.
Over the medium term, some components might show a problem that should be addressed. 
Over the long term, the situation may change and a model can become outdated,
so these procedures are also useful to determine whether a model should be replaced.


## Regression Models for Continuous Variables

### Statistical Methods

This can be achieved by tracking a performance statistic over time. 
The performance statistic should measure the predictive value of the model. 
Examples of statistics include R-squared but it could also be a less formal statistic
tied to a business metric or KPI.
These would calculate a measure of the difference between the expected and actual value.
Statistics such as Mean Absolute Error (MAE), 
or Mean Squared Error (MSE) or Root-Mean Squared Error (RMSE). 
Sometimes the proportional difference is important, in which case 
the Mean Absolute Proportional Error (MAPE) could be used.  

### Graphical Methods

Whatever metric is calculated to indicate the quality of fit, 
one could plot the statistical measure over time.
to measure changes in the quality of predictions over time. 

As an alternative, one could plot a lift chart, 
to show the different outcomes that occur for different levels of prediction. 
in some sense, this could be achieved by drawing a scatterplot
of the outcome against the predicted value. 
A relationship that is close to a 45-degree line is the ideal, 
in which prediction equals actual. 

Sometimes the effect will be difficult to detect, 
so an alternative is to sort the predictions into bins, such as by quantiles, 
and then plot average values for each. 
Higher values of the outcome should be observed for higher values of the predictions. 


## Classification Models for Categorical Variables

Classification models often assign a set proportion to a finite number of outcomes.
The most common of which is a binary outcome: whether some event has happened or not. 

### Statistical Methods

This can be achieved by tracking a performance statistic, 
such as Area under the ROC curve over time. 
Other metrics such as MAE or MSE could be used, 
which would be calculated the same way as for continuous variables, 
except that the target of the prediction is a proportion. 

### Graphical Methods

As with continuous variables, 
one could plot the statistical measure over time, or one could plot a lift chart, 
to show the different outcomes that occur for different levels of predicted probabilities. 

For example, plot the proportion of events across predicted probabilities. 
Unlike with continuous variables, the predicted outcome probabilities 
should always be sorted into bins before plotting the trend in line charts. 
otherwise, the observations will be clustered around zero and one (for binary events)
and it will be difficult to discern any changes in predicted proportions. 




