
# Exploratory Data Analysis and Initial Evaluations


## Introduction


<img src="../Images/MMLP_Book_Cover.webp" width="200"/>

# Chapter 6: EDA, Ethics, and Baseline Evaluations

This chapter covers
-	Undertaking an EDA to discover the statistical 
characteristics of data
-	Exploring unstructured data properties using 
foundational models
-	Checking the project's ethical, privacy, and 
security aspects
-	Building baseline models to get feedback about 
the potential for success
-	Providing support for estimating performance 
of more sophisticated models



Chapter 5 Summary

Data Resource Preparation
- Team learns about the work needed to prepare a data resource for modeling.
- Ability to explore data characteristics and determine feasible actions.

Structured Exploration
- Team must explore data in a structured manner.
- Investigate data using various tools.
- Document and share insights gained from the data.

Ethical Considerations
- Team needs to revisit ethical issues related to the project.
- Identifying ethical concerns prevents wasted client resources on unfeasible development.

Baseline Model Development
- Team will create baseline models to show performance levels.
- Use off-the-shelf, quick-to-implement approaches.
- Gauge potential for more complex methods and confirm their value.

## Exploratory data analysis (EDA)

Everything is in place for you to undertake the work in the S1.5 ticket from your
backlog.

<img src="Images/MMLP_EDA_report_1_5.png" width="500"/>

Data Preparation
- Narrative created about the data to be used.
- Team confirmed that data exists and meets expectations.
- System access established and data pipelining infrastructure set up.
- Credentials for accessing data sets are available.

Data Analysis
- Data can now be brought to a location for analysis.
- The state of data must be suitable for analysis.

Exploratory Data Analysis (EDA)
- EDA is the next step to create understanding of the data.
- Developed in the 1970s by John Tukey.
- Allows transition from end-to-end studies to using "found" data.
- EDA serves as a prelude to machine learning (ML) modeling.

### EDA objectives

Exploratory Data Analysis (EDA)

- EDA helps understand the statistical properties of data for Machine Learning (ML) algorithms.
- Fundamental questions in EDA:
- Do individual data examples seem reasonable?
- What is the distribution of entities in the data?
- Do aggregate statistics relate to the data's context?
- Do relationships within the data match expectations?

Key Questions in EDA

- Individual Data Examples:
- Assess if extreme examples are realistic.
- Ensure the behavior of typical customers matches expectations.

- Distribution of Entities:
- Examine if data reveals gaps or anomalies.
- Confirm that unexpected high values (e. g. , high traffic on holidays) make sense.

- Aggregate Statistics:
- Verify if total transactions correspond with total revenue.
- Check if transaction counts per calendar period seem accurate.

- Relationships in Data:
- Investigate logical relationships (e. g. , age comparisons in demographic data).
- Ensure historical revenue trends align with current data.

Approach to EDA

- Open-ended exploration is ideal, but may not be feasible on tight schedules.
- Use questions generated from data stories to guide structured EDA.

Planning EDA Activities

- List specified activities, methods, and reasoning for data examination.
- Document expected findings to maintain a record of the EDA process.
- Collaborate with the team to prioritize important investigations for efficiency.

Impact on Data Pipelines

- EDA informs the design of data pipelines created in prior chapters.
- Feedback from the EDA may require adjustments to pipeline performance.
- Validate that training data represents the target domain.

Tools for Understanding Data

- Summary Statistics:
- Reduce data to key attributes (e. g. , mean, median).

- Visualizations:
- Provide visual maps to show overall data characteristics.

- Model-Based Approaches:
- Utilize foundational models to summarize or visualize data, especially for unstructured data like images or text.



### Summarizing and describing data


Definition of Summary Statistic
- A summary statistic is a single number representing a set of numbers.
- Example: A set {1,2,3,4,5} has a mean and median of 3.
- Summary statistics, like mean weight (e. g. , 1. 5 KG), provide crucial information for decision-making.

Data Processing Methods
- Numeric data can be summarized using:
- Data frames-based processing for small data sets.
- SQL or structured query languages for larger data sets.
- Data frame tools include:
- Python's pandas
- dplyr in R
- Data-Frames. jl in Julia
- These tools offer efficient data manipulation and summarization methods.

Functions and Resources
- Data frames often include a describe() function for initial numeric data reports.
- Recommended resources:
- "Pandas Workout" by Reuven Lerner and "Pandas in Action" by Boris Paskhave for Python.
- Cran-R EDA vignette by Ryu and book by Hadley Wickham for dplyr.

