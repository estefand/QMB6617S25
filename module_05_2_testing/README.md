
# Testing and Selection


## Introduction




<img src="../Images/MMLP_Book_Cover.webp" width="200"/>

# Chapter 8: Testing and Selection

This chapter covers
-	Structuring testing environments, then 
migrating code and artifacts to them
-	Measuring the properties of models 
-	Understanding how to test ML-discovered 
models offline and online
-	Understanding how the test results can be used 
to select models
-	Using qualitative evaluation and selection and 
quantitative measures
-	Avoiding deceptive traps when evaluating your 
models 

Sprint 2 Progress
- Team designed the model based on data understanding, client challenges, and application expectations.
- Used a structured process for model development.
- Tracked progress with an experiment tracker and model repository.
- Applied common sense to reject suspicious or problematic models.

Model Evaluation
- Importance of understanding model outcomes.
- Need to evaluate competitor models for informed decisions on production and application.

Testing Process
- Systematic process for model evaluation.
- Provides data and evidence for making informed choices about models.

Selection Process
- Involves analyzing data to make deliberate, justifiable decisions about models.
- Decisions must be clear for end users, stakeholders, and regulators.

Knowledge Requirements
- Understand testing and selection processes.
- Make informed choices about project phase actions.
- Instructions to dive deeper into the subject.

## Why test and select? 

Purpose of Separate Test and Selection Process
- Evaluation builds confidence in model performance.
- Thorough evaluation is time-consuming and costly.
- Data scientists may generate many model iterations during one evaluation.
- Good candidate models are easier to create than to evaluate properly.

Challenges in Evaluation
- Requires fresh, unseen data for valid results.
- Live testing can be risky for users and costly for businesses.
- Limited tolerance for failure necessitates selective evaluations.
- Release to a test environment is critical for wider data evaluations but is slow and expensive.

Release Management
- High-performing DevOps teams run one or two releases daily.
- Data scientists can iterate models quickly unless training is computationally intensive.

Testing Practices Overview
- Each project may vary in testing practices needed.
- Some projects use offline testing while others utilize online testing.
- Model selection process may differ across projects, with some not requiring qualitative selection or calibration.

Documentation and Reproducibility
- Testing processes must be well-documented and reproducible.
- Documentation helps determine effort required and testing process selection.
- Understanding useful testing processes for projects is essential.

## Testing processes

This section describes different approaches to testing an ML model. Overall, the point
about these approaches is that test automation and a structured process will create
confidence and accountability for your models. The evidence that you generate in a
systematic way will insulate you and the team if there are downstream issues with the
models, and it will enable documentation to be created that will satisfy stakeholders
like production engineering teams, operational teams, end users, and regulators.
These are the three sprint 2 tasks for testing our models:

<img src="Images/MMLP_Model_Testing_S2_4_6.png" width="500"/>



### Offline testing

Offline Testing
- Uses a model with data collected specifically for this purpose.
- Data is divided into a training set and a test set based on availability and quality.
- Example split: 70% training data and 30% testing data.
- Training data is further divided into a training set proper and a validation or hold-out set.

Testing Phase
- Important to test models with data not seen during modeling to avoid information leakage.
- Optimizing model performance using new data can lead to better test performance.
- Selection of algorithms and processes should focus on the effectiveness with unseen test data.
- Risk of poor performance in production due to deceptive results from final testing.
- Unseen data in testing helps to avoid unconscious optimization issues.

Cross-Validation
- Alternative to simple test/training splits.
- Entire dataset is divided into several disjoint test/training sets.
- In 10-fold cross-validation, data is split into 10 sets; nine for training and one for testing.
- Example: Partitioning into eight sets, each used in various combinations for testing and training.


<img src="Images/MMLP_Cross_Validation.png" width="500"/>

Creating Models and Testing
- Use training pipelines to create models from the training set.
- Each model is tested with the relevant test set.
- For Set 1: P2, P3, P4, P5, P6, P7, P8 are training sets; P1 is the test set.
- Models’ performances are combined to generate a cross-validated score.

Cross-Validation Methods
- You can perform leave-one-out cross-validation by using one example as the test set and training on the remaining examples.
- For a dataset with 1,000 examples, you would train and evaluate 1,000 models.
- Cross-validation is suitable for simple models and small datasets.

When to Avoid Cross-Validation
- Cross-validation is computationally expensive for complex models and larger datasets.
- There is skepticism about cross-validation from some statisticians, viewing it as lacking rigor.
- It’s important to clearly communicate the method used to ensure transparency.

