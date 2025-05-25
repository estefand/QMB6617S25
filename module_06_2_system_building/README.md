
# System Building and Production


## Introduction




<img src="../Images/MMLP_Book_Cover.webp" width="200"/>

# Chapter 9: System Building and Production

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

Sprint 2 Overview
- Team built, tested, and selected models to support user stories from Sprint 1.
- Models cannot generate value without further work; they remain idle in a repository.
- AI models need implementation in IT architecture to support business processes and customer delivery.

Sprint 3 Focus
- Work will focus on two characteristics of an ML system:
- Implementing data infrastructure for the production platform.
- Retrieving and running ML models created in Sprint 2.

Production System Components
- Process for deciding required components in the production system is discussed.
- Later sections will address tradeoffs and decisions for:
- Data layer selection and delivery.
- Model-serving infrastructure.
- Interface elements.

Next Steps
- Team needs to determine the type of ML system to build.

## Sprint 3 backlog

Table 9.1 provides a summary of the tasks that we'll explore in this chapter. These tasks
are the must be completed before your project can move into production and start to
deliver value for your users.


<img src="Images/MMLP_Post_Model_Checklist.png" width="500"/>

Data Infrastructure
- Creates input for the ML system
- Includes streams of user interactions (e. g. , clicks)
- Provides signals for model inference

Inference Service
- Invokes models based on data stream events
- Can operate in batch mode (processing files of data)
- Can operate responsively (triggered by application events)

Model Output Usage
- Used by application code for decision-making
- Can lead to displaying information to the user
- May feed into the control system of a machine


<img src="Images/MMLP_ML_Layers.png" width="500"/>

Exposure Interface

- Bottom layer of the stack in figure 9. 1
- Interacts with users by publishing model inferences
- Provides logging and management data (e. g. , alerts for unexpected behavior)
- Offers integration information for other systems (e. g. , orchestration signals)

Recommendations for Functionality

Use data engines like:
- Big Table
- Redshift
- SQL Server
- Oracle
- Kafka
- SPARK

Deploy application code using engines such as:
- Kubeflow
- Kubernetes
- OpenShift
- Flask
- Tomcat
- Serverless components (AWS Lambda, Azure Serverless, GCP’s Cloud Functions)

Use systems for exposure layers like:
- Splunk
- Grafana
- User interface development frameworks, such as Angular.js

## Types of ML implementations

Usage of Models
- Important to decide on the usage of created models.
- Models have been selected for use after development.

Types of Models
- Assistive Models
- Produce output directly for human use.
- Example: Summarized data in a dashboard; recommendations from sensor readings.

- Delegative Models
- Create control signals without human input but under supervision.
- Examples: Monitored chemical factories, fly-by-wire aircraft, autopilots.

- Autonomous Models
- Operate without human control or monitoring for significant time.
- Examples: Robots, drones, high-frequency trading systems.

Spectrum of Autonomy and Control
- Models vary in autonomy and human control.
- Higher autonomy means less human control, requiring more reliability and robust engineering.

Design Forces with Increased Autonomy
1. Need for Explanation
- More autonomous systems need to explain decisions better than those under direct human control.

2. Documentation and Accountability
- Development processes must be documented more thoroughly for autonomous systems.
- Organizations must account for their decisions effectively.

3. Nonfunctional Performance Requirements
- Autonomous systems need robust performance; no human intervention may be possible in failures.

Next Steps
- After reviewing production system analysis tickets for sprint 3, proceed to upcoming tasks.
- Upcoming section will explore implications of building assistive, delegative, and autonomous ML systems.

<img src="Images/MMLP_Prod_Analysis_S3_1_2.png" width="500"/>



### Assistive systems: recommenders and dashboards

Overview of Assistive Systems
- Assistive systems are for direct human use.
- Their value comes from transparency and human inspection.
- They provide advice but do not control decisions made by users.

Functions of Assistive Systems
- Summarize information and offer predictions.
- Help humans make decisions and gain insights efficiently.
- Create economic and scientific value from complex data.

Example: Large Hadron Collider
- High-energy particle collider using assistive systems.
- Machine learning (ML) techniques were essential for analyzing vast data sets.
- Enabled the physics community to maximize their powerful experimental tools.

Dashboards as Assistive Interfaces
- A dashboard displays a set of visualizations relevant to business problems.
- Allows for rapid information inspection.
- Tools available for creating dashboards:
- Proprietary: Looker, Power BI, Qlik, Tableau
- Open source: Shiny, Dash

