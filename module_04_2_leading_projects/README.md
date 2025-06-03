
# Leading Projects


<img src="../Images/HLDS_Book_Cover.webp" width="200"/>


## Introduction

The text *How to Lead in Data Science*
by Jike Chong and Yue Cathy Chang
divides the features relevant to leaders in Data Science and Business Analytics 
into 6 components that comprise what they call the TEE-ERA Fan. 

<img src="Images/HLDS_TEE_ERA_Fan.png" width="750"/>

This section compiled from two chapters in this book
will guide effective leadership of an analytics project, 
which is the first step up the chain of command in the analytics profession. 


<img src="../Images/HLDS_Book_Cover.webp" width="200"/>


# Chapter 2: Capabilities for Leading Projects

This chapter covers
- Using best practices for pattern discovery and 
setting expectations for success
- Specifying, prioritizing, and planning projects from 
vague requirements
- Striking balances between complex technical 
trade-offs
- Clarifying business contexts and accounting for 
data nuances
- Navigating structural challenges in organizations


As a data science tech lead, you are expected to influence without authority by mentoring a team of data scientists and collaborating with business and engineering partners to drive projects forward.


What are these strategic capabilities for a data scientist tech lead?

- *Technology:* The tools and frameworks for you to lead projects more effectively,
which are used in framing the problem, understanding data characteristics,
innovating in feature engineering, driving clarity in modeling strategies, and
setting expectations for success.
- *Execution:* The practices for you to specify projects with vague requirements
and prioritize and plan projects, while balancing difficult trade-offs. 
- *Expert knowledge:* The domain knowledge for you to clarify project alignment to
organizational vision and mission, account for data source nuances, and navigate structural challenges in the organization.


## Technology: Tools and skills

Practicing DS involves translating business needs into quantitative frameworks and
optimization techniques, such that we can learn patterns from data and anticipate the
future. Setting up a project to learn from data has many challenges involving the following three areas: 

1. Framing the problem to maximize business impact
2. Discovering patterns in data:
  - Understanding data characteristics
  - Innovating in feature engineering
  - Clarifying the modeling strategy
3. Setting expectations for success


### Framing the problem to maximize business impact

Framing the problem can be more important than identifying the data sources. 
A powerful framing can inform what data sources are required to achieve 
the goals you set out to accomplish.


Business Challenge Overview
- Business challenges can vary in scale and scope.
- Data Science (DS) projects can have different levels of business impact.
- A DS tech lead should understand business needs to recommend impactful DS solutions.

Increasing Project Impact
- Assess the analysis type and target definition for projects.
- Key questions to consider:
- Is the analysis based on historical data or does it require real-time data?
- Are results for diagnostics only or are they expected to be predictive?

Case Study: Brian's Marketing Initiative
- Brian is involved in a marketing initiative for long-term email engagement.
- He must provide DS recommendations as the project is scoped.


<img src="Images/HLDS_Fig_2_2_Levels.png" width="750"/>



Analysis Quadrants (Figure 2. 2)
- Hindsight:
- Run A/B tests with a hold-out customer group to evaluate marketing impact.
- This method is slow and less effective for operational improvements.
- Insight:
- Create a real-time dashboard to track long-term engagement trends.
- Allow for immediate business decisions based on these insights.
- Foresight:
- Build predictive models using historical data to inform engagement strategies.
- Use short-term behavior metrics to anticipate long-term trends.
- Intelligence:
- Use real-time analytics on email channels to understand customer segments.
- Develop strategies for personalized engagement based on real-time responses.

Conclusion
- Different DS capabilities can enhance business impact from simple tests to advanced analytics.
- The distinctions can guide tech leads in prioritizing resources and setting project goals.
- Tech leads should identify gaps in problem framing and collaborate on strategies to achieve business objectives.


<img src="Images/HLDS_Fig_2_2_Levels.png" width="750"/>



### Discovering patterns in data

As a tech lead, there are various dimensions to work with data scientists on your team
to ensure the quality of the analysis or prediction, including understanding data characteristics,
innovating in feature engineering, and clarifying the modeling strategy.

#### UNDERSTANDING DATA CHARACTERISTICS

To understand data characteristics, you can articulate four aspects of data with your
teammates. As illustrated in Figure 2.3, these aspects include the unit of decisioning,
sample size/sparsity/outliers, sample distribution/imbalance, and data types.

<img src="Images/HLDS_Fig_2_3_Data_Chars.png" width="750"/>


#### UNIT OF DECISIONING



#### SAMPLE SIZE, DATA SPARSITY, AND OUTLIERS



#### SAMPLE IMBALANCE


#### DATA TYPES



#### INNOVATIONS IN FEATURE ENGINEERING

Feature Engineering

- Feature engineering helps summarize large amounts of data meaningfully.
- Simpler models like linear regression depend on feature engineering significantly.
- Complex models like deep neural networks can automate feature engineering and use raw signals as inputs.

Use Cases for Feature Engineering

- Due to small sample sizes, labeling challenges, and interpretability, simpler models with engineered features may be preferred to find patterns.

Levels of Complexity in Feature Engineering

- Features can be engineered using simple statistics:
- Counts
- Sums
- Averages
- Extremes
- Frequencies
- Differences
- Ranges
- Variances
- Percentiles
- Kurtosis
- Domain-specific interpretations can also be added:
- Business hours for specific time zones
- Normal or abnormal health signal ranges

Examples of Features in Taxonomy Analysis

- Features may include:
- Seniority levels in job titles
- Diagnosis categories in medical records
- Purchase categories in financial transactions
- Deeper interpretations can be made, such as:
- Proxy for income range
- Life stage indicators from financial transactions.

Data Relationships

- Graphs can be used to represent relationships between entities.
- Graphs show interactions, connectedness, and community formations.

<img src="Images/HLDS_Fig_2_4_Feature_Techniques.png" width="750"/>

Feature Innovation Toolkit

- Tools for feature innovation extend beyond algorithms.
- Building a feature assessment platform can enhance feature generation.
- Gamify feature extraction as a mini-competition.

Feature Assessment Platform