Challenges in Model Evaluation
- Partitioning data is crucial for reliable test outcomes in offline environments.
- Manual implementation of processes can become tedious and prone to errors.
- Evaluate many models efficiently to avoid unsustainable workloads.
- Consider investing in automated and robust testing systems for better results.

### Offline test environments

Testing Environment Setup
- Previous chapters outlined steps to create a testing environment.
- Focus now on ensuring elements are operational to advance the project.

Actions Required
1. Access the test environment; obtain necessary credentials and permissions.
2. Deploy the testing infrastructure, which includes:
- A data pipeline.
- A test harness/mock application.
- Selected models and associated artifacts.
- Data gathering and feedback collection.
3. Verify functionality of all components (e. g. , calibration/smoke test).
4. Run the pipeline to hydrate environments with required data (e. g. , initialization weights/transfer models).
5. Execute the test and collect results.

Complexities and Automation
- The process is complex, with many points for error.
- Mistakes can compromise testing integrity.
- Scripting or automating the process is common to reduce errors.

Scripting Solutions
- Simple shell scripts can be used for commands and file management.
- Using a shared scripting engine is preferable for complex environments.
- Common engines: Airflow or systems for data pipeline DAGs.
- Alternatives include GitHub Actions and Jenkins, potentially mandated by the client organization.

Environment Segregation
- Testing and QA environments are separate from development and production.
- Helps in controlled changes by the QA team.
- Important for handling sensitive or confidential data.
- Limited access to sensitive data is crucial to prevent leaks.

Testing Pipeline Scenarios
- Scenario (a): Shared testing pipeline across the team with the latest model for integration testing.
- Scenario (b): Separate testing pipeline for system engineering, using dummy data/models.
- Scenario (c): Confident test environment promotes better integration testing than scenario (b).



<img src="Images/MMLP_Prod_Flows.png" width="500"/>



### Online testing

Online Testing Overview
- An online test evaluates system performance on real-world events.
- In medicine, this is the gold standard for assessing drugs or procedures.
- Clinical trials involve patients receiving treatment to determine usefulness.
- Online testing is preferred when the application domain is rapidly changing.
- Offline testing can introduce delays, hindering effective model deployment.
- Certain domains in medicine require results to be collected in real-world settings.

Commonly Used Online Testing Processes
- Consider three commonly used online testing processes for your team.


### Field trials

Field Trials for Model Deployment
- Field trials are managed deployments of a model for a small group of users.
- Ideal locations for trials include small offices or tech-savvy departments to minimize risks.
- Main goals of field trials:
- Build confidence in the model’s behavior.
- Gather detailed information on performance.

Monitoring and Feedback
- Teams must closely monitor model behavior during trials.
- Regular checks on model usage are needed to prevent dangerous outcomes.
- Reviewing model behavior with users is essential.
- User interviews provide valuable feedback on model performance.

Advantages and Drawbacks of Field Trials
- Advantages:
- Offer insights into a model's utility.
- Drawbacks:
- Difficult to design effective trials.
- Results may not apply to larger applications.
- Field trials are costly and time-consuming, potentially delaying projects.

Alternative Testing Methods
- For projects with budget or time constraints, consider other online tests to assess model performance.

### A/B testing

A/B Testing Overview
- A/B testing involves testing a model in a constrained production scenario.
- Real cases are divided into two groups: A (model applied) and B (no model applied).
- Outcomes from group A are compared to group B, similar to clinical trials with treatment and control groups.

Advantages of A/B Testing
- It is a real-world experiment, providing fresh data about the domain.
- Strong causal information is provided, ruling out coincidence and data issues.
- Results are closely linked to the model's real characteristics.

Challenges of A/B Testing
- Limited infrastructure in business processes can hinder setup and execution.
- Technical limitations or policy restrictions may prevent the creation of the test environment.
- Ethical barriers exist when selecting subjects for testing under protocols.

Business Impact
- A/B testing might expose transactions to poor treatment outcomes.
- Businesses may hesitate to allow testing on customers, concerned about potential negative impacts.
- Ethical considerations in medicine contrast with business viewpoints on customer treatment.

Time and Cost Considerations
- A/B tests provide high-quality evaluation data but can be slow to gather insights.
- Setting up tests is expensive and difficult, and tests may take time to yield results.
- Tests may need to span business cycles to capture representative data.