Types of Dashboards
- Standard dashboards display transformed data using basic functions.
- Intelligent dashboards incorporate ML outputs to enhance information presented.
- Example: Customer churn model can predict outcomes based on user-selected values.

Decision-Making with Dashboards
- Predictions indicate possible outcomes for decision-makers.
- Users can adjust parameters to influence positive outcomes.
- Increasing sales investment can lead to lower customer churn despite competitor actions.


<img src="Images/MMLP_Intel_Dashboard.png" width="500"/>

Intelligent Dashboard and Assistive Systems

- The intelligent dashboard integrates outputs from ML-derived models.
- Other types of assistive systems are available on the internet.
- Many internet services use assistive intelligence to improve user experiences.
- The variety and number of available services can be overwhelming for users.

Role of Machine Learning in Recommendations

- ML can help provide recommendations and filter irrelevant results.
- This directs user attention to more engaging selections.

Example of a Recommendation System

- A co-occurrence matrix can be used to implement a recommendation system.
- Items are categorized into groups to manage the matrix's size.
- The co-occurrence value increases when a user makes a choice.
- Future recommendations are based on the highest co-occurrence values.

Illustrative Scenario

- Example: If Simon watches Star Wars and a Star Trek movie, both categorized as Science Fiction Reboots.
- When another user watches Aliens, they receive recommendations like Star Trek, Dune, etc.
- An update to the recommendation table considers design assumptions.
- Categories are preselected; self-similarity is not allowed.
- The algorithm avoids recommending items from the same category.
- Uncertainty exists concerning how to handle selections from distinct categories, like nature.


<img src="Images/MMLP_Coconcurrence_Table.png" width="500"/>

Taking this system a step further, 
if we chose an item from the recommendation
list at random and then showed it to the user for their next movie, then we could say
that the user had delegated the choice to the system. The system becomes delegative,
which is discussed in the next section.

###  Delegative systems

Delegative Decision-Making System
- Used when users can't make case-by-case decisions
- Handles overwhelming data or requires quick decisions
- Allows human review and correction of automated decisions

Perseverance Rover
- Example of a delegative AI system
- Landed on Mars in 2021
- Investigates ancient rocks in a crater area
- Moves between rock formations to gather samples
- Scientists on Earth set objectives and control instruments
- Rover uses sensors to propose paths and sends them for approval
- Once approved, it autonomously executes the planned path

<img src="Images/MMLP_Delegative_System.png" width="500"/>

Delegative System Model for Perseverance

- Chosen for balancing communication lag from Mars and AI method risks.
- Manual control would slow rover movement, affecting scientific goals.
- Fully autonomous systems posed unacceptable risks to mission investment.
- Episodic control is one way to manage autonomy in AI.

Alternative Strategies for Managing Systems

- Independent subsystems can fail without causing major damage.
- Each subsystem can be managed individually during failures.
- Mobile phone networks exemplify partitioning strategies for delegative control.
- Cells operate autonomously but can suffer localized failures, which are reported to national centers.
- Emergency services networks have failover and quick remediation strategies in place.

Applicability of Partitioning and Recovery Strategies

- This strategy can be applied to various applications.
- Must not rely on constant availability; some failures are acceptable.
- Life-support systems may function with some elements operational during failures but require qualified personnel to manage issues.

Common Errors in Designing Delegative Systems

- Implementing fake controls for human operators is a major mistake.
- Control should revert to humans early enough to correct errors.
- Late alerts to failures can lead to disaster, as seen in life-support and aviation errors.

Risks of Fake Delegative Systems

- May result from human or organizational errors.
- Avoidance of true autonomous system challenges leads to misconceptions of safety.
- Trust in systems must come from demonstrated capability and reliability.
- Pretending a failsafe exists can endanger lives and finances, leading to tragedies.
- Discussion on requirements for ethical and effective autonomous systems will follow.

### Autonomous systems

Overview of Autonomous Systems
- Autonomous systems operate independently without human supervision for long periods.
- Example: Perseverance rover is a delegative system with human-reviewed control episodes.
- Issues like getting stuck in sand are operational errors, not failures of ML/AI planners.

Self-Driving Cars vs. Delegative Systems
- Self-driving cars are fully autonomous; users are not responsible for accidents.
- Development teams hold moral and ethical responsibility for the vehicle's performance.
- Users give strategic commands (destination) and tactical instructions (route preferences).