- Built on top of a feature store.
- Features created and shared by data scientists.
- Automatically assesses new feature effectiveness for modeling challenges (e. g. , fraud alert accuracy, recall rate).

Team Collaboration

- Data scientists develop features for specific analyses that can be used for fraud models.
- Feature assessment platforms invite contributions from data scientists, data engineering, and data analytics teams.
- Create a feature repository for sharing and utilizing features.

Encouraging Participation

- Regularly reward the highest-ranked feature on a leaderboard.
- Promote new feature submissions to enhance collaboration and innovation.
- Envision this framework as a means to drive feature innovation.

#### CLARIFYING MODELING STRATEGY

The legendary British statistician George Box once wrote, 
"All models are wrong, but some are useful." 
If this is the case, where do we start when building any of the, likely,
wrong but useful models? 
First, let's differentiate the *tactic* of what models to build versus
the *strategy* of how to start building models.

<img src="Images/HLDS_Fig_2_5_SciKit_Algos.png" width="750"/>



### Setting expectations for success

Partners may form unrealistic expectations for data science projects after hearing
machine learning use cases from social media or a marketing white paper. When
unrealistic expectations are set, even when good insights and models are delivered,
partners may not be satisfied.



<img src="Images/HLDS_Fig_2_7_Model_Confidence.png" width="750"/>


Success in recommendations is evaluated by lift, which maps to the incremental
business impact of using a model. To illustrate lift, an engagement improvement from
4% to 5% would be a 25% lift (as calculated by: 5% / 4% – 1 = 25%).


At the assistant level, 
success is assessed by the increase in human productivity in some function.
Confidence is guaranteed by the final human decision in the loop.

For models with automation, 
success is the adoption of models that can perform at human accuracy, such that we
can significantly increase the reach to serve the previously unreachable populations.

For autonomous agents, success is when human operators can overcome the leap
of faith to trust autonomous agents to correctly operate with the strategies defined
to produce the anticipated results.



## Execution: Best practices

Gartner suggested that more than 85% of DS projects fall short of expectations.
Many of the failures are caused not by the lack of technological prowess but by the
quality of the execution. There are three major stumbling blocks in project execution:
- Specifying projects from vague requirements and prioritizing them
- Planning and managing a DS project for success
- Striking a balance among hard trade-offs
Many practices to overcome these stumbling blocks are learned on the job, away from
academic institutions, fellowship programs, and online courses.

### Specifying and prioritizing projects from vague requirements

Effective data science tech leads learn to ask the question behind the question to
take personal accountability for setting up data science projects for success.

Discussion with Partners
- Explore the reasons for driving long-term user engagement.
- Identify the most valuable user engagement types for improving enterprise value.
- Define ROI expectations.

User Acquisition, Activation, and Retention
- Different stages of the user funnel have varying goals for long-term retention.
- Brian shares trade-offs to clarify goals and expectations with partner teams.

Active Users
- Focus on enhancing user experience for current active users.
- Improve interactive features, such as:
- Search convenience (e. g. , query auto-complete).
- Engagement with search results (e. g. , click-through rate).
- Relevance of search results (e. g. , dwell time).
- Keep users engaged to boost long-term engagement.

Passive Users
- Personalization recommendations for users who browse passively.
- Collect data on browsing activity, click-through rates, and dwell time for preferences.
- Share diverse topics to spark interest and curiosity, enhancing engagement.

Inactive Users
- Large numbers of inactive users require different engagement strategies.
- Personalize email outreach to improve open rates.
- Use click-through analysis for iterative email content refinement.
- Develop an email sequence to encourage re-engagement.

Prospective Users
- Target potential users not currently on the platform.
- Assess conversions from various traffic sources (SEM, partner sites, DSPs).
- Challenge: optimizing user acquisition efficiency within a limited budget and long conversion cycles.

User Cohorts Overview
- Active users are few but engaged the longest.
- Passive users have high activation potential.
- Inactive users represent the largest cohort but are difficult to re-engage.
- Engaging prospective users requires overcoming long conversion cycles.

Responsibility of a DS Tech Lead
- Collaborate with marketing and product partners for broader strategy understanding.
- Recommend technical directions to boost long-term engagement with impactful user segments.
- Ask the deeper questions behind engagement goals.


#### HOW TO PRIORITIZE

As a tech lead, here are three levels of diligence for DS project prioritization you can reference:
- Innovation and impact
- Priority refinements with RICE
- Prioritize with alignment to data strategy

#### Level 1: Innovation and impact

Evaluating Data Science Projects

- Prioritize projects that are both innovative and have high impact.
- These projects can deliver strong business ROI and inspire top data science work.

Routine Projects

- Routine projects that validate hypotheses with basic data science techniques should be prioritized for their business impact and low execution risk.
- Care should be taken to avoid team burnout from routine tasks.

Innovative but Non-Impactful Projects

- Avoid projects that are innovative but lack a clear path to business impact.
- Such projects often become time sinks with little success validation.

Routine Work and Automation

- Deprecate or automate projects that are routine with marginal impact on business operations, like data reporting.

#### Level 2: Priority refinements with RICE


You can assess the operational risks for project success by asking: What data is
available? Of what’s available, what is reliable? 
Of what’s reliable, what is statistically significant? 
Of what’s statistically significant, what is predictable? 
Of what’s predictable, what is implementable? 
Of what’s implementable, what is ROI positive? 
Of what is ROI positive, is there a business partner ready to operationalize it to create
business value?

Overview of RICE Method for Project Assessment

- RICE stands for Reach, Impact, Confidence, and Effort
- Used to refine and prioritize business-impactful projects

Reach
- Trade-offs exist in reaching specific population sizes
- Large user cohort presents challenges in targeting and converting
- Active user cohort is smaller but offers more targeting information
- Passive, inactive, and prospective users are larger but less targeted

Impact
- Business impact relates to expected improvement in key metrics
- Large reach may not lead to enough impact on long-term engagement
- Significant lift can occur within active users but affects fewer overall

Confidence
- Assess operational risks to ensure project success
- Evaluate available data for reliability, significance, predictability, and implementability
- Determine ROI positivity and readiness of business partners for operationalization
- Consider past projects to inform confidence levels

