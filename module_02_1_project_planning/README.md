
# Planning of Business Analytics Projects


## Introduction


### Project Complexity

Drivers of ML Project Complexity and Challenge

- ML projects must address challenges within specific domains (e. g. , business, healthcare).
- Handling complex data resources and sophisticated models adds to project complexity.

Data Dependency

- ML systems rely heavily on data quality and structure for model creation.
- Data assets are often large, complex, and may contain sensitive information.
- Teams must develop processes to understand and manage complex and noisy data at both system and statistical levels.

Model Creation and Management

- ML projects involve creating and using models that need to be measured and understood.
- Understanding model properties is essential for system design and evaluation.
- Model lifecycle management is crucial, including both technical and business evaluation.

Alignment with Requirements

- ML systems should consider scientific, stakeholder, and societal needs.
- Ethical considerations must be integrated throughout the development process.

Figure 1.2 shows how these three concerns can be represented as a Venn diagram. This
diagram is helpful because we can use it to map out the work and responsibilities in an
ML project.

<img src="Images/MMLP_Complexity_Drivers.png" width="500"/>


Challenges in ML Projects

- Addressing various tasks is essential for a timely, efficient, and high-quality outcome.
- Four main needs are identified for successful ML project delivery:

Identifying Risk and Opportunity
- Quickly recognize risks and opportunities during the project.
- Understanding project risk in ML requires time and effort.

Team Adaptability
- Teams must react and adapt quickly to unexpected issues.
- Ability to pivot is crucial as user requirements evolve and model performance issues arise.

Customer Engagement
- Involve the customer throughout the project process.
- Building engagement, sponsorship, and soliciting feedback enhances project effectiveness.

System Maintenance and Documentation
- Deliver all components necessary for understanding, using, running, and maintaining the ML system.
- Provide proper documentation to assist future teams in managing the code and models.

Overall Summary of ML Projects
- ML projects are challenging and models often lack precision.
- High uncertainty and risk are present compared to traditional software development.
- Strong dependence on large data resources, which often contain biases.
- Human interaction with ML systems can lead to unexpected behavioral loops and challenges in managing data efficiently.


### Project Management Paradigms

History of Software Development
- Software systems have been created for over 50 years.
- Machine Learning (ML) systems have also been developed during this time.
- For many years, software development was organized around planned predictions, known as the waterfall approach.

Waterfall Approach
- The waterfall approach involved gathering information, creating a design, programming, testing, and user acceptance.
- As software systems grew more complex, the waterfall approach became less effective.
- Users found waterfall-developed software irrelevant to their needs due to a disconnect in the process.
- Project managers struggled to estimate complexity and costs because of separation from implementation.

Disillusionment with Waterfall Approach
- High costs of structured waterfall methodologies and unclear value led to widespread disillusionment.
- This prompted a reevaluation of waterfall to more iterative methodologies.
- New approaches included Spiral methodology and V models.

Shift to Agile Development
- Agile development emerged as the most popular alternative.
- Emphasizes early delivery of working software and customer collaboration.
- Focuses on managing change and discovery effectively.

Evolution of Agile: DevOps
- DevOps aims to bridge developers and support teams.
- Highlights the operations team's expertise in software.
- Addresses the mismatch in understanding between development and operational environments.
- Develops automation in software development processes for focus on development.

Impact of DevOps
- Supports rapid and adaptive software development.
- Reduces cost and risk of late-stage changes in software development.
- Flexibility late in the project significantly enhances the quality of the delivered software.


<img src="Images/MMLP_DevOps_Process.png" width="500"/>



### Design Considerations

Different perspectives and considerations should be applied 
when developing a production system by contrasting the needs of research implementations. 
An overview of design considerations (performance requirements and compute requirements) 
consists of four phases
(figure 1.4):
-	Project setup is the process of figuring out as much detail as possible about the 
problem at hand. The methods of doing this are couched as a discussion in a 
technical interview, and the source of information is seen as the interviewer. 
Goals, user experience, performance constraints, evaluation, personalization, 
and project constraints (people, compute power, and infrastructure) are identified as significant elements to be considered. 
-	The data pipeline element considers privacy and bias, storage, preprocessing, 
and availability.
-	Modelling is considered in terms of model selection, training, debugging, hyperparameter tuning and scaling (in the sense of covering a large amount of training data). 
-	Serving is framed in terms of the evaluation of the model and the assumptions 
that we need to understand when running the model in the field.