Requirements for Autonomous Systems
- Fully autonomous systems require stricter design and development standards than assistive systems.
- Self-driving technology has faced deployment challenges since 2007, limiting widespread use.
- Autonomous ML systems are effectively utilized in social networks for user experience management.

Social Networks as Autonomous Systems
- Algorithms in large social networks curate content for user timelines using recommender systems.
- Users perceive this as assistive, but choices regarding content are limited by the platform.
- Social networks operate autonomously, directing content without user input on visibility.

Comparing Self-Driving Cars and Social Networks
- Self-driving systems manage vehicle operation; social networks manage global information dissemination.
- Social networks rely on AI for functionality and revenue generation, contributing billions of dollars.
- Autonomous systems, while valuable, can be intrinsically dangerous due to their capabilities.

Development and Management of Autonomous Systems
- The aim is to identify mechanisms to manage risks associated with developing and deploying these systems.
- Design decisions are influenced by intent, structure, power, and significance of the application.
- A crucial priority is to establish a robust data infrastructure to support system functionality.

## Nonfunctional review

Data Analysis and Infrastructure
- The team has worked for several weeks with data, infrastructure, and users.
- A detailed view of requirements for success has been developed.

Machine Learning Models
- Models generated by machine learning are now available.
- Data movement and transformation patterns for model features are well-defined.

Requirements for Production System
- Requirements include processing time and resource allocation.
- Considerations for processing time:
- Latency: time to respond to service request.
- Throughput: number of service requests completed in a certain timeframe.

Training Pipelines Review
- A longer list of requirements must be reviewed for reimplementation and migration.

<img src="Images/MMLP_Nonfunctional_Review.png" width="500"/>