Effort
- Project success requires considerable time beyond simply building a model
- Involves multiple phases: data PoC, product PoC, iterative improvements
- Tasks include documenting findings, reviewing with partners, and A/B testing
- Effort assessment can be qualitative (size estimates) or quantitative (timeframes)

Conclusion
- Using RICE scores enables absolute prioritization of projects
- Balances risk and business impact across various projects


#### Level 3: Prioritize with alignment to data strategy

Challenges in Data Science Projects
- Many impactful data science (DS) projects involve full technology stack.
- Include data source identification, aggregation, enrichment, modeling methodologies, evaluation frameworks, and A/B testing.
- High investment required can lead to prioritization issues.
- Some components in data aggregation and enrichment may be shared across projects.

Learning and Collaboration Opportunities
- Completing one project can provide insights for other related projects.
- A data strategy can connect projects to create a cohesive roadmap.
- Projects can build on each other to enhance productivity.

Improving Return on Investment
- Common components can be utilized across multiple projects to boost ROI.
- Tech leads can work with DS executives to clarify data strategy.
- Identify opportunities to share resources and prioritize high-impact projects.

### Planning and managing a DS project for success

Project Failure Risks
- There are multiple ways a project can fail.
- As a tech lead, anticipate risks and plan to avoid them.
- Allocate resources to address issues when they arise.

Planning Insights from The Art of War
- Planning is crucial for success according to Sun Tzu.
- Careful planning answers determine project outcomes even before execution.

Types of Data Science Projects
- The common stereotype is a predictive machine learning model.
- There are nine types of data science projects.
- DS projects often involve more partners and face greater uncertainties.
- Managing DS projects is more complex compared to other technical projects.

Example of Complexity
- Personalized recommendations involve user data from various sources.
- Different teams may provide demographic info, transaction data, and online behavior.
- Understanding and aggregating input data requires collaboration across teams.
- Risks include availability and consistency of historical data over time.

<img src="Images/HLDS_Fig_2_8_DS_Project_Types.png" width="750"/>

Each of the nine types of common DS projects has specific project goals and deliverables.
They often require different granularity of efforts to complete. Table 2.1
details these goals, deliverables, and resource estimates.

<img src="Images/HLDS_Tab_2_1_DS_Project_Types_1.png" width="750"/>

<img src="Images/HLDS_Tab_2_1_DS_Project_Types_2.png" width="750"/>


As a DS tech lead, there are many common failure modes for you to anticipate. Here
are nine:
- Customer of the project is not clearly defined
- Stakeholders are not included in the decision process
- Project goals and impact are not clarified and aligned to company strategy
- Affected partners are not informed
- Value of the project is not clearly defined
- Delivery mechanism is not defined
- Metrics of success are not aligned
- Company strategy changes after project definition
- Data quality is not sufficient for the success of the project


Zeroing in on planning, the purpose of a project plan is to address these failure
modes to the best of the team’s abilities to avoid wasted efforts. Especially for large
and complex projects, a project plan also serves to align understanding with partner
teams to coordinate and commit resources toward executing the company strategy.


 Here is a sample template of a project plan:
1. Project motivation
  - Background—Customers, challenges, and stakeholders
  - Strategic goal alignment—Company initiative it serves, its impact, and its value
2. Problem definition
  - Outputs and inputs specification
  - Metrics of project success
3. Solution architecture
  - Technology choices
  - Feature engineering and modeling strategy
  - Configurations, tracking, and testing
4. Execution timeline
  - Phases of execution
  - Synchronization cadence
  - A/B test scheduling
5. Risks to anticipate
  - Data and technology risks
  - Organizational alignment risks


#### PROJECT MOTIVATION
- Establish a clear customer with a challenge to solve.
- Ensure the customer can assess whether the solution resolves the challenge.
- Customers may be business partners or the DS team itself.
- In larger projects, clarify company initiatives and anticipated impact for team alignment.

#### PROBLEM DEFINITION
- Define a concise output to address the customer's challenge (e. g. , transaction propensity score).
- Specify inputs like data sources, profile information, and user behavior.
- Set project success metrics, including baseline conversion rates and realistic goals.

#### SOLUTION ARCHITECTURE
- Outline technology choices for addressing challenges, including data and modeling platforms.
- Identify coordination needs with engineering and product teams for specifications and testing.
- Clarify technology dependencies to ensure project success.
- Address infrastructure risks in nascent and mature DS teams.

#### EXECUTION TIMELINE
- Components include phases of execution and synchronization cadence.
- Adjust project direction and methodologies as unknowns emerge.
- Use lean startup methodology: "build, measure, learn" cycles.
- Phase 1: Develop modeling proof of concept (PoC) to validate data and metrics.
- Phase 2: Product PoC aligns success criteria and resources for refining models and scheduling tests.
- Additional iterations may be needed for new capabilities.
- Set realistic expectations with partners to ensure efficient resource allocation.

#### RISKS TO ANTICIPATE
- Recognize sources of technical risks:
- New data source issues.
- Partner reorganization impacts.
- New feature tracking bugs.
- Existing product feature upgrades influencing metrics.
- Technology platform dependencies affecting operations.
- Use a checklist to align partners and anticipate common issues.

#### PROJECT MANAGEMENT: WATERFALL OR SCRUM?
- Factors influencing management consider team size, project uncertainty, and value demonstration.
- Choose between Waterfall (linear phases) and Scrum (agile, iterative process).
- Both methodologies can be used based on project complexity:
- Small projects (1-2 weeks) can be managed with Scrum.
- Mid-sized projects (2-4 weeks) require planning due to communication needs.
- Large projects (4-10 sprints) demand extensive planning and team synchronization.

#### SUMMARY
- Smaller projects benefit from Scrum; larger projects need detailed planning to adapt to changes and risks.

### Striking a balance among trade-offs

As a DS tech lead, effective execution of DS projects with the team requires many
trade-offs to be balanced between speed and quality, safety and accountability, and
documentation and progress.

#### BALANCING SPEED AND QUALITY

When balancing speed and quality, a tech lead must understand when to quickly
empower a business partner to make a timely business decision and when to 
practice the art of craftsmanship.