<img src="Images/MMLP_ML_Project_Flow.png" width="500"/>

## Summary

- The explosion of data and computing in the last 10 years proves that machine
learning (ML) has become an important technology.
- There have been problems in terms of both successfully delivering ML projects
and the negative impacts that these can have when they are delivered.
- ML projects are different because they depend on complex data, require the
team to produce and manage models created from the data, and need to be carefully
aligned with the needs of the users and stakeholders.
- A successful ML project drives out risk from requirements and data, captures
nonfunctional and functional requirements, and develops capabilities for handling
and evaluating models.
- The ML project needs to be aligned with the needs of society and stakeholders
throughout its lifecycle to avoid undesirable outcomes.
- We can borrow ideas from agile software and the DevOps community to help us
develop the projects.




<img src="../Images/MMLP_Book_Cover.webp" width="200"/>

# Chapter 2: Pre-Project: From Opportunity to Requirements

This chapter covers
-	Understanding the project type and the 
stakeholders' expectations of scale and 
structure
-	Setting up a pre-sales/pre-project process
-	Understanding requirements for model 
performance 
-	Understanding data assets
-	Understanding the project's general 
requirements
-	Coming to grips with the tools and 
infrastructure to deliver successfully


##  Pre-project backlog


##  Project management infrastructure


##  Project requirements


###  Funding model 

### Business requirements


#### Business requirements: Why?


#### Business requirements: Who?


#### Business requirements: What?


## Data


##  Security and privacy


## Corporate responsibility, regulation, and ethical considerations


## Development architecture and process


<img src="Images/MMLP_Version_Control.png" width="500"/>


###  Development environment 


###  Production architecture



## Summary

-	A structured process to develop a project is necessary if you are going to successfully manage risk.
-	It's important to understand how to manage the project and to comprehend the 
required project management infrastructure.
-	ML projects have particular features that need to be captured as requirements.
-	Particular attention needs to be paid to the data assets that will underpin the 
project, as well as getting a picture of what data is available. 
-	It’s important to understand how the data will be accessed and what capability is 
available to manipulate and prepare it for use by ML.
-	We need to understand specific requirements about the security and privacy of 
the data asset; this can introduce higher costs into the project.
-	A well-understood and fit-for-purpose development infrastructure is needed, and 
the IT architecture that the project is going to be delivered into needs to be clear.
-	Specific consideration to the corporate responsibility and ethical aspects of the 
project should be built in from the beginning.


<img src="../Images/MMLP_Book_Cover.webp" width="200"/>

# Chapter 3: Pre-Project: From Requirements to Proposal


This chapter covers
-	Creating a project hypothesis 
-	Generating an estimate for effort and time 
-	Doing the paperwork to get the project 
underway 
-	Completing your pre-sales checklist



## Build a project hypothesis



## Create an estimate



###  Time and effort estimates


### Team design for ML projects


<img src="Images/MMLP_Team_Roles.png" width="500"/>




<img src="Images/MMLP_Team_Evolution.png" width="500"/>


###  Project risks


## Pre-sales/pre-project administration


## Pre-project/pre-sales checklist






## Summary
-	To get to a proposal for the project, the requirements need to be transformed 
into a hypothesis that spells out the expected outcome and key challenges.
-	A structured process of estimation can then be done based on the hypothesis and 
the information about the delivery environment that you gathered in chapter 2.
-	An useful estimate takes into account the team's structure and the commitment 
needed to meet the requirements.
-	Get your project documentation properly reviewed and signed off before anyone 
mentions costs to the customer.
-	If the pre-project phase fails, then it's certain that the project would have failed, 
and that is far worse.