Alternatives to A/B Testing
- Multi-arm bandits offer an alternative to address some challenges of traditional A/B testing.

### Multi-armed bandits (MABs)

Multi-arm Bandits (MAB) Overview
- MABs aim to be more efficient and cost-effective than A/B tests.
- Focus on testing models only when learning is likely to be useful.
- Allows interaction with users to build more effective models.
- Quickly identify unsuccessful models to limit their use in live processes.

Scenario Example
- Involves three processes being tested for rewards:
- One process frequently gives a reward.
- One process sometimes gives a reward.
- One process never gives a reward.
- Reference to Figure 8. 2 showing the machines and their payouts during testing.

<img src="Images/MMLP_One_Arm_Bandits.png" width="500"/>

Machine Performance Evaluation

- Machine C has only two payout records due to Machines A and B paying on the second pull.
- Only one machine is a dud; A and B are both performing well.
- Decision focuses on which machine, A or B, has the best payout.

Observations from Pulls

- By the fourth pull, machine B fails to pay, while machine A also fails by the fifth pull.
- Fail rates after six pulls: B has 4/6 fails, A has 2/6 fails.
- Decision made to stop investing in machine B, as machine A remains successful.

Exploration vs. Exploitation

- Important to balance exploration (trying different machines) versus exploitation (investing in the best machine).
- Need to determine which machine pays and the amount of payout.

Evaluating ML Models

- Performance information can be collected in two ways: explicitly and implicitly.

Explicit Feedback

- Example: Frequency of purchases of recommended items indicates model effectiveness directly.

Implicit Feedback

- Example: Time spent browsing a website may suggest user satisfaction or frustration, giving indirect feedback on model success.

Measuring Performance and Algorithms

- Clear measurement mechanism needed to utilize performance data.
- Various algorithms help in deciding when to abandon a model, including the epsilon family of approaches.

Epsilon Algorithm Overview

- Basic epsilon algorithm selects the best machine 90% of the time (epsilon, ε = 0. 1).
- Allows for exploration 10% of the time by picking a different machine.
- Can be refined by setting trial specifications or using decay factors for ε.
- Benefits: intuitive, computationally simple, low probability of error, cost-effective.

Differences in Evaluation Methods

- MAB tests provide strong evidence for the better model but do not quantify differences in performance rigorously.
- MABs can dynamically adapt to changing domains but do not give exact statistics.
- Testing using MABs reduces risk of information leakage and misleading results.

Conclusion on MABs

- Innovative models must show superiority to replace traditional models in a system.
- A MAB-based test evaluates model integrity and true performance against established alternatives.

### Nonfunctional testing

Nonfunctional Properties of Models
- Nonfunctional properties are important for model selection.
- Highly functional models failing nonfunctional requirements may be discarded.
- ML models may run millions of times and are often time-critical.
- Expensive or slow models can lead to high costs or user frustration.

Key Nonfunctional Properties to Test
- Testability
- Data access
- Flexibility
- Integrity
- Engineers and customers often lack knowledge about nonfunctional requirements (NFRs) for ML.
- There is a shortage of documentation, methods, and benchmarks for measuring NFRs.

Collected Nonfunctional Requirements
- Latency: Time taken for the model to return results.
- Throughput: Number of executions in a certain period.
- Cold start may slow first execution.
- Parallel hardware can increase throughput despite individual model speed.
- Memory footprint: Size of ML models affects deployment feasibility.
- Cost: Use of licensed components can increase expenses.
- Carbon impact: Some models have a significant carbon footprint.

Evaluating Nonfunctional Properties
- Memory footprint and cost are easier to evaluate.
- Latency and throughput need testing in conditions that mimic production.
- Performance can vary on different hardware; reliance on linear scaling can be risky.
- Bottlenecks downstream can stall scaling efforts, including basic issues like power supply or overheating.
- Sustained testing on real hardware is essential for reliable performance assessments.

Challenges in Measuring Carbon Footprint
- Testing carbon footprint is complex due to various components in the system.
- Code and system instrumentation can help, but components like databases and accelerators may not be covered.
- Optimizing code for low carbon intensity could result in inefficient operations elsewhere, leading to paradoxical outcomes.

Decision Making Based on Testing and Evaluation
- Information from functional and nonfunctional testing aids in model selection.
- Final decision-making based on these evaluations will be discussed in the next section.

## Model selection

<img src="Images/MMLP_Model_Selection_S2_10_12.png" width="500"/>