#### BALANCING SAFETY AND ACCOUNTABILITY


<img src="Images/HLDS_Tab_2_2_Failure_Post_Mortem.png" width="750"/>



#### BALANCING DOCUMENTATION AND PROGRESS

Documentation is a hard topic for DS, as it is often seen as competing with making
progress on additional projects. Many question how useful it really is for one or more
of the following reasons:
- Small teams—Most DS projects are performed by teams of one to three data scientists with good communication between team members.
- New teams—Many DS teams are new and have not experienced project hand-offs
where documentation becomes essential.
- Technical decisions—Many DS decisions are highly technical and are made within
the team without extensive reviews from business partners.
- Who's got the time—There is a significant demand on the team to tackle new projects rather than documenting existing work.
- No obvious location—Many tools (ad hoc queries, spreadsheets, slides, scripts)
are used, and there is no single obvious place to document both the code and
data.


Good documentation doesn’t have to be long and nuanced, but it does have to have
three properties: reproducibility, transferability, and discoverability.



## Expert knowledge: Deep domain understanding

How can you guide the technical direction of critical projects to align with business
goals? How do you crystalize your project plan narratives for fast project approval by
your manager? What are some fundamental data source limitations your team should
look out for? How do you tread a path through organizational constraints to drive
project success? As a DS tech lead, being observant of these distinctions and learning
to work with these opportunities, limitations, and challenges can help you lead projects to success. 


This section focuses on improving project success through the rigorous application of expert knowledge. You can infuse expert knowledge into the projects with a
CAN process: 
- Clarify the business context of opportunities or risks
- Account for domain data source nuances
- Navigate organizational structures in an industry


### Clarifying business context of opportunities

Clarifying the business context for your project team involves first interpreting the
organizational vision and mission. Vision is the desired future position of an organization. Mission defines a company’s business, its objectives, and its approach to reach those objectives.

As a DS tech lead, you should be sensitive to the way the vision and mission are
defined and check current projects for consistency, so your work and the team's work
can stay aligned with the direction intended by the executive team. Specifically, projects should be:
- Important, such that if not done, they would have a negative consequence for
the company
- Useful, such that they progress the company along with its mission 
- Worthwhile, such that they produce good ROI at low risk



### Accounting for domain data source nuances

Domain data source nuances often show up unexpectedly and can throw off project
milestones or cause complete project failures. As a tech lead, you have the responsibility to anticipate, recognize, and mitigate data biases, inaccuracies, and areas of incompleteness to achieve project success.

A bias is a systematic difference between the data collected and the populations represented. An inaccurate piece of data is one that misrepresents the fact in some ways. An incomplete piece of data is one that is not completely collected.




### Navigating organizational structure


Organizational structure is another source of uncertainty in the path toward project
success. Navigating this domain involves two skills: internally assessing the DS organization's capabilities and maturity, and externally navigating the business partners' organization structure outside the DS organization.

Internally, the DS organization’s maturity is highly dependent on data technology
platform capabilities. These capabilities can determine how fast a project team can
move to execute projects successfully. DS is also a team sport. External to the DS organization, the business partners’ organization structure determines how well the goals of the DS projects align with the mandates of business partners.


#### ASSESSING THE MATURITY OF DS ORGANIZATION

Organizational Structure and Project Success

- Organizational structure can create uncertainty in project success.
- Two key skills for navigating this uncertainty:
- Internally assess the data science (DS) organization’s capabilities and maturity.
- Externally navigate the business partners’ organization structure.

Internal Assessment

- DS organization’s maturity depends on data technology platform capabilities.
- These capabilities impact the speed of project execution.

External Navigation

- Business partners’ organization structure affects the alignment of DS project goals with business mandates.
- Importance of aligning internal and external structural elements for project success.

<img src="Images/HLDS_Fig_2_9_DS_Maturity.png" width="750"/>

Maturity Levels of a Data Science Organization

Ad hoc
- Prototyping predictive capabilities.
- No data infrastructure available.
- Low productivity due to high coordination needs.

Functional
- A few successful use cases have been launched.
- Challenges with reliability and efficiency in collaboration.

Integrated
- Efficient coordination process for launching predictive capabilities.
- Deployment across various business functions and user experiences.
- A/B testing methodology used in frontend UI and backend algorithms.

Governance
- Automatic calibration of predictive models.
- Active monitoring for data drifts.
- Consolidation of predictive capabilities into middleware.
- A/B testing applied to every product change.

Cultural
- All business lines capture opportunities in data science.
- Partner teams collaborate on high-impact use cases.
- Seamless integration with analytics and data engineering.

Role of a Data Science Tech Lead

- Can assess current maturity of the data science organization.
- Helps anticipate potential roadblocks in data science projects.
- Identifies specific data sources and processing pipelines to enhance project success.


#### NAVIGATING BUSINESS PARTNER ORGANIZATION STRUCTURE


Introduction to DS Projects in Traditional Industries
- DS projects may face deployment challenges in existing organizational structures.
- Understanding business partner operations is critical for project success.

Organizational Expert Knowledge Components
1. Understanding the traditional industries landscape.
2. Specifying business opportunities presented by DS.
3. Highlighting organizational challenges for DS to create business impact.
4. Presenting alternative paths for project success.

Pain Points and Business Opportunities
- Traditional industries have pain points independent of DS concerns.
- Recognizing these pain points aligns DS projects with business partners’ needs.
- DS can resolve industry pain points and demonstrate its impact on business.

Organizational Structure Challenges
- Traditional industries have entrenched bottlenecks difficult to resolve quickly through projects.
- Understanding these challenges is essential for forming strategies for success.

Case Study: DS in Consumer Lending
- Credit as a financial tool supports economic growth by allowing deferred payments.
- Many regions lack mature financial systems to assess creditworthiness reliably.
- DS can provide solutions for evaluating creditworthiness using smartphone data.

Business Opportunity in Lending
- Ubiquitous smartphone usage offers signals for assessing creditworthiness.
- A lending app can utilize smartphone data to evaluate loan applicants with minimal credit history.
- Fraud in lending poses significant risks, with a potential total loss if a loan is fraudulent.
- DS can analyze smartphone usage patterns to predict credit risk and fraud likelihood.