The models and the pipelines, along with the setting for the system, are now in hand.
These are the component parts that your team will integrate into the system (however
it's going to be constructed). Now you can work out the E2E (end-to-end) performance
expectations. You can then determine if you will hit the targets that you're
shooting for.

## Implementing the production system

This section serves to assist you when implementing your production system. As a
reminder, let's look at the sprint 3 tickets associated with this task.

<img src="Images/MMLP_Implementation_S4_3_6.png" width="500"/>



### Production data infrastructure

Production Infrastructure for Models
- Models are going into production and will be used in an application.
- Two key components of the production infrastructure:
- Data pipelines that provide application data to the models.
- Model-serving infrastructure that executes the models to produce results.

Data Sources and Processing
- Data is gathered from various sources.
- Example: Clicking a shopping basket generates:
- Click data (button clicked, time since last click, etc. ).
- Basket data (previous selections stored).
- User data and commercial context.
- Data processing transforms raw data into the expected features and formats for the model.
- This processing is similar to training and testing pipeline processes.

Data Flow Mechanism
- Data flows from stores and operational activities like user interface clicks or sensor data.
- The processed data is then passed to a running model instance.


<img src="Images/MMLP_Implementation_Flow.png" width="500"/>

Sprint 1 and Sprint 2 Overview
- Created training data pipelines.
- Managed training data through these pipelines.
- Implemented pipelines for the test environment.
- Replicated data delivery pipelines from training to test environment.

Next Steps
- Build production pipelines for feeding data into selected models.
- Note that production hardware and systems differ from development.

Challenges Ahead
- Data pipelines must now operate on production infrastructure.
- Data technology has evolved through multiple generations.
- Teams may face a variety of data sources and engines in a production context.
- Current challenge includes not having to use COBOL for data pipeline creation (Note: that was a joke that the AI summarizer did not understand).

<img src="Images/MMLP_Data_Engines.png" width="500"/>

Modern Data Access Approach
- Introduces an abstraction layer for data sources in production
- Team accesses data through an API instead of querying databases directly
- Main advantage: Decouples the system from implementation details

Benefits of Abstraction Layer
- Easier to manage future architectural changes
- Simplifies database upgrades by using a controlled API for interactions

Data Pipeline Challenges
- Need to replicate the data pipeline developed in sprint 2
- Ability to reuse much of the existing code, but changes may be necessary
- New data pipeline may introduce unexpected biases affecting model behavior

Ensuring Model Fidelity
- Use data testing systems from sprint 1 to verify the quality of data for model building
- Testing current behavior of the data pipeline is crucial for model accuracy

Considerations for Model-Serving Mechanism
- Explore the effectiveness and implementation of the model-serving mechanism in production systems

### The model server and the inference service

Inference Service Overview
- Provides optimized compute and storage for executing models
- Meets requirements for latency, scale, and cost
- Addresses challenges of running large and complex models in production

Importance of Optimization
- Large-scale ML systems may invoke models billions of times
- A 1% optimization can lead to millions of model invocations
- Systems like Google Translate and Facebook recommender have specialist teams for production services
- Teams optimize execution frameworks for scale and performance

Challenges for Organizations
- Not all organizations can afford dedicated teams for ML
- Organizations may face cash flow issues or strategic constraints
- Many must manage with existing resources despite potential benefits

Alternative Approaches
- Consider using mainstream execution engines
- Minimal customization can adapt engines to support ML functions
- Table 9. 5 provides information on various execution engines

<img src="Images/MMLP_Generic_Engines.png" width="500"/>

Options for Machine Learning Execution

- All options have tradeoffs and benefits
- Running ML in the database can impact database behavior and be expensive
- Database execution is inflexible and not updated for ML performance

Application Servers

- Application servers handle execution from web pages and apps
- Frontend devices call application servers for server-side processing
- Systems are parallel, scalable, and provide load balancing and error management
- Essential for handling requests from billions of users

SPARK-like Solutions

- Manage parallelism in memory with filesystem access for data
- Mainstream programming; many developers skilled in SPARK
- Low cost interaction with Python and R models
- Expensive for on-demand applications, not suitable for low latency needs

Kubernetes

- Provides scalable, persistent processing system
- Attractive in cloud environments as a managed service
- Can be costly for bursty workloads

Serverless Systems

- Offer scalable on-demand processing for bursty workloads
- Higher startup latency compared to persistent systems like Kubernetes
- Be cautious of pricing changes that can disrupt ML systems
- Always ensure an offramp option

Engine Designed for ML

- Interest in dedicated ML engines varies within the community
- Historically, specialized computing platforms have been outcompeted by mainstream processors
- Engines like OpenVINO and TensorFlow Serving are optimized for model execution
- Prebuilt engines have optimizations for various processor instruction sets

Production Implementation Importance

- Crucial to determine data flow and processing for models
- Users must have visibility and control over the system for it to be effective
- Good user experience (UX) is crucial and will be addressed in the next section

### User interface design 

Impact on Users
- Start with understanding the impact on people supported by the system.
- "Design Thinking" advocates for structured processes to identify usability needs.
- Example: Inappropriate hospital booking system for old, ill users led to poor design.

Case Study: Boeing 737 MAX
- Boeing 737 MAX's MCAS system aimed to assist pilots in stall situations.
- Activation light for the system was optional, leading some airlines to not include it.
- Lack of awareness caused serious incidents when the system activated during normal flight.
- Resulted in tragic accidents and significant financial losses from aircraft withdrawal and retrofitting.

Development Guidelines for AI Systems
- Saleema Amershi's guidelines (G1 to G18) focus on AI and ML model systems.
- Especially relevant for UI designers working on ML projects.
- Importance of guidelines highlighted with specific annotations for UI design.
- Notable guidelines for preventing catastrophic failures include G1, G2, G4, G5, G6, G8, G10, G14, G15, G17, and G18.
- Aim to prevent systems from making harmful decisions that impact users negatively.


<img src="Images/MMLP_AI_Design.png" width="500"/>

Guidelines for System Instruments and Controls

- G1: Make users aware of AI system management.
- Use signage and web pages for communication.

- G2: Share performance information from testing and validation.
- Explain results, highlighting carbon savings.

- G3: Avoid drastic changes to temperature and lighting during work hours.

- G4: Provide environmental and power consumption data for specific areas.

- G5: Present environmental and power data in relatable ways.
- Use comparisons to previous data and tangible benefits (e. g. , trees felled).

- G6: Account for biological factors in system performance.
- Ensure user testing includes balanced gender representation.

- G7: Establish a complaint management process.
- Inform users on whom to contact.

- G8: Prepare for system failures.
- Ensure managers and users know how to turn off the system if needed.

- G9: Offer controls for managers to adjust the system.
- Allow modifications based on user temperature complaints.

- G10: Implement a fail-safe for returning to a steady temperature.

- G11: Record system activity and make logs accessible to users.
- Provide a user-friendly way to inspect decision-making processes.

User Feedback Mechanism

- Create a feedback interface based on G1-G11.
- Allow users to provide insights and view actions taken in response.

Transparency and Model Explanation

- Transparency is essential in model selection.
- Some effective models may lack interpretability.

Example: AlphaFold 2 is complex and not easily understandable.
- Offers some visual explanations but remains opaque.

Post Hoc Explanations

- Utilize post hoc explanation mechanisms for clarity.
- Activation maps can show image parts causing high activity.

- Consider potential misinterpretations in explanations.
- Balance clarity with the value of the model's predictions.

- Responsibility lies with the team to communicate effectively and carefully.

## Logging, monitoring, management, feedback, and documentation


<img src="Images/MMLP_Support_S3_7_9.png" width="500"/>

System Administration for ML Systems

- Necessary administrative and managerial interfaces for technical support in production.
- Informative logging is essential for performance understanding and troubleshooting.
- Alarms must be generated preemptively before system failures happen.

Differences Between Software and ML Systems

- Normal software systems primarily focus on recognizing bugs; ML systems can experience functional failures due to evolving real-world conditions.
- Changes in the environment or entities can render previous ML predictions irrelevant.

Logging and Alarming

- Log all operational events: database connections, user logins, data updates, and model decisions.
- Logging frequency and retention depend on application requirements.
- Costs are associated with performance metrics calculation and log storage, needing a balance with application needs.

Alarm Management

- User interaction efficiency affects alert system performance.
- Alarm storms may lead to all alerts being ignored.
- Meaningful alerts can be lost in excessive notifications.

Management Functionalities

- The system should have control features like reboot options for troubleshooting issues.
- Providing a restart button can extend system lifespan in the field.

User Feedback Mechanism

- Enabling user feedback is crucial, especially during early deployment phases.
- Actively ask users for their opinions to ensure engagement in feedback usage.

Example Scenario: Customer Complaints Monitoring System

- Users are call center operatives with limited power to voice concerns.
- Feedback mechanism reveals issues like long response times and account timeouts.
- Investigation uncovers backend database query performance issues.

Lessons Learned

- Testing, logging, and monitoring may not always unveil production problems.
- Regular user inquiries can reveal valuable insights and lead to straightforward resolutions.

Evolution of Input in ML Systems

- The value of system inputs may change over time due to evolving circumstances.
- Monitoring these changes is vital for maintaining ML system governance.


### Model governance

Model Usage and Obsolescence
- Models may work until changes in technology or requirements make them obsolete.
- Changes in fashion, inflation, social structures, or demographics can outdated models.
- Organizations may deploy many models, requiring systematic management.

Governance Structure
- Models must be registered with a responsible person in the organization.
- Ownership of models is essential.
- Necessary materials must be available for understanding and managing models.
- Governance system should identify system owners and link artifacts for auditing and support.
- History of the production system must be documented, including:
- Implementation, changes, and reviews of the system.
- Records of problems and resolutions.
- Timeline for withdrawal and deletion of the system and records.

Model Performance Monitoring
- Model owners need to recognize when a model has failed.
- Simple checks (e. g. , classification counts) can identify issues.
- More advanced methods should log and alert on violations of established assertions.

Contingency Planning
- Businesses should have contingency plans for models failing unexpectedly.

Considerations include:
- Using aggregate predictions as temporary substitutes.
- Employing older, more reliable models.
- Planning for realistic downtime and debugging time for model fixes.

Future Considerations
- Proper arrangements should be in place pre-production to avoid future complications.


### Documentation


Documentation Overview
- A significant amount of documentation should have been produced during the project.
- Additional essential documents are necessary for maintaining the system.

Types of Documents Needed
1. Production team organization chart
2. Run book
3. Technical overview
4. Troubleshooting guide

Production Team Organization Chart
- Identifies system caretakers and their contact information.
- Outlines required credentials, knowledge, and training.
- Considers team structure for holidays, illness, and succession.

Run Book
- Aids first- and second-line support in troubleshooting errors and faults.
- Addresses error reporting and user communication.
- Should detail information for every possible error state, including:
- Simple fixes (e. g. , restart server).
- Escalation instructions for technical teams.

Technical Overview
- Briefs new engineers on core components and concepts.
- Links to documentation archive for further reference.
- Contains a diagram of major system components and data flows.

Troubleshooting Guide
- Encourages the team to brainstorm potential system issues and fixes.
- Focuses on documenting the machine learning (ML) component and models:
- Instructions to invoke models in isolation (files to run, data handling).
- Model retention procedures (execution steps, environment needs).
- Evaluation methods for model behavior and user value.

Effort and Benefit
- Developing these documents requires significant effort, proportional to system complexity.
- Proper documentation enhances system development and maintenance.

## Pre-release testing


<img src="Images/MMLP_Pre_Release_Testing_S3_10.png" width="500"/>

Testing Requirements for Production System

- Importance of a testing plan for deployment
- Organizations have testing standards (VV&T: verification, validation, and testing)
- Testing plan must be developed and approved by client’s IT

Types of Tests Required

- Unit Tests:
- Localized tests by developers to prove code functionality
- System Tests:
- Tests to confirm code performance; includes model and nonfunctional elements
- Integration Tests:
- Tests to ensure different system models work together, e. g. , production database and feature extraction code
- Acceptance Tests:
- Tests to verify system meets business and user purpose

Current Testing Status

- Team completed extensive unit and system testing during development
- Acceptance tests initiated through UX work in sprint 2
- Additional unit and system tests needed now
- Integration testing required for data infrastructure, UX, and model-serving components

Actions to Complete Testing

- Gather and catalog existing unit and system tests
- Formalize acceptance tests based on UX work
- Ensure production components are adequately tested
- Design and conduct integration tests for system functionality
- Get acceptance of the testing plan
- Automate preproduction tests and ensure successful runs

Final Steps

- Obtain sign-off that the team executed the test plan successfully
- Ensure agreement from the VV&T group for production readiness

Notes on ML System Testing

- Testing for ML systems differs significantly from standard software
- Focus on model performance and behavior
- Current organizational standards may be lower than needed
- Professionals need to demonstrate expertise in testing and quality while delivering a reliable product for users and clients

## Ethics review

Reviewing Ethical Aspects of the ML System

- It's not too late to check the ethics concerning the project.
- The team should ensure all issues are accounted for and gather documentation from ethical evaluations done earlier.
- Review ethical consequences of deploying the system.

Understanding Ethical Implications

- Ongoing efforts exist to understand the ethical implications and licensing of ML systems.
- The context of the system determines which ethical guidelines the team will adopt.
- Expect rapid evolution in this area; best practices must be employed to ensure the system is ethical.

Key Questions to Consider

- Is the management of the system clearly understood by accountable individuals?
- Is there a suitable governance process to manage the system's behavior and impact over time?
- Is the system's performance measured and understood in relation to its impact on users and context?
- Does the interface provide enough user information about the system's actions?
- Are control mechanisms effective and appropriate?
- Can users utilize these controls effectively to be held accountable?

User Consultation and Impact Assessment

- Have the users and impacted individuals been consulted?
- Has the team evaluated the system's impacts on those individuals?
- Does the team understand potential harm the system may cause and is this outweighed by its utility?
- Ensure there is a responsible person available to judge the system's utility in cases of harm.

## Promotion to production

<img src="Images/MMLP_Pre_Release_Testing_S3_11.png" width="500"/>

Release Preparation
- The system is ready for release, with all approvals completed.
- Schedule a release date and time.
- Release timelines can vary: DevOps may release as soon as criteria are met, while enterprises often have weekly or quarterly schedules.
- Be aware of release freezes during major events like holidays or financial reporting.

Release Process
- Run a batch file to move artifacts to production.
- Conduct post-release tests to ensure system functionality.

Team Responsibilities
1. Develop the CI/CD process for production deployment using standard tools (e. g. , Jenkins).
2. Create an automated post-release test plan for verification after deployment.
3. Execute promotion/release tasks, including testing.
4. Carry out post-release testing and confirm results.

Contingency Planning
- Prepare for potential deployment issues.
- Ensure key personnel are available and authorized to resolve last-minute problems.

## You aren't done yet

<img src="Images/MMLP_Pre_Release_Testing_S3_12.png" width="500"/>

Celebrating Success
- Celebrate when the project is in production and running
- Take the team out for lunch or hold a party
- Send a thank you note via team call or email
- Recognize the team's efforts and achievements
- Acknowledge your own contribution and success

Reflecting on the Experience
- Take time to think about the experience gained
- Recognize and retain valuable lessons learned
- Understand that there is life beyond the project

Post-Project Considerations
- Prepare for follow-up opportunities and developments
- Review post-project work in the next chapter
- Support and maintain the system in production
- Learn from the experience to improve future projects

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
