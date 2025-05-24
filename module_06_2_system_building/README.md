
# System Building and Production


## Introduction




<img src="../Images/MMLP_Book_Cover.webp" width="200"/>

This chapter covers
-	Embedding your models into the system you are 
going to build
-	Dealing with nonfunctional implications
-	Building the data and model-serving 
infrastructures for production
-	Ensuring that the user interface is appropriate
-	Ensuring that the logging, monitoring, and 
alerting elements are properly governed and 
managed in production


## Sprint 3 backlog




<img src="Images/MMLP_Post_Model_Checklist.png" width="500"/>




<img src="Images/MMLP_ML_Layers.png" width="500"/>



## Types of ML implementations



<img src="Images/MMLP_Prod_Analysis_S3_1_2.png" width="500"/>



### Assistive systems: recommenders and dashboards




<img src="Images/MMLP_Intel_Dashboard.png" width="500"/>




<img src="Images/MMLP_Coconcurrence_Table.png" width="500"/>


###  Delegative systems



<img src="Images/MMLP_Delegative_System.png" width="500"/>


### Autonomous systems



## Nonfunctional review



<img src="Images/MMLP_Nonfunctional_Review.png" width="500"/>


## Implementing the production system


<img src="Images/MMLP_Implementation_S4_3_6.png" width="500"/>



### Production data infrastructure



<img src="Images/MMLP_Implementation_Flow.png" width="500"/>



<img src="Images/MMLP_Data_Engines.png" width="500"/>



### The model server and the inference service



<img src="Images/MMLP_Generic_Engines.png" width="500"/>


### User interface design 




<img src="Images/MMLP_AI_Design.png" width="500"/>



## Logging, monitoring, management, feedback, and documentation



<img src="Images/MMLP_Support_S3_7_9.png" width="500"/>



### Model governance



### Documentation

During the project, you should have produced and filed a great deal of documentation. All of this is incredibly useful and valuable, but to deliver a maintainable system, 
the team needs to prepare some additional documents that support the system in life. 
These documents are:
-	A production team organization chart
-	A run book
-	A technical overview
-	A troubleshooting guide


## Pre-release testing


<img src="Images/MMLP_Pre_Release_Testing_S3_10.png" width="500"/>



## Ethics review



## Promotion to production



<img src="Images/MMLP_Pre_Release_Testing_S3_11.png" width="500"/>


## You aren't done yet



<img src="Images/MMLP_Pre_Release_Testing_S3_12.png" width="500"/>



## Summary


-	Make a deliberate choice about the type of ML system that you and the team are 
building. Is it assistive, delegative, or autonomous? 
-	Own the implications of that choice! The nonfunctional and functional requirements of the various types of ML-driven systems are different. 
-	You need to build production data flows and a suitable model-serving infrastructure to support the requirements that you've identified. 
-	User interface requirements for ML systems are different from normal systems. 
You will need to ensure that the system is appropriately instrumented and that 
the relevant controls are available to the users. 
-	Make sure to provide the right logging, monitoring, and alerting infrastructure, 
or the production support groups won't be able to accept it into service. 
-	Get your system tested and signed off as fit for production.
-	Budget time and effort for pre-release user and integration testing. 
-	Ethical review is essential when developing a release candidate for the system. 
This is often the point at which stakeholders realize what it is that has been implemented and its implications. It can be painful, but catching problems at this last 
hurdle is far preferable to releasing problems into the wild. 
-	Be ready for the ongoing work that comes with delivering a system into production. Your job isn't over when the users get their hands on your work. In fact, it's 
probably just beginning. 