Organizational Structure Challenges in Lending
- Traditional lending businesses separate credit risk and loan operating teams by design.
- This structure aims to maintain lending standards to avoid long-term financial losses.
- DS teams often work within operational areas, limiting collaboration with credit risk teams.

Alternative Path for Success
- In one lending business, DS knowledge transfer to risk functions showed promise for significant benefits.
- Collaboration with fraud investigation teams focused on identifying fraudulent cases.
- Extensive cross-functional deep-dives revealed over 100 effective features among thousands experimented with.
- Improvements in fraud prevention saved the company over $30 million annually.
- The DS team maintained effective features for the risk team’s credit risk models while keeping departmental separation.

Conclusion
- Organizational expert knowledge is vital for recognizing deployment risks in DS projects.
- Navigating organizational challenges is essential for DS tech leads in traditional industries.



## Self-assessment and development focus

Congratulations on working through the capabilities section for becoming an effective
tech lead! This is a major undertaking in your journey to produce more significant
impact for your organization with DS!
The purpose of the tech lead capabilities self-assessment is to help you internalize
and practice the concepts by:
- Understanding your interests and leadership strengths
- Practicing one to two areas with the choose, practice, and review (CPR) process
- Developing a prioritize-practice-and-perform plan to go through more CPRs
Once you start doing this, you will have courageously taken the steps to acknowledge
your own finitude as individual human beings to discover personal limitations, recognize
strengths, and gain some clarity for the paths forward.

<img src="Images/HLDS_Tab_2_3_DS_Self_Assessment_1.png" width="750"/>

<img src="Images/HLDS_Tab_2_3_DS_Self_Assessment_2.png" width="750"/>


### Practicing with the CPR process

Leadership Development Process

- Identify leadership strengths and areas for improvement.
- Implement a CPR (Choose, Practice, Review) process with two-week check-ins.

Choose

- Select one to two skills from a predefined table to focus on.
- Example: Understand the organization’s vision and mission for better expertise.

Practice

- Apply the chosen skill in each project.
- Review the company’s vision and mission via the website.
- Clarify project direction and assess alignment with the vision and mission.

Review

- Schedule a meeting in two weeks to assess skill development.
- Evaluate if understanding has improved and decide on next steps (continue or move on).

Self-Review Template

- Skill/task: Choose a specific skill to improve.
- Date: Pick a date within the two-week period to apply the skill.
- People: List individuals to collaborate with or indicate self.
- Place: Decide on the location or context for skill application (e. g. , meeting with a manager).
- Review result: Assess performance compared to previous efforts—same, better, or worse.

Accountability

- Use self-review to monitor progress and improve tech lead capabilities.

### Developing a prioritize, practice, and perform plan

CPR Cycles and Self-Improvement
- Gain insights into technology leadership capabilities through CPR cycles
- Form a self-improvement habit by recognizing best practices
- Integrate best practices into daily work
- Create a prioritize, practice, and perform plan
- Plan helps build self-awareness and improves tech lead capabilities over time
- Use CPR self-reviews to track progress

Peer Support
- Partner with another data scientist for accountability in skill improvement
- Building competency takes time; have empathy for yourself and your partner

Levels of Competence
1. Unconsciously incompetent - unaware of lacking skills
2. Consciously incompetent - aware of skills gaps that can't be practiced yet
3. Consciously competent - make efforts to practice skills and self-assess
4. Unconsciously competent - best practices become habits

Career Path Options
- As skills improve, consider technical or managerial career paths
- For a technical path, refer to sections 4. 1, 4. 3 for milestones
- For a managerial path, follow chapters discussing team, function, and company leadership

Note for DS Tech Lead Managers
- Use technology, execution, and expertise to evaluate team members
- Topics cover aspirational expectations for coaching tech leads
- Demonstrated capabilities can make DS tech leads suitable for people management challenges

## Summary

Technologies
- Technologies are tools for framing business problems, discovering data patterns, and setting success expectations.
- In framing business problems, aim for significant impact by using hindsight, insight, and foresight, and drive customer actions with predictive intelligence.
- When discovering data patterns, understand data characteristics, innovate in feature engineering, and clarify modeling strategies aligned with domain mechanisms.
- Communicate the right confidence level with customers based on model accuracy to set success expectations.

Execution
- Execution involves practicing project success through clear specifications, prioritizing, planning, and managing projects while balancing trade-offs.
- Avoid task-oriented specifications and ask "the question behind the question" for better business results.
- Use RICE (reach, impact, confidence, effort) to assess projects, create clear project plans, and utilize waterfall or scrum techniques as needed.
- Strive for a balance between speed and quality, safety and accountability, and documentation and progress to improve long-term team productivity.

Expert Knowledge
- Expert knowledge includes domain-specific insights gained through extensive practice in data science (DS).
- Recognize business context by ensuring project alignment with organizational vision and mission.
- Understand domain-specific nuances to avoid costly failures related to data source assumptions, definitions, and inaccuracies.
- Navigate organizational structures to assess team maturity and address external challenges for successful project launches.




<img src="../Images/HLDS_Book_Cover.webp" width="200"/>


# Chapter 3: Virtues for Leading Projects

This chapter covers
- Operating in the customers' best interest as 
the standard of professional conduct in DS
- Adapting to business priorities and confidently 
imparting knowledge
- Practicing the fundamentals of scientific rigor
- Monitoring for anomalies and taking responsibility 
for creating enterprise value
- Maintaining a positive attitude with tenacity, 
curiosity, and collaboration


Overview of Successful Data Science Leadership
- Practicing ethics, rigor, and attitude is essential for success as a Data Science (DS) leader.
- Maintaining good practices helps deliver significant impact and advance in one's career.
- Neglecting these dimensions can lead to difficult situations requiring mentorship or management out.

Ethics
- Standards of conduct at work to avoid breakdowns.
- Includes aspects like data use, project execution, and teamwork.

Rigor
- Craftsmanship that builds trust in results.
- Results must be repeatable, testable, and discoverable.
- Rigor creates a strong foundation for enterprise value.

