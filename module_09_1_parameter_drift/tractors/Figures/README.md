
# Model Monitoring: Model Stability

## Parameter Drift

After running the script ```tractor_parameter_drift.R```,
this folder will contain several images to estimate the 
slope coefficients for each of the explanatory variables
of a predictive model over several years. 

These estimates should be compared against the estimates
from the original sample to find any changes in the model over time.
This might indicate a change in the relationship between
the predicted outcome and the explanatory variables. 
Such a finding might suggest an opportunity for improvement of the model, 
by estimating the model on a more recent sample. 