Testing and Evaluation of ML Models
- Testing and evaluation provide information on model performance.
- Selecting the right model requires more than a single test result now.

Complexity in Model Selection
- ML models are used in complex systems and configurations.
- A single performance metric is often inadequate for model selection.
- All performance information must be collected and synthesized.

Documentation for Stakeholders
- Stakeholders need to understand model selection choices.
- Document the appropriateness of model choices and the rationale behind them.

Information Types Available
- Results from testing episodes.
- Information about the testing mechanism and practices.
- Requirements of the system.

Decision-Making Process
- Assess model qualities based on testing results.
- Evaluate quality and informativeness of results.
- Determine the significance of each result.

Synthesis Approaches
- Two fundamental approaches for decision-making:
- Aggregate information quantitatively to identify optimal models.
- Use qualitative processes to select appropriate models.

Combination of Methods
- Likely need to utilize both quantitative and qualitative methods.
- Quantitative data can inform qualitative selections.

Importance of Documentation
- Carefully document the selection process and rationale.
- Enables transparency in model behavior when in production.
- Provides a clear answer to why a specific model was chosen.


### Quantitative selection

Quantitative selection is the process of combining the measurements from different
testing events to create a single, aggregate measure, and then choosing the model to
be used based on that measure. In this section, we'll look at three distinct scenarios
for making your choice, based on the tests that have been developed to evaluate the
models.


#### Choosing With Comparable Tests

Evaluating Models Across Multiple Countries

- Use aggregations to combine test results for model selection.
- Consider a model making offers to young adults (ages 18-25) across 40 countries.
- Generate two data sets with 40 data points each representing model success by country.

Decision-Making Process

- Calculate mean performances and standard deviations for both models.
- Assess the distance between model performances based on expectations.
- If there’s low expectation for models performing similarly, a difference exists.
- Select the model with performance that is significantly differentiated if both means are distant from each other.

Understanding Performance Overlap

- Model A may have a higher mean score, but if model B’s standard deviation includes A’s mean, no real difference might exist.
- Apply Bayesian analysis to determine if samples are from the same distribution.
- If model B frequently achieves better performance than model A, it may be superior.

Confidence in Differences

- Determine the level of surprise needed to confirm that models are different.
- A 95% confidence level is commonly used to assert differences in distribution and behaviors.

Challenges with Population Differences

- Recognize diverse populations, economies, and demographics may affect model evaluations.
- Normalization could be useful in some contexts (e. g. , e-commerce).
- Caution is needed when comparing complex data like epidemic prevalence or vaccine performance, as normalization may not be appropriate.

### Choosing with many tests

- Influence of Measurement Aggregation
- Aggregating multiple measurements can affect selection decisions.
- Different measures of performance may arise from the testing program.
- Having separate test sets for hard-but-important (hbi) examples and standard data can lead to misleading overall performance.

- Multi-Criteria Decision Making
- The problem of measuring performance is studied extensively in multi-criteria decision making.
- Various approaches exist for aggregating diverse test results; no single method is the best for all cases.
- Weighting functions can prioritize certain test results over others, allocating a percentage of the score accordingly.

- Weighting Approach Example
- In an example, a 50/50 weight distribution could be used for hbi and run-of-the-mill (rotm) items.
- Weighting hbi items as 1,000 times more significant than rotm items raises issues.
- The chosen weighting can be arbitrary and difficult to justify afterward.

- Complexity in Weighting
- More complex weighting methods can improve performance comparison but may complicate explanations.
- Approaches vary in effectiveness and often introduce uncertainty into the decision-making process.

- Alternative Method: Ranking Performance
- An alternative approach is to rank performance instead of using raw outcomes.
- Comparing models through rankings can produce clearer insights into performance.


<img src="Images/MMLP_Model_Rankings.png" width="500"/>


Model Evaluation Results
- Model D is the winner.
- Model D ranks second in the HBI test and first in the ROTM test.
- Model E ranks first in the HBI test and third in the ROTM test.
- A 50/50 weighting on model E yields 365,301 compared to 354,122 for model D.
- Despite the weighting, model E would be selected.

Ranking and Decision Making
- Ranking aggregates are not inherently better.
- Aggregated rankings help stakeholders understand results intuitively.
- More independent tests make ranking aggregates more useful.

Pareto Optimality in Model Selection
- Pareto optimality can aid in model decision-making.
- A Pareto efficient set includes models with the best outcomes under one measure.
- In case of ties, the model with better performance in other dimensions is selected.