SQL and Data Management
- SQL provides data frame-like functionality within database engines.
- Modern databases can handle large data sets with optimized SQL queries.
- SQL may be seen as complex but is favored by skilled engineers.

Choosing Statistics
- Selecting appropriate statistics can be challenging.
- Automated tools can generate comprehensive reports on data characteristics.


For example, 
the team member looking at the temperature_readings table might write the following query:
```
select count(*), year from temperature_readings group_by year
>(52560000, 52560000, 52560000, 525704000, 52560000)
```
The sensor readings are spread out evenly across the years, although one (525704000)
has 140,000 more readings than the others. This is not suspicious because the year in
question is a leap year, so there is an extra day. However:
```
Select count (*), month from temperature_readings group_by month
>(0,0,0,0,0,0,0,0,0,0,0,26944000)
```
This might be a problem: 
All the readings are badged as being done in December, not good. At this
point, you realize that there is a global problem with the data. Perhaps visualizing
what's going on will clarify what's really going on with it?


### Plots and visualizations

Creating Summary Statistics and Visualizations
- Summary statistics can answer specific questions about a data set.
- Visualizing data, like through scatter or ridgeline plots, offers powerful insights.
- Summary statistics can be misleading; visual descriptions help clarify data properties.

Exploding Summary Statistics
- Visualizations can enhance understanding of summary statistics.
- Example: Anscombe’s Quartet shows different data sets with identical summary values.
- Despite the same statistical measures, the underlying data properties differ significantly.
- Plotting data helps reveal discrepancies between statistical summaries and actual data relationships.

<img src="Images/MMLP_Anscombes_Quartet.png" width="500"/>

Data with Deceptive Covariant Behaviors
- Figure 6. 2 shows the tip and check size relationship at a restaurant.
- Expected outcome: checks clustered around a diagonal line indicating a linear relationship.
- Reality: significant dispersal with poor tips on mid-sized bills and variations in larger tips.

Importance in EDA Exercises
- The plot highlights the need to consider differences in dispersal for effective modeling.
- Random sampling might not yield the necessary information for algorithms.

<img src="Images/MMLP_Tips_Scatterplot.png" width="500"/>

In the smart building example, we saw that the month field for the temperature data
wasn't meaningful. Let’s plot the number of temperature readings in the day field. We
can get this out of the data with a query like:
```
select count(*), day from temperature_readings group_by day
>[1.00000000e+00 7.21986000e+06 7.21985800e+06 7.21984900e+06
7.21985200e+06 7.21985300e+06 7.21985200e+06 7.21984600e+06
7.21986200e+06 7.21985500e+06 7.21986300e+06 7.21984800e+06
7.21986100e+06 7.21986300e+06 7.21985600e+06 7.21986400e+06
7.21985300e+06 7.21985600e+06 7.21984600e+06 7.21985200e+06
7.21986200e+06 7.21985200e+06 7.21986000e+06 7.21985900e+06
7.21986400e+06 7.21985400e+06 7.21986200e+06 7.21985900e+06
7.21986200e+06 7.21986200e+06….
```
The result is a big array of large integers, so the thing to do is to rewrite the call with a
Python function and pass it to your favorite plotting library (in this case, matplotlib).
Figure 6.3 shows the result as a range from 0 to 7, but this looks a bit odd at first. You
quickly see that the Python plotting tool decided to scale the y axis by a million, so it shows
that there are 350+ day values with a bit more than 7 million readings, and the one
on the far right looks like it's got about 1,800,000 readings. A few seconds of thought
brings some good news. The day attribute is a day-of-the-year, and day 366 is February
29, which is about one-quarter of the other values because it only happened once in
the life span of the sensor network.

<img src="Images/MMLP_Sensor_Readings.png" width="500"/>

It's clear that each day of the year has (approximately) the amount of temperature data
that would be expected if the sensor's data was logged per day, and the month field was
ignored. We can also see that the distribution of data across the years is correct, so it
looks like we have data for every day over the period that the data set was collected.

Exploration of Temperature Statistics
- Examining recorded temperature statistics can reveal insights
- Taking a small random sample can yield representative statistics

Tools for Data Visualization
- SQL, pandas, and dplyr are effective for data manipulation
- These tools work well with plotting engines like matplotlib and ggplot

Visual Exploration Techniques
- Use small data subsets during exploratory data analysis (EDA)
- Plotting large datasets can overwhelm displays and processing power
- Techniques like efficient processing and binning are useful
- Consider plotting probability densities instead of individual data points