Attitude
- Moods towards workplace situations should be positive and tenacious.
- Curiosity and collaboration are key traits.
- Respect for diverse perspectives in collaborations is important.

Balance in Virtues
- Virtues should be practiced in moderation.
- Too much rigor can lead to analysis paralysis.
- Too little rigor can result in flawed conclusions and loss of trust from executives and partners.
- Recognizing extremes is important in maintaining balance.

Further Exploration
- Each dimension (ethics, rigor, attitude) should be explored in more detail.


## Ethical standards of conduct

Data and Ethics in Data Science

- Access to vast amounts of data to serve customers
- Data influences company enterprise value and may be sensitive
- Ethical standards shown in how data is handled, especially unseen

Definition of Ethics in Data Science

- Ethics represents the standard of professional conduct
- Focus is on practical standards rather than theoretical

Key Areas for Data Science Tech Leads

- Leading projects for customers' best interests
- Adapting to business priorities in a changing market
- Confident knowledge transfer to team members

Recommended Practices

- Avoid unnecessary breakdowns
- Improve communication skills to build trust (example: Jennifer from chapter 1, case 3)
- Foster a positive, agile, and productive work environment

### Operating in the customers' best interest

Access to Sensitive Data
- Data practitioners often work with sensitive information
- Ridesharing industry examples:
- Access to riders' transaction records
- Insight into riders’ daily routines and activities
- Online dating industry examples:
- Building couple-matching algorithms
- Running A/B tests with emotional impact

Ethical Considerations
- Two aspects of being ethical:
- Asking questions with sensitivity and empathy for customers’ well-being
- Avoiding questions one would not want to be asked themselves
- Running experiments with sensitivity and empathy for customers’ well-being
- Avoiding experiments that might harm customers’ emotional well-being

#### INSENSITIVE USE OF DS


The tech lead is the first line of defense guarding a company against unethical data
science practices. An internal ethical compass can help you call off an analysis direction that could be seen as insensitive to the customer's well-being.


#### IMPACT ON CUSTOMERS’ EMOTIONAL WELL-BEING

Questionable Ethics in Data Science

- The 2012 “Uberdata: The Ride of Glory” blog is an example of unethical DS use.
- An Uber employee analyzed passenger rides that suggested one-night stands.
- Analysis was rigorous, and no personal data was shared, but it was in bad taste.
- This analysis damaged trust between Uber and its riders.
- The incident reflected a 2012 culture at Uber that tolerated insensitivity in data practices.

Role of Tech Leads

- Tech leads play a crucial role in preventing unethical DS practices.
- An internal ethical compass is essential for guiding analysis away from harmful directions.

New York Times Rule

- The New York Times rule helps evaluate sensitivity in analyses.
- It suggests avoiding actions you wouldn’t want publicly reported.
- If the “Ride of Glory” author applied this rule, they may have reconsidered the analysis topic.

Long-term User Experience

- Some analyses can pass the New York Times rule despite short-term negative impacts.
- Examples include adjusting ad placements for better future profitability or studying web page load times for long-term engagement benefits.

### Adapting to business priorities in dynamic business environments

Business Project Changes

- Business priorities can change quickly.
- As a DS tech lead, focus on adapting to project changes.
- Team members must prioritize executing the organization's business needs.
- Many DS projects can take 8-20 weeks to complete.
- Tech leads help teams adjust to urgent projects.

Four Concerns for Tech Leads

- Discern the changes that require attention.
- Understand the reasons behind a change.
- Communicate with team members and stakeholders.
- Document current progress and move on.

- Figure 3. 1 illustrates these four concerns.
- Further sections will explore each concern in detail.

<img src="Images/HLDS_Fig_3_1_Communication_Steps.png" width="750"/>


#### DISCERNING THE CHANGES THAT REQUIRE ATTENTION

Change Management in Data Science Projects

- Changes are common during a Data Science (DS) project.
- As a tech lead, it is vital to keep the team and partners informed of changes.
- Partners rely on project milestones outlined in the project plan.

Communication Strategy

- All partners in the project stakeholder list should be included in communications.
- Stakeholder list is located in the project motivation background section (see section 2. 2).

Examples of Changes

- Metrics of Success:
- Changes in project motivation may affect the engineering part.
- A shift in metrics from short-term to long-term engagement may alter computation frequency and complexity.

- Input Specifications:
- Changes may occur in data type, format, and frequency due to documentation errors or upgrades.
- Important to communicate changes to avoid impacts on user experience, privacy, and compliance.

- Output Specifications:
- Changes may arise in data type, format, accuracy, or frequency due to limitations or requirement changes.
- Timely communication is crucial to manage downstream dependencies.

- Technology Choices:
- Changes can result from system limitations, updates, or resource availability alterations.
- Implications on output specifications must be clearly communicated.

- Feature Stability or Strength:
- Changes may indicate underlying issues or market trends requiring prompt communication.

- Resource Availability:
- Timely updates on changes can help partner teams adjust schedules and resource needs.

- Scheduling Changes:
- Inform partners about internal or external scheduling changes to allow adjustments or reassess priorities.

Importance of Timely Communication

- Essential for building trust and keeping projects on track.
- Priorities may shift due to changes in management, project timelines, or the business environment.

Case Study Reference

- Jennifer is a tech lead noted for her strong communication skills and managing project scope effectively.
- Next steps on enhancing communication within her team will be explored.

#### Understanding the reasons behind a change

Understanding Change

- Changes in management may require learning about the new manager's style and experiences.
- Talk to the new manager and those who have worked with them for information.
- As a tech lead, this helps anticipate new demands.

Causes of Change

- Acceleration or delays in related projects should be investigated for root causes and broader impacts.
- Understanding secondary impacts, like A/B testing schedule contention, is important for setting new priorities.
- Changes due to business environment factors (tech innovations, policies, economic shifts, natural disasters) should be seen as opportunities for growth and foresight.

Project Decisions

- Sometimes it's best to complete the current project; discuss this with your manager to ensure it aligns with organizational interests.
- Once a business decision is made, it's critical to follow through with execution.

Communication with Team Members

- Team members rely on guidance for next steps.
- Coordinate with your manager to communicate changes effectively.
- Clear communication should cover:
- What has changed and why.
- How changes impact the project.
- A timeline outlining tasks, responsibilities, and deadlines.

