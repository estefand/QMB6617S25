
# Diving into the Problem


<img src="../Images/MMLP_Book_Cover.webp" width="200"/>

# Chapter 5: Diving into the Problem


## Introduction

This chapter covers
-	Getting and verifying access to the data 
-	Revisiting, verifying, and refining business 
understanding
-	Developing UX and model utilization concepts
-	Getting the versioning and pipelining system in 
place and working
-	Building the initial pipelines to deliver a data 
set to the team
-	Starting to build data tests to make your 
pipelines robust


In sprint 1, the team puts in place and starts using the infrastructure to support the
delivery project, then they open the data that's going to underpin the ML project.
In order to crack the data open, they will use the infrastructure (particularly the
pipelines and testing systems) that they construct.

## Sprint 1 backlog

The sprint 1 backlog provides tasks that are described in this chapter (S1.1 - S1.4)
and in chapter 6 (S1.5 - S1.7). With sprint 1, you prepare for the core ML activity of
creating and evaluating useful models using ML algorithms. The work is to dig deeper
into the data resources and develop the team's expertise and capability to use them for
modeling. You also need to build the supporting infrastructure that lifts and shifts the
data from where it's resting to where you need it.

<img src="Images/MMLP_Sprint_1_Backlog.png" width="500"/>

The first step to delivering this sprint is to deepen your (and the team's) understanding
of the data.

## Understanding the data

Your team is on board and funding is in place to work on the client's problem. In sprint
0, you acquired an overview of the data resources for the job. Now, the task at hand is
to do a rapid but systematic evaluation of the available data resources.
In this book, this task is called a data survey, but it could be called an inspection or an
overview. It's a fast, structured investigation, which produces results that you can document,
discuss, and share to build understanding and insight. Most importantly, this
creates a checkpoint for obvious problems with the data.

<img src="Images/MMLP_Data_Survey_1_1.png" width="500"/>



### The data survey

Steps to Data Investigation

- Three steps recommended for data investigation:
- Data story: Completed in chapter 4, includes recommendations and information about data resources.
- Data survey: Validates the data story and provides information about nonfunctional and system properties of data assets.
- Exploratory Data Analysis (EDA): Analyzes statistical properties of data to determine its capabilities.

Purpose of the Data Survey

- Reduces uncertainty about data resources.
- Checks assumptions made in the data story for plausibility.

Drivers for Structured Investigation

- Cost-effective in time and effort:
- Queries are easy for data engineers and run quickly.
- Later phases like EDA and modeling may require more complex and time-consuming processes.
- Allows for a comprehensive survey:
- A broad investigation prevents overlooked issues that could derail projects later.
- Enables rational decisions on where to focus deeper EDA efforts.

Initial Checks for the Data Survey

- Can all elements in the data story be identified in the system?
- If system access is unavailable, can technical support or a data catalog provide alternatives?
- Obtain record counts and file sizes for data assets.
- Ensure sizes and structures match expected values based on data life history.
- Verify oldest and newest records match customer descriptions.
- Check largest and smallest values in key columns, basic aggregates (mean, median), and data range.
- Look for changes in scale, format, or type in records before and after significant events.

Illustrative Project Example

- Managing an intelligent building:
- Integrating temperature data with sunlight, building usage, and climate for energy-saving controls.
- Necessary databases and tables should be confirmed for expected number of records and storage sizes.
- Cross-check metadata against actual data to ensure alignment.

Investigation Approach

- Conduct ad hoc queries to check if:
- Data is present and accurate.
- Data size is correct.
- Records appear as expected.
- Major issues are detected.

Types of Data in Resources

- Numerical fields: Represent measured quantities (e. g. , sizes, weights, temperatures).
- Categorical fields: Represent labels (e. g. , colors, species).
- Unstructured fields: Represent complex data (e. g. , images, text, sounds).


For example,
we can access tables in an Oracle database with the following command:

```
select table_name from all_tables;
>TABLE_NAME | OWNER |TABLESPACE_NAME
TEMPERATURE_READINGS | SYS | SYSTEM
INCIDENTS | SYS |SYSTEM
```
This command shows that there are two tables available: temperature_readings and
incidents. Temperature_readings contains numerical data so we will use this as the first
table addressed in the survey.


### Surveying numerical data

Start by 
checking that the right number of
records are in a table. 
This is done using a ```select count(*)```
statement.
```
select count(*) from temperature_readings
>262944000
```
Does the result make sense? We are looking at about five years of sensor records,
so there will be a leap year in there. The count then is 5 * 365 + 1 = 1,826 days, so
262,944,000 / 1,826 = 144,000. That’s a nice round number. If it reminds you of 1,440
(24 * 60), it's almost as if 100 sensors have reported without fail every minute for five
years of perfect 24-hour days.
This looks correct.

Next, make sure that the records are actually useful,
by using a ```select *```.

```
select * from temperature_readings limit 1
>(21,2021,September,17,00:00:10,04.3,tx,op)
```
Start by checking one record, then check enough to verify that the data makes sense.

In the query results from temperature_readings, 21 is the sensor number, followed
by the year, the month, the day, and the time of the reading: 21,2021,September,
17,00:00:10. In the example, it's unknown (by anyone) what produces the op
at the end of the results; this isn't unusual in data projects. However, what you found
should go on the project backlog as an investigation item. It might be that op means out
of parameters and indicates that the sensor is broken. Alternatively, op might mean operational,
an indicator that the sensor is functioning properly. The point is that someone
needs to check this soon.

Next, check is to see if the
dependent variables are really recorded in the data. For example:
```
select count(*) from temperature_readings as tr where
tr.temperature!="null"
>262583041
```
That means that there are 360,959 (262944000 – 262583041)null temperature
readings in the data set—about 0.13%. That's not much, but it's something that the
team needs to know.

Also, how many of the temperature readings are 0 or not? The temperatures
recorded could indeed be 0.0 degrees C, but in many data systems, (not so) smart programmers
replace “bad” readings with 0 to make their data pipelines work smoothly. A count
of 0.0 values is worth doing:
```
select count(*) from temperature_readings as tr where tr.temperature==0.0
>1890030
```
Which, again, is not an unreasonable number, overall, 360959 + 1890030 = 2250989,
so less than 0.86% of the data might be junk (however, the 0.0 values could be real!).

Survey Goals and Approach
- Simple queries may suffice to achieve goals based on table significance and available time.
- High-level assessment of tables and databases may be appropriate for less complexity.

Deep Dive Considerations
- If the work is manageable with time available, a deeper analysis may be warranted.
- Increased caution regarding data quality suggests further investigation is wise.

Recommendations for Data Checks
- Verify that data ranges crossing 0 function as expected.
- Count negative temperature readings and assess if they should exist.
- Check limits for real-world attributes like temperature (identify readings above 60 or below -35).
- Determine entity counts (e. g. , records from specific sensors, total number of sensors, records with “op” and their different values).


### Surveying categorical data

With categorical data, it's often important to know the distribution of records across
the categories. In the smart building example, there is a sensor type code, which was
seen when we ran the query:

```
select * from temperature_readings limit 1
>(21,2021,September,17,00:00:10,04.3,tx,op)
```
The unknown is op, but tx is a type of sensor. How many types of sensors are there?
The data about sensor types is categorical (manufacturer ID), so getting a sense of it
requires a slightly more complex query that first gets all the distinct sensor types from
the temperature_readings table and then counts them:
```
SELECT Count(*) FROM (SELECT DISTINCT sensor_type FROM
temperature_readings);
>7
```
The number 7 is low enough to make it worth enumerating them:
select distinct sensor_type from temperature_readings as sensors;
```
>Sensors
A1
A2
Tp
Tn
Tx
Xr
UNKNOWN
```
The appearance of UNKNOWN is an issue that we will need to investigate, including
what the different types of sensors are. At this point, however, we can stop this
line of investigation because the EDA exercise may commit significant resources to dig
further. Remember, the data survey is about establishing what's important or difficult
about the data that needs further scrutiny, not necessarily about doing that scrutiny
now.


### Surveying unstructured data 

Dealing with unstructured data in the survey is different.
Some
will be irrelevant to the models that the team develops and the applications that consume
them. The important thing is to know where they are so that they can either be
investigated and resolved or avoided.
With unstructured data, it's important to establish what useful unstructured data
resources are available and to assess their quality. In the smart building database, there
is an incidents table that needs to be included in the survey:
```
select count(*) from incidents;
>1781
```

```
select * from incidents limit 1;
>23-05-2021, CRITICAL, 360, "HVAC failure…", "affinity engineer..")
```
The query shows us that the text fields are incident_description and resolution. 
Let's gauge the quality of these:

```
select incident_description from incidents limit 5;
>"HVAC failure meant loss of cold air for floor 12 to 25",
"HVAC intermittent for several hours, users complaining",
"HVAC reported as making rattling sound",
"Loss of cold air on 5th floor, seems isolated",
"Users reporting excessive heat on 5th floor"
```
It seems that there is potentially interesting information in these snippets. It might
be hard to translate that into data because parsing out which floor the problems are
occurring in may be challenging. On the other hand, it's probably going to be easy to
relate some of these incidents to strange sensor readings.

Inspection of Records
- Inspect many records to identify rich-looking information
- Check for empty records or those containing "NULL"
- Look for indicators of useless records, like “. ” or “n/a”

Handling Unstructured Data
- Skilled analysts can extract and scan hundreds of images from a database
- Example: A selection of 100 images may contain 90 pictures of blue sky

Identifying Patterns
- Spot regularities, patterns, and oddities in unstructured data
- Ask further questions and investigate deeper into data
- Example: High number of blue sky images may indicate a database quirk

Preliminary Analysis
- Conduct thorough analyses before investing significant time and resources in modeling and evaluation activities
- Aim to provide evidence for sponsors about potential issues in the data

### Reporting and using the survey

The data survey needs to be documented and reviewed before it can be used. Table 5.2
lists as a suggestion the items that could be recorded in a survey report. Typically, there
will be many pages of uninteresting findings, reporting on the existence of tables with
the right number of records and good integrity, for example, so it's useful to attach a
cover sheet to the survey with key deltas recorded. This alerts everyone to the main
foibles that were found in the records.

<img src="Images/MMLP_Data_Survey_report.png" width="500"/>

Survey Report Benefits
- Useful for the team; saves time finding information
- Creates talking points about data properties
- Encourages additional queries for data integrity over time
- Enhances the understanding of the data resource for the project

Purpose of the Survey
- Helps determine where to focus efforts during Exploratory Data Analysis (EDA)
- Acts as a map for necessary infrastructure to address key questions before modeling
- Serves as a starting point for data testing

Identifying Data Issues
- May reveal data problems that could jeopardize the project
- Important to document issues on the risk register
- Notify the client about uncovered data issues



## Business problem refinement, UX, and application design

Moving on from the data survey, the next step in sprint 1 is to develop a deeper understanding
of the business problem. Documenting and understanding business issues
provide the information that enable the team's work on the project and data infrastructure
to be efficient, directed, and purposeful.

<img src="Images/MMLP_Business_Problem_1_2.png" width="500"/>

Understanding a Business

- Understanding a business is a challenging task that can take months or years.
- Technical teams must gradually gain a deep understanding of business demands and constraints.
- Identifying the core business problem is essential for the team’s success.
- To speed up the identification and documentation of core business issues, specific tactics are necessary.

Project Preparation

- In the pre-project phase, a project hypothesis was built.
- During sprint 0, this hypothesis was turned into a project roadmap.
- The project roadmap outlines the team’s mandate and was reviewed by the customer.
- User and model stories were created along with the project hypothesis to aid in application design.

Progress Development

- The team should leverage existing information to engage with experts and users.
- Agile practitioners emphasize that a story card signifies a promise for a conversation.
- User stories from the pre-project phase can be refined into story cards.
- Story cards detail the application concept, affected parties, and benefits for the organization.
- A typical story card contains specified contents (as shown in Table 5. 3).


<img src="Images/MMLP_Story_Card.png" width="500"/>

Documenting Organizational Aspects
- Provides context and explains the story's purpose.
- Shows that the data model work is purposeful.
- Identifies a feasible way to employ machine learning (ML) for business value.

Model Constraints
- Last three components of the story card outline model's constraints.
- Functional requirements: Model must produce valuable classifications or predictions.
- Non-functional requirements: Model needs to operate quickly, economically, and robustly.

Model Usage
- Documentation of model usage is essential.
- Without a clear point in the business process for model output, it may be useless.
- Consider potential issues that may reduce the model’s value in the process.

Gathering Information for Story Cards
- Gathering necessary info for story cards is time-consuming and challenging.
- Extra emphasis should be placed on data resources section in ML projects.
- Issues should inform survey documentation and exploratory data analysis (EDA).

Functional and Non-Functional Performance Requirements
- Required latency and responsiveness: Timeliness of predictions.
- Expected throughput: Number of cases handled per second or day.
- Mode of use: Batch mode vs. online mode operation.
- Required robustness: Allowed failure frequency of the model.
- Model accuracy: Stakeholder expectations for usefulness.
- Depth of model accuracy challenge needs attention.

Mistakes and Performance Criteria
- Tolerance for different types of mistakes varies among users.
- Understanding the consequences of mistakes is crucial.
- System performance related to business value should be assessed.
- Identify thresholds where performance improvements may be unimportant.

Story Validation and Interaction
- Each story must be validated with impacted individuals.
- Ensure story cards reflect reality and prioritize them effectively.
- Challenging demands on models can escalate project costs.
- Evaluate the importance and value of focusing on specific stories.

User Experience (UX) Concepts
- UX experts to brainstorm user interaction with the system.
- Development of wireframes and mock screens brings the concept to life.
- Engagement through UX concepts builds a shared understanding of the product.

Application Description and Stakeholder Review
- Findings can be drafted into an application description for stakeholder review.
- Joint agreement on application behavior and requirements is vital.
- Requirement validation with modeling teams crucial for risk management.
- Distinguish between accepted and rejected stories for clarity.

Agility in Project Management
- Project maintains an agile approach.
- Selected stories remain open for discussion as models evolve.
- Prioritize actionable stories for efficient investment of client resources.
- Adjust story cards as necessary when models cannot be extracted from data.

Support for Development of Data Pipelines
- Clear story sets enhance the output development process.
- Next crucial task is to create initial data pipelines.
- Data pipelines will transform raw data for modeling exploration and manipulation.

## Building data pipelines

Data Pipeline Infrastructure

- Essential for ML projects
- Provides access to clean and useful data
- Allows for rapid transformation and enrichment of data
- Increases team productivity and responsiveness
- Aids in handling unexpected challenges and failures

Task S1. 3

- Defines required actions for the data pipeline
- Focuses on delivering the pipeline to the development environment
- Requires replication and reuse for test and production data flows in sprint 1. 3

<img src="Images/MMLP_Data_Pipeline_1_3.png" width="500"/>

Data Management Complexity
- Data is distributed across various containers, databases, data marts, and warehouses.
- Managing data collection and manipulation can become overly complex.

Preparation for EDA Exercise
- Infrastructure must be built to examine and process data reliably and conveniently.
- The goal is to distill data into usable forms for training and testing models using aggregations and transformations.

Data Rebalancing and Unstructured Data
- Data needs to be rebalanced to address uneven distributions for robust ML model extraction.
- Unstructured data may require standardization and filtering for corrupted items.
- Data augmentation involves creating training examples through transformations.

Development Process Extensions
- Pipelines should be extended to support data scientists’ algorithms.
- Testing and comparing models allow for trying new manipulations to improve results.

Main Objectives for Data Resource
- Create a live, maintainable resource for working with up-to-date data and reproducing past results.
- Identify and resolve source data problems to establish a solid project foundation.
- Develop an asset reflecting the domain's reality, supported by all processing phases.

Overview of Data Engineering Process
- The process outlined aligns with familiar ETL stages, emphasizing ML project requirements.

Data Ingestion
- Data sourced from streams (like RabbitMQ or Kafka) or files (XLXS, CSV, Parquet).
- SQL queries may be used to extract data from multiple tables or databases.
- Data should be consolidated into a target infrastructure, often moving from varied environments.

Data Manipulation and Integration
- Post-ingestion, data must be manipulated and organized for model creation.
- Creating a single table is common, but intermediate tables can also facilitate access for the modeling team.
- Manipulation includes data cleaning and feature creation.

Access Control and Documentation
- Ensure appropriate access for team members using IAM frameworks.
- Set up a serving system for easy data retrieval (e. g. , SQL queries or APIs).
- Provide documentation to allow the modeling team to self-serve from the created pipelines.


<img src="Images/MMLP_Data_Pipeline.png" width="500"/>

Pitfalls in ML Projects
- Two main pitfalls can cause serious issues in ML projects
- Building a dataset from various sources can lead to statistical problems
- Not addressing data integration as an engineering problem can create technical debt
- This can complicate tasks for the team later on

Statistical Problems
- The next section will discuss statistical issues arising from integrating data from multiple sources for training ML systems

### Data fusion challenges

Data Modeling and Integration

- New practice of building data sets from multiple sources for a comprehensive data picture.
- Traditional method involved single processes (surveys or sampling) for specific purposes.
- Independent experiments aimed to reproduce or challenge past studies.
- Meta-analysis combined results of multiple studies for greater confidence.

Data Storage and Fusion

- Data sets began being stored in digital archives since the 1970s for replication and reuse; lacked computational resources for manipulation.
- Statisticians explored data fusion for recombining data.
- Current common practice of acquiring and reintegrating data to create new insights.

Potential Issues with Data Combination

- Combining data from specific parts of a population with general observations can introduce bias.
- Experiment data may control for certain variables but create bias with others.
- Utilizing data from different time periods as a single asset can hide critical time-related features.

Time-Related Biases and Distortions

- Different time periods can distort analyses due to varied snapshot collection, e. g. , retail data aggregated on different weekdays.
- Poor modeling practices may lead to significant distortions in results and failure in production.

Impact of Rare Entities

- Rare entities can distort results by appearing disproportionately or being entirely absent in datasets.
- For instance, police records often over-represent serious offenders while neglecting petty crime.

Variability in Sensor Data Quality

- Sensor data quality varies; different sensors may have different sampling frequencies or measurement scales (e. g. , temperature sampling).
- Understanding data source semantics is crucial for determining the feasibility of combining data.

Normalization and Domain Understanding

- Errors in data normalization can significantly alter derived models.
- Knowledge of the domain and potential distortion issues is essential for effective modeling.

Data Evaluation Checklist

- Ensure data entities were collected on a consistent basis.
- Look for hidden variables that could introduce distortion.
- Confirm that sensor data quality has remained consistent over time.

Judgment in Using Non-Ideal Data

- Sometimes, data that doesn't meet strict criteria can still be valuable; applying sound judgment is necessary rather than relying on chance.

### Pipeline jungles

Challenges in Data Infrastructure

- Importance of treating task S1. 3 as an engineering problem
- Risk of creating a pipeline jungle, leading to technical debt
- Pipeline jungles arise from ad hoc data transformations and aggregations
- Incremental complexity builds up unnoticed, hindering project management

Common Issues Leading to Pipeline Jungles

- Handling specialist data infrastructures for scale, speed, or data properties
- Old proprietary data warehouses may use complex binary formats
- Team may lack skills to handle proprietary tools, requiring collaboration with experts
- Specialist tools can be necessary for performance and compliance

Best Practices for Managing Data Pipelines

- Wrap specialist tools within a standard pipelining tool to ensure integration
- Avoid quick fixes for data needs; prioritize proper processes for data flow control
- Document and version pipelines as critical code investments
- Ensure pipelines are discoverable and well-known within the team

Pipeline Management and Monitoring

- Use pipeline management tools (e. g. , Apache Airflow) for discovery and identification
- Address exceptions or special cases by incorporating them into a single-step pipeline
- Instrument and test each pipeline step for monitoring purposes
- Implement reporting for success or failure of pipeline invocations
- Utilize timers or timeouts to identify slow operations or suspiciously rapid completions
- Ensure that data tests are thorough and capable of catching execution problems

### Data testing 

Importance of Data Testing

- Data testing is essential alongside pipeline tests
- Data tests can be costly and slow
- Testing might involve extensive comparisons, increasing computational expenses
- Strategic deployment of data testing is necessary to avoid high costs or pipeline slowdowns

Types of Data Testing

Tests for Duplication
- Issue of replaying data due to exfiltration problems
- Possible bugs in code or manual errors causing duplication

Tests for Volumes
- Data volumes should be predictable over time
- Establish reasonable bounds for expected data quantities

Tests for Preconditions in Input Data
- Verifies expected input to a task
- Checks for required columns, non-null data points, and statistical distributions

Tests for Postconditions
- Assesses if produced outputs meet expectations
- Ensures output reflects conditions from preconditions

Tests of Constraints from Preconditions to Postconditions
- Validates relationships between pre- and postconditions
- Checks consistency in data (e. g. , non-null relationships)

Tests of Performance
- Monitors time, memory, cost, and task invocations
- Performance can be absolute or relative to expected norms
- Failure to complete tasks can result in data corruption

Tests for Reactions to Extreme Values
- Evaluates behaviors of null, NaN, large values, small values, and zeros

## Monitoring and Alerts

- Testing infrastructure should connect to a monitoring system
- Logs and alerts for system-level failures (e. g. , database issues)
- Automated alerts enable infrastructure team to address issues quickly

## Model repository and model versioning

Task S1.4 requires the team to build the model management and versioning infrastructure.
This allows an agile, yet controlled development and deployment of the ML models
that will be developed in sprint 2.

<img src="Images/MMLP_Model_Versioning_1_4.png" width="500"/>

Model Repository Setup

- Large number of iterations needed for model development.
- Implement a model repository to manage experiments.
- Repository should record:
- Specific model created in each iteration.
- Parameters such as data and features.
- Hyperparameters, algorithms, and architecture.
- Evaluation metrics for each iteration.

Importance of Model Evolution

- Track model evolution to inform future behavior and governance.
- Document choices for accountability.
- Helps investigate system stability, failures, and blind spots.

Information to Record in Model Repository

- Identity of each model linked to specifications for testing and production.
- Evaluation results from the development process.
- Test results from model qualification and selection.
- List of technical artifacts used in model development.
- Status of the data pipeline (running or not) and related identities.
- Test results and monitoring information from data pipelines.

Commitment to Using the Model Repository

- Team must commit to using the repository.
- Early experiments and off-the-book tests should be captured.
- These early records set the context for the project.

###  Features, foundational models, and training regimes

Model Versioning System
- Provides control and automation for building, evaluating, and integrating models.
- Important for the smooth delivery of ML projects.

Project Artefacts
- Record all tools and components used by the team.
- Include editors, interpreters, compilers, libraries, and virtual machines.
- Obtain customer approval for all tools.
- Adhere to clients’ architectural compliance policies for tool validation.

Reusable Foundation Models
- New class of artifact crucial for ML projects.
- Check licensing conditions and inform the customer about used models.
- Ensure models are registered in customer repositories and catalogs.
- Use the same model version in all processes to avoid poor results.
- Implement a unique identifier for models using a hash function (e. g. , MD5).

Tools and Algorithms
- Specific libraries and tools are needed for algorithm extraction from data.
- Versioning is crucial for avoiding anomalies, such as unauthorized builds.
- Expect security checks on builds before production deployment.

Testing Builds
- Avoid licensing cost issues or lack of hardware during tests.
- Be cautious with virtual machines that modify calculations for faster testing.
- Ensure that testing components do not enter the production build to maintain system functionality.

### Overview of versioning

ML System Versioning

- ML is a rapidly evolving field; not every item can be versioned.
- Implementing systematic tests helps control versioning:
- Use checksums to verify the presence of information in artifacts.
- Use signed binaries to confirm the owner and source of artifacts.
- Sample known values from binaries and check for accuracy.

Importance of Version Control

- Managing dependencies is crucial, even if it seems excessive.
- Early problem detection and resolution are enabled.
- CI/CD processes can be implemented effectively and rapidly.
- Build management systems require correct component versions for successful production.
- Manual versioning leads to slow progress.

Data Manipulation and Exploration

- With data pipelines and model stores set up, teams can begin data exploration.
- Teams gain insights into available data for modeling.
- Preparation is done for exploratory data analysis (EDA) and model development.

Team's Preparation

- The chapter outlined the work necessary to address technical challenges.
- Focused on mapping data resources and identifying issues.
- Highlighted business insights to resolve and set up data pipelines for modeling.
- Introduction of model versioning infrastructure.


## Summary

A data survey establishes that the expected data resources exist and have a level of 
integrity that will allow the team to meaningfully work on them.
-	By developing story cards and UX prototypes, you'll generate a deeper under-standing and agreement about the direction of the project and the requirements 
on the ML modeling activity that’s at the core of the project’s hypothesis.
-	Model repositories and versioning infrastructures for all the artefacts required 
in the project development need to be established, commissioned, and adopted 
(turn them on and use them).
-	Systematically build a data pipeline infrastructure to support agile development 
of modeling later in the project. The pipeline must provide support for ingest-ing the data, transforming it for use, and providing access to it for the modeling 
team.
-	Take careful note of the motivations and approach to data gathering for the data 
resources that the project uses.
-	Establish infrastructures for data testing and data pipeline testing to provide 
assurance during model development and into production that the team is work-ing with the correct data.