Cautions with Sampling
- Sampling can be misleading and problematic despite its simplicity
- In some cases, the entire dataset is necessary for accurate analysis
- Investigations for anomalies or data integrity may miss issues if using only small subsets

### Unstructured data

Unstructured Data and Machine Learning (ML)
- ML algorithms can process unstructured data (photos, videos, text) into useful abstract models.
- Statistical thinking isn't effective for unstructured data (e. g. , defining a median photo).
- It's useful to explore the quality of information in unstructured data resources.

Exploration of Unstructured Data
- Use pre-built or quickly developed ML to explore new unstructured data resources.
- Human perception can still systematically analyze data.
- Important properties to consider for labeled image datasets:
- Number of images per label: Are classes balanced? Any severely underrepresented labels?
- Orientation of labeled items: Certain orientations dominate in datasets.
- Image positioning: Assess capture bias based on how items appear in images.
- Environment: Check for repeated backgrounds associated with images (e. g. , tanks in snow).
- Coverage: Verify if the label set is complete, if there are unlabeled images, and check for missing labels.

Handling Unlabeled Data
- If there are no labels, ML can assist with exploratory data analysis (EDA) before solving business problems.
- Foundational models can transform data for exploration.

Foundational Models
- Companies like Facebook and Google create ML models for general domains (English text, everyday images).
- Care is needed when using these models; however, they can provide unique insights during EDA.
- Use foundational models to generate embeddings (vectors representing conceptual positions of data).

Working with Embeddings
- Select models like EfficientNet for images or BERT-derived models (e. g. , all-MiniLM-L12-v2) for text.
- Download from open-source repositories to generate embeddings (typically 768 or 1,024 floating-point numbers).
- Direct consumption of embeddings isn't useful; consider visualizing data distribution via dimensionality reduction (e. g. , t-SNE, PCA).
- Alternatively, index embeddings with FAISS or Annoy for nearest neighbor queries to extract structure from the data.


Example: texts of Shakespeare’s plays, to show
foundational model/index system to support exploration
of unstructured data. If the plays are supplied to a parser and split into sentences,
these can be fed into a model like all-MiniLM-L12-v2, where you give each sentence an
embedding:
```
array([ 8.19933936e-02, 9.97491628e-02, 6.05560839e-02, 6.95289299e-02,
4.54569124e-02, -5.78593016e-02, 2.58211885e-02, -5.37960902e-02,
1.54499486e-02, 1.98997390e-02, 3.31314690e-02, 4.48754244e-02,
-1.08558014e-02, 2.36593257e-03, -1.36038102e-03, 5.81134520e-02,
4.76119894e-04,....
= Indeed, there is Fortune too hard for Nature, when
Fortune makes Nature's natural the cutter-off of
Nature’s wit.
```
When these were indexed, we used FAISS to find the nearest neighbor in another play:
```
Nature and Fortune join'd to make thee great:
Of Nature’s gifts thou mayst with lilies boast,
And with the half-blown rose
(King John)
```
By iterating over all items in the index, we can create a matrix that shows the strength
of the links (neighborliness) between all the plays. This can be visualized as a heatmap
as in figure 6.4.

<img src="Images/MMLP_Shakespeare_Heatmap.png" width="500"/>

The heatmap may or may not provide some insight into the unstructured data. Certainly,
The Comedy of Errors looks to be distant from the other plays, and King Lear and
Othello seem to be well connected. We can apply other filters to the neighborliness
data, though. For example, we can run a filter to extract only connections that are 2 or
3 standard deviations above the mean link value. In this case, a graph like the one in
figure 6.5 can be rendered, which shows the clustering of The Hollow Crown plays on the
left and the strangeness of The Merry Wives of Windsor on the right.

<img src="Images/MMLP_Shakespeare_Links.png" width="500"/>


## Ethics checkpoint

<img src="Images/MMLP_EDA_Ethics_1_6.png" width="500"/>

Ethical Evaluation Tools in AI and ML Systems

- Deploy ethical evaluation tools to address potential issues.
- Resources available from IEEE, Ada Lovelace Institute, and Microsoft.

Impact Assessment

- Recommended tool for understanding ethical implications of AI/ML systems.
- Previous minimal understanding has improved; now better positioned to review ethical issues.

Survey Findings

- Ayling and Chapman identified a variety of ethical impact analysis tools.
- Tools vary in application stage and addressed ML ethics aspects.
- Gaps and deficiencies exist; future development and consolidation of tools is likely.

Requirements for Impact Assessment