Imaginary Model Results
- Figure 8. 3 shows results from imaginary models evaluated on HBI and ROTM.
- The area within the dotted lines is the Pareto front.
- Models in the Pareto front have the best trade-offs between HBI and ROTM.
- Model F is in the Pareto set; model G is not due to poorer performance in both tests.

<img src="Images/MMLP_Model_Pareto_Front.png" width="500"/>

We can use Pareto sets and Pareto fronts to create sets of Pareto optimal candidates
versus many different tests, not just two, yet Pareto sets still leave room for more decision
making. Creating a Pareto set narrows the candidates, but it still often leaves a
choice to be made between set members.

###  Qualitative selection measures

Introduction to Qualitative Metrics

- Model Security
- Can the model be tricked or attacked?
- Example: Small image changes can mislabel by the model.
- Implications: Potential misuse of traffic signs and passport photos.

- Privacy
- Does the model leak personal information?
- Concern: Can private data from prompts be extracted?
- Example: Feeding a prompt about an individual's medical record risks harm and breaks data protection laws.

- Fairness
- Are there biases in the model that are harmful or outdated?
- Example: Assuming all doctors are male and nurses are female can impact job seekers adversely.

- Interpretability
- Is the model's function understandable to humans?
- Can it be explained accurately and show well-founded operations?

User Stories and Development Activities

- Security, privacy, and fairness are essential requirements.
- If these are not met, models cannot be used.
- Interpretability is less clear-cut; trade-offs may exist.
- A less interpretable model may meet performance standards.

Multi-Criteria Decision Making

- Discussions on decision-making can be complex and imprecise.
- Aesthetic concerns might influence model choices, which some may view as irrational.
- Preference for simpler models aligns with the historical principle of Occam’s razor.
- Simple models are favored for performance and efficiency, such as lower size and fewer parameters.


## Post modelling checklist

To conclude this stage, 
run through the checklist in Table 8.3
and make sure that everyone agrees that everything was completed properly. If that's
the case, then you can be confident that you team has created a solid set of models and
there's a well-documented set of candidates for application integration.



<img src="Images/MMLP_Model_Selection_Checklist.png" width="500"/>

Testing Process Considerations
- Revisit the testing process if new problems arise in application integration.
- The team may need to return to sprint 1 activities to review data.
- Potential need to onboard new data sources or fix new data errors.
- Sprint 1 and sprint 2 processes provide a good framework for adjustments.
- Utilize the investment in team agility to address emerging issues.

Documentation Practices
- Do not neglect documenting changes and updates.
- Iteration and adaptation are necessary but require transparency.
- Maintain professionalism when rebuilding pipelines and processes.
- Ensure tests are rerun and documentation is kept current.



## Summary

Your test environment needs to accommodate the security and privacy requirements of the data that you are handling, allowing access to testing mechanisms 
for the right people in the team. 
-	You must deliberately decide what is important to measure about the performance of your models. Just as sometimes the fuel economy of a car is more 
important than its acceleration, it can be the case that different performance 
tests need to be evaluated for models in different contexts. 
-	Model accuracy is a poor way to understand model performance. Consider models in terms of their precision and recall performance or their F1 score. Even 
better, consider a range of performance measures to get an overall view of what 
matters about the model's performance on a particular test. 
-	Nonfunctionals need to be tested and considered as well, so you can rate the 
results of those against functional performance. 
-	You can use cross-validation to measure model performance when data is hard to 
get. Models can be tested on live cases using A/B testing or multi-armed bandits. 
You must be aware of the costs and trade-offs of testing in terms of the constraints 
that you face on gathering data or exposing people to the behavior of experimental models. 
-	Model selection is both quantitative (using the results of your tests) and qualitative (based on wider considerations and model aesthetics). 
-	Quantitative selection may require you to compare and weigh tests that are done 
on different bases. Different approaches to doing this are rankings, MCDM 
(multi-criteria decision making), and Pareto fronts. Which approach you use 
depends on your project. 
-	You can test the component parts of your models to reveal how they are failing. You can use causal theories of what the model is doing as part of your 
decision-making. 
-	When selecting models and model components, you are often left with a judgement. What’s important is that the basis of your decision is transparent, and the 
decision process is recorded and documented. If the decision comes down to 
selecting A or B, and there is no clear way for you to establish which, document 
this and pick the one that seems best to you. 