#### Communicating to team members and stakeholders

Importance of Communication During Change
- Team members rely on tech leads for certainty and clarity.
- Quick communication is essential due to fast information flow.
- Misinformation can undermine trust among team members.
- It's important to inform all stakeholders, including product and engineering partners.

Evaluating Resources
- Start with evaluating necessary resources for new priorities.
- Identify potential roadblocks for effective planning.
- Aim for a feasible work plan agreed upon with your manager.

Best Practices for Communicating Changes
- Communicate changes in a timely, clear, and authoritative manner.

*One-on-One Communication*
- Engage in direct communication with product and engineering partners.
- Build trust and create a private space for feedback and brainstorming.
- Use company communication platforms for small changes.

*Coordinate a Plan of Record*
- Align on a plan of record for clear direction after the change.
- Prevent confusion within the broader team regarding next steps.

*Announce the Change*
- Provide a clear announcement with a path forward.
- Facilitate problems with a solution-ready approach.
- Stay open to questions to address any remaining concerns.

Long-Term Benefits
- Although the process may seem cumbersome, it builds trust over time.
- Helps the DS tech lead gain authority and clarity in change announcements.

#### Documenting and moving on

Project Documentation Guidelines
- Refer to project plan structure in section 2. 2. 2.
- Clearly state the project's current stage before stopping.
- Document solution architecture, current learnings, and risks mitigated.
- Ensure comments in partially developed code accurately reflect progress.
- Include high-level placeholders for remaining modules.
- Avoid mismatched documentation (comments and code).

Good Documentation Characteristics
- Reproducible: Consistent results with the same input and methods.
- Transferable: Learnings applicable in multiple contexts.
- Discoverable: Results should appear in relevant searches later.

Updating Tickets
- Clear documentation aids in updating project tickets.
- Helps team transition to new priorities effectively.

Jennifer's Communication Improvements
- Ask underlying questions from business partners initiating project changes.
- Communicate changes and context clearly and timely.
- Document current work and proceed.
- Resulting practices enhance experiences for Jennifer and her team.

### Imparting knowledge confidently

There is significant learning generated in pursuing a DS project 
beyond the deliverables for its customers. 
For example, learning can come from the *data sources* examined,
the *tools* used, the *assumptions* made, and the *methodologies* developed, as
illustrated in figure 3.2.


<img src="Images/HLDS_Fig_3_2_Knowledge_Types.png" width="750"/>


As a tech lead, you are responsible for ensuring the learnings from the team are captured and disseminated as much as possible, so the team’s experience and 
expertise can accumulate and grow over time.



## Rigor cultivation, higher standards

Trust is precious to build for all DS work. Much of the trust in data and modeling
comes from the rigor with which data scientists treat the subject. Partners expect your
work to be scientifically rigorous, and the responsibility of holding up that bar of rigor
is in your hands.
Rigor manifests in the way you work with technology, execution, and expert
knowledge:
- Technology—The foundation of scientific methodology, on which DS stands.
- Execution—Rigor in deploying and maintaining data platforms and systems.
- Expert knowledge—Responsibilities you take on to create enterprise value.

Yes, these are the capabilities examined in chapter 2, as rigor manifests in the same
way you work with capabilities. Now, let’s explore these in the context of rigor one
at a time.

### Getting clarity on the fundamentals of scientific rigor




The rigor of the scientific methods is less frequently taught. Some may argue that
rigor needs to be practiced rather than taught.


You should be sensitive to these background differences and gently guide data scientists in the five scientific rigor principles when the background is missing. This way,
you can uphold the following five standards of rigor in data scientist projects to maintain customer and partner trust in your projects:
- Redundancy in experimental design
- Sound statistical analysis
- Recognizing error
- Avoiding logical traps
- Intellectual honesty


#### REDUNDANCY IN EXPERIMENTAL DESIGN

Good Experimental Design

- Define clear hypotheses before conducting experiments.
- Validate results with controlled online experiments.
- Use two randomly selected sample populations with a single differing feature.
- Randomization ensures samples are representative of the total population.
- Experimental setup must allow for repetition and analysis across various dimensions.

Flexible Setup Requirements

- Test across different time horizons.
- Consider various geographical regions.
- Target different operating platforms.
- Aim for replication, generalization, and sensitivity checks for trustworthy results.

Case Study: Microsoft Bing

- A 2012 test improved ad display, increasing revenue by 12%.
- Change generated over $100M additional revenue in the US annually.
- Over 10,000 experiments occur on Bing each year; significant improvements are rare.
- Experiment replicated multiple times to ensure trustworthiness and validation.

Limitations of Controlled Experiments

- Controlled experiments show potential business impact but not causal mechanisms.
- Tech leads must interpret mechanisms with product and engineering teams.
- New hypotheses can arise from these interpretations for further experiment design.

Enhancing Rigor and Validity

- Experimental confirmations of new hypotheses add assurance to original findings.
- Example: refinements in ad context based on previous learnings.
- Test perturbations in setup to assess sensitivity to system environment variables (e. g. , font colors, algorithm relevance, page loading time).

<img src="Images/HLDS_Fig_3_3_AB_Tests.png" width="750"/>


#### SOUND STATISTICAL ANALYSIS

Prerequisite Skills
- Good command of probabilities and statistics is essential for data scientists.
- Skills and best practices vary in application across different work aspects.

Careful Examination of Data
- Data scientists often examine statistical properties of input data.

T-Test Considerations
- T-tests are used to determine statistical significance in experiments.
- Important nuances to consider when using t-tests:
- Two-sample t-test assumes normal distribution of the variable.
- Central limit theorem is needed for subsampled means to ensure normal distribution.

Additional Principles
- Three more principles of scientific rigor remain to be discussed.
- Suggestion for a quick break if needed.

#### RECOGNIZING ERROR

Measurement Errors
- Measurements have errors from the surrounding world.
- Errors are divided into two types: systematic and random.

Systematic Errors (Biases)
- Caused by factors like:
- Platform bugs
- Flawed experiment design
- Unrepresentative samples (specific demographics)