- Include all project stakeholders, users, and impacted individuals.
- Evaluate costs versus benefits for those affected.
- Consider lifecycle of the project and the developed system.
- Determine how the system's impact will be measured over time.
- Assess the adequacy of governance mechanisms for the system.

Project Control and Risk Management

- Team retains control over the system's development and ethical impact.
- Potential for costs to exceed benefits; must be recorded and mitigated.
- Governance issues may arise, requiring attention via risk register and project backlog.

Ultimate Success Measure

- Ethical impact defines the success and value of the developed system.
- Unethical systems can become valueless and a liability.
- Importance of taking steps to avoid unethical practices and involvement in accidents.

## Baseline models and performance


Performance Evaluations in Context
- Performance evaluations should not be viewed in isolation.
- Example: A classifier may show 99% accuracy, but context is essential to determine its usefulness.
- Accuracy could be misleading if the majority class makes up 99% of the test set.

Establishing Model Performance
- It's critical to understand model performance relative to business needs.
- Comparing performance to simple models is important.
- If models do not outperform basic majority class predictions, efforts may be futile.

<img src="Images/MMLP_EDA_Baselines_1_7.png" width="500"/>

Model Development

- Rapid baseline model development is possible with small data samples.
- Simple modeling techniques like decision-tree learning or low-dimensional perceptrons can be used.
- Simple models may overfit the data or be under-specified, but that's acceptable for initial phases.
- The goal is to find indications of challenges and establish performance bottom lines.

Business Analysis Approach

- A business analysis approach to baselining contrasts expensive models with simpler classifiers.
- Example: A sophisticated model predicting customer churn must outperform a basic classifier analyzing contract expiration, household income, or monthly spending.
- Improvement must justify the project's return on investment.

Project Risks

- Projects that are only marginally better than simple systems may seem promising.
- However, they are likely to struggle or fail when moving from development to production.

## What if there are problems?

Sunny Day Story vs. Reality
- The exercise described is termed a "sunny day story. "
- The conclusion overlooks typical project issues like problems and diversions.
- Complications with customer data are expected, such as non-existent SQL endpoints or inaccessible credentials.

Common Issues Encountered
- SQL endpoints may not exist or be behind hard-to-reconfigure firewalls.
- Credentials provided may not work; admin support could be unavailable.
- Challenges can be managed with proper customer sponsorship and support.

Potential Problems with Data Resource
- Data may differ significantly from what the customer initially stated.
- Three "rainy day paths" to manage this situation:
1. Take the road to disaster: Proceed as if the data is as expected; this often leads to project failure.
2. Renegotiate project objectives: Adjust expectations based on available data and understand customer concerns to find a new route to success.
3. Stop the project: Use assumptions from the statement of work to make this decision; can be painful but necessary.

Risk Assessment and Ethical Considerations
- If ethical assessments reveal significant issues, continuing the project may be impossible.
- Identifying unsolvable problems early can prevent harm to stakeholders.
- Deciding to stop may be the most sensible option.

Focus on Project Completion
- The aim is to complete the exploratory data analysis (EDA) without major issues.
- Hopeful data should be available and understood, leading to documented constraints.
- Understanding business constraints and customer system limitations is crucial.

Next Steps in the Project
- Using identified constraints, find the right solution for the customer.
- The design and development of key models must occur next.
- The modeling team will start work in sprint 2, equipped with tools and understanding required for development.

## Pre-modeling checklist

The goal of doing this predevelopment checklist is to ensure that adequate
preparations are made, the necessary resources are in place before beginning
modeling work, everyone has consumed and understood the relevant information created
in this sprint, and any outstanding issues are addressed.

<img src="Images/MMLP_Pre_Model_Checklist.png" width="500"/>



## Summary


By undertaking EDA, it's possible to develop insight into the potential for developing models that meet the requirements of the project. 
-	We can systematically explore unstructured data as soon as the data set is available for analysis. 
-	Use graphics (plots and charts) to explore and illustrate the data features. Visual 
methods are revealing, and communicating what is discovered is important for 
people who work on the project in the future. 
-	Simple methods (counting, sizes, labels, etc.) provide some insights into unstructured data. Modern methods (embeddings, mappings, etc.) further characterizes these data sets. Explore what's possible with the current state of the art. 
-	Address ethical considerations explicitly as the data sources and types become 
clear. Remember, failing to think about this aspect of the project can waste a lot 
of money as well as compromising the team ethically. 
-	Building simple baseline models can provide validation of the potential for modelling and a way to measure progress.




