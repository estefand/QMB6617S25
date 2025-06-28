
# Model Monitoring: Model Stability

## Excess Predictive Value

After running the script ```loans_excess_predictive_value.R```,
this folder will contain several images to estimate the 
slope coefficients for each of the explanatory variables
of a predictive model over several years. 
In the estimation of excess parameter values, the original model prediction
is included in the regression model. 

These estimates should be compared against zero 
to find any changes in the model over time,
since the explanatory variables from the original sample
are already included in the model.
If the explanatory variables in the model, 
or any other variables not already in the original model, 
offer any predictive values,
it might indicate a change in the relationship between
the predicted outcome and the explanatory variables. 
Such a finding might suggest an opportunity for improvement of the model, 
by estimating the model on a more recent sample. 