Random Errors
- Occur during the sampling process in experiments.
- In controlled online experiments, random errors can be quantified as test power.
- Power is the probability of detecting a difference when there is one.
- The industry standard for test power is 80-95%.

Role of Tech Leads
- Tech leads must recognize systematic and random error sources.
- They help assess the trustworthiness of experimental results.

#### AVOIDING LOGICAL TRAPS



Logical Traps in Experimental Science

- There are many logical traps and fallacies in experimental science.
- Over 175 cognitive biases exist.
- Three common logical traps are discussed: confirmation bias, denying the antecedent, and base rate fallacy.

Confirmation Bias

- Influenced by personal desire and beliefs.
- People believe what they want to be true, often due to wishful thinking.
- Individuals stop gathering information once it confirms their preferred belief.
- To counteract, rigorously pose null hypotheses and disprove them.
- Gather enough experimental evidence to reject the null hypothesis (typically with 95% confidence).

Denying the Antecedent

- Confuses if–then with if-and-only-if–then relationships.
- Example of a flawed conclusion:
- Running implies being alive; sleeping implies not running; therefore, sleeping people are dead (incorrect logic).
- Caution needed in making similar conclusions regarding algorithms and engagement.

Base Rate Fallacy

- Occurs when high accuracy classification is used in low incidence populations.
- Difficult for untrained humans to understand probabilities and likelihoods.
- Medical example: Rapid influenza diagnostic test (RIDT) with 70% sensitivity and 95% specificity.
- In a university with 10,000 students, with 1 in 100 infected:
- Test’s perceived accuracy would be 12. 4%, not between 70% and 95%.
- Tests are not recommended for everyone, only for those with symptoms or high infection risk.

Importance for Tech Leads

- Common fallacies can be detected in project design and findings reviews.
- Tech leads must be aware of these logical traps.
- Helps teams navigate these biases in evaluating results and iterating on experiments.


<img src="Images/HLDS_Tab_3_1_Base_Rate_Fallacy.png" width="750"/>


“Even the most careful experimental approach is not rigorous if the interpretation
relies on a logical fallacy or is intellectually dishonest.” - Casadevall and Fang


#### INTELLECTUAL HONESTY

Intellectual Honesty
- Acknowledgment of details that do not fit one's hypothesis
- Nagging details can lead to new understanding and better hypotheses
- Includes recognition of earlier work and reconciling observations with others

Responsibilities of a DS Tech Lead
- Share observations that do not align with the hypothesis
- Give credit to all collaborators
- Cite references of earlier work

Principles of Scientific Rigor
- Scientific rigor is complex and multifaceted
- No single principle can define rigor alone
- Interpretation must avoid logical fallacies and maintain intellectual honesty
- Principles of rigor can work together for better results
- Logical approaches and error awareness can enhance experimental design


##  Attitude of positivity


DS is a field with high failure rates. It is common to expect 70% of the experiments
not to show positive results. In well-optimized domains like Bing, Google, and
Netflix, success happens about 10–20% of the time. It takes an immense
amount of curiosity and tenacity to stay upbeat and focused on staying the course to
deliver project wins. 

How do we maintain positivity in the midst of adversity, celebrate the successes,
and learn from the failures, while building trust with partners to execute toward the
major business wins? There are three aspects to emphasize:
- Positivity and tenacity to work through failures
- Curiosity and collaboration in responding to incidents
- Respecting diverse perspectives in lateral collaborations


### Exhibiting positivity and tenacity to work through failures

You may have come across idealized stories like this: a data wizard hacks together a
solution using off-the-shelf ML algorithms and, in a few days or weeks, saves an organiation millions of dollars a year! Well, the reality is very different from the hype in the media. 

What does reality look like? Winston Churchill once said, “Success consists of
going from failure to failure without loss of enthusiasm.” 

The idealized DS wins are but one of nine different types of projects you can take on. 
As shown in the following list, only two of the nine types of projects introduced in section 2.2 have direct DS-driven business impact. 
The purpose of most DS projects is building tracking and data foundations, servicing technical debts, and/or supporting daily business operations:
- Tracking specification definition
- Monitoring and rollout
- Metrics definition and dashboarding
- Data insights and deep dives (direct DS-driven business impact)
- Modeling and API development (direct DS-driven business impact)
- Data enrichment
- Data consistency
- Infrastructure improvements
- Regulatory items



### Being curious and collaborative in responding to incidents

An incident is defined as an outage or significant degradation of a business service. 
In a fast-moving business and technology environment, incidents are quite inevitable. 
The potential negative impact of incidents tends to increase as the number of customers
grows. The team can come under significant pressure when something breaks unexpectedly. 
It is crucial for you, the tech lead, to maintain a safe and respectful atmosphere in these stressful situations.


<img src="Images/HLDS_Fig_3_5_Incident_Management.png" width="750"/>



<img src="Images/HLDS_Tab_3_8_Post_Mortem.png" width="750"/>





### Respecting diverse perspectives in lateral collaborations


To produce business impact, data scientists need to work with business functions to
implement data science recommendations that affect revenue, cost, or profitability/
efficiency. 
Strong respect for and strong coordination with business functions are critical for the success of data science initiatives.



## Summary

Ethics
- Ethics defines conduct at work for data scientists to avoid issues.
- To act in customers' best interest, follow the New York Times rule and consider emotional impacts.
- Adjust to changing priorities by communicating clearly with teams and understanding change reasons.
- Encourage discussions on data sources, tools, assumptions, and methodologies used in projects.

Rigor
- Rigor builds trust in the repeatable and testable results of data scientists.
- Follow five principles for scientific rigor: redundancy in design, sound statistical analysis, error recognition, avoidance of logical traps, and intellectual honesty.
- Validate product tracking and understand outliers to take responsibility for data and model deployments.
- Drive enterprise value by improving business metrics, focusing on execution speed, and communicating the impact of data science work.

Attitude
- A positive and tenacious attitude is essential for data scientists, along with curiosity and collaboration.
- Promote positivity by sharing learnings regularly to motivate teams and build trust.
- Foster a safe environment for responding to incidents, encouraging curiosity, respect, and non-judgment among team members.



