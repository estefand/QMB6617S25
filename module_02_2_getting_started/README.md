
# Team Design, Infrastructure, and Data Collection


## Introduction




<img src="../Images/MMLP_Book_Cover.webp" width="200"/>

# Chapter 4: Getting Started

This chapter covers
- Focusing on preparation at the start of
engagement
- Getting all the required accesses and
permissions
- De-risking the project
- Verifying the development environment and
putting mitigations in place if needed


## Sprint 0 backlog

<img src="Images/MMLP_Backlog.png" width="500"/>


## Finalize team design and resourcing

<img src="Images/MMLP_Setup_1_Team.png" width="500"/>


## A way of working


<img src="Images/MMLP_Setup_2_Team.png" width="500"/>



### Process and structure




### Heartbeat and communication plan


### Tooling

Establish a clear agreement with all team members and with the customer about preferred tools. Often, the project's customer will mandate these. The following lists some 
of these tools:
-	Document repository (SharePoint, Confluence, Microsoft Teams, etc.)
-	Work ticketing system (Jira, GitLab, Azure DevOps Services)
-	Source code control (GitHub, Bitbucket, Subversion)
-	Document production (Microsoft Office 365, Google Docs, Open Office)
-	Technical diagram production (Visio, Lucidchart)
-	Build management system (Gradle, Jenkins)
-	Dependency management system (Conda, Python's pip)
-	Testing (Python’s pytest, JUnit)





#### Data pipelining

<img src="Images/MMLP_DAG.png" width="500"/>



#### Versioning



#### Data testing



### Standards and practices



### Documentation




## Infrastructure plan


<img src="Images/MMLP_Setup_3_Infrastructure.png" width="500"/>


### System access


### Technical infrastructure evaluation




## The data story


<img src="Images/MMLP_Setup_4_Data.png" width="500"/>



"To consult the statistician after an experiment is finished is often merely to ask him to 
conduct a post-mortem examination. He can perhaps say what the experiment died of." 

-- R.A. Fisher, Presidential Address to the 
First Indian Statistical Congress, 1938






Even so, there are (at least) four ways that the 
story of the data you will use affects your ML models:
-	Motivation and context: Why the data was collected.
-	Collection: The mechanics of the data collection and the measurements made.
-	Lineage: The process that has brought the data into its current form and storage.
-	Events: What happened to the data


### Data collection motivation


###  Data collection mechanism


###  Lineage


###  Events


## Privacy, security, and an ethics plan


<img src="Images/MMLP_Setup_5_Ethics.png" width="500"/>



## Project roadmap


<img src="Images/MMLP_Setup_6_Roadmap.png" width="500"/>



## Sprint 0 checklist

You can complete the checklist in Table 4.2 with the delivery team to ensure that the 
elements of sprint 0 are put in to place before the project starts. The objective of sprint 
0 is to ensure that the conditions for the team to work effectively and efficiently are 
met. Everyone involved in the checklist meeting should be invested in making sure 
that every item is covered usefully.


<img src="Images/MMLP_Setup_Checklist.png" width="500"/>



## Summary
- Administrative processes need to be started early, before the people that need to
use the systems or get into buildings are billing the project. Actually, doing the
work to determine what needs to be asked for is a good first step, asking for it all
is a great second step.
- You need to make sure that the customer understands what is going to be delivered,
and how and when it is to be delivered.
- Ensure that lines of communication are open, and everyone knows how they are
expected to share and get information.
- Your team needs to have a shared understanding of how it will get work done.
- Check that the development environment you need can be set up and is operational
for all team members.
- Make sure that there is an understood path to production.
- Delve into the life story of the data that your team will be using.




<img src="../Images/BCDS_Book_Cover.jpg" width="200"/>

# Chapter 12: Working with Stakeholders

This chapter covers
- Working with different types of stakeholders
- Engaging with people outside the data science 
team
- Listening so that your work gets best used

It seems like the job of a data scientist would be primarily about data, but much of
the work revolves around people. Data scientists spend hours listening to people in
their company talk about the problems they have and how data might solve those
problems. Data scientists have to present their work to people so they can use the
knowledge gained from an analysis or trust a machine learning model. And when
problems occur, such as projects being delayed or data not being available, it
requires conversations with people to figure out what the next step should be.

## Types of stakeholders


Each stakeholder you may encounter during a data science project has their own
background and motivation. Although a stakeholder can be pretty much anyone,
depending on how weird your project is, most stakeholders fall into one of four categories:
business, engineering, leadership, and your manager (figure 12.1).

<img src="Images/BCDS_Stakeholder_Types.png" width="500"/>



### Business stakeholders

Business Stakeholders Overview
- Business stakeholders oversee business decisions.
- They request analyses and machine learning models for better decision-making and efficiency.
- Stakeholders come from diverse backgrounds, including marketing and customer care.
- Examples of backgrounds:
- Marketer with an MBA from an ad agency.
- Customer care manager starting as a care agent with a community-college degree.

Technical Background of Stakeholders
- Most stakeholders have little technical expertise.
- Skills may include basic proficiency in Microsoft Excel.
- Few stakeholders know R or Python or advanced machine learning concepts.
- They understand the importance of data science despite their lack of technical knowledge.

Involvement in Data Science Projects
- Stakeholders are crucial for data science projects from start to finish.
- They help define project objectives and provide feedback on results.
- Their involvement ensures that the business gains value from data science efforts.

Job of Data Scientists
- Data scientists must deliver analyses, dashboards, or machine learning models to stakeholders.
- Clear communication is essential; complex statistics need explanation for better understanding.
- Building trust as a business partner is vital for enabling stakeholder engagement with data.

Addressing Stakeholder Concerns
- Stakeholder skepticism can arise if they question data science results.
- Responses like "Oh, that can’t be right” can lead to exclusion of data scientists.
- To address concerns, involve stakeholders in understanding methods and assumptions used in analyses.
- Discussions can improve understanding and trust in data findings.

### Engineering stakeholders

Role of Engineering Teams
- Responsible for maintaining code and products.
- Become stakeholders when machine learning algorithms or data science analyses are needed.

Collaboration with Data Scientists
- Engineers share cultural and educational similarities with data scientists.
- They have technical backgrounds from school, bootcamps, or online courses.
- Engineers are not accustomed to the exploratory aspects of data science.
- Collaborate on projects where machine learning is integrated into engineering work, typically converting models to APIs.

Expectations from Data Scientists
- Engineers rely on data scientists for reliable products with clear inputs and outputs.
- Data scientists must understand engineers' needs to deliver effective solutions.
- Data scientists conduct analyses to prioritize features, diagnose bugs, and assess product performance.

Challenges with Engineer Stakeholders
- Uncertainty in data science work causes difficulties.
- Unlike software development, data science lacks clear initial expectations.
- Unknowns include necessary data, potential outputs, and model feasibility.
- Engineers may be surprised by the ambiguity and lack of early promises from data scientists.

Communication Strategies
- Data scientists should communicate the processes clearly and frequently.
- Involving engineers in the data science workflow can reduce surprises.
- Timely updates about ambiguities help engineers manage their expectations.

### Corporate leadership

Background of Executives and Data Scientists
- Executives come from business or engineering backgrounds.
- They have greater spheres of influence within the company.
- Executives rely on data for decision-making, often seeking insights from data scientists.
- Data scientists may be accountable for machine learning projects.

Challenges in Communication
- Corporate leaders are very busy with limited time.
- They prefer direct and concise information to understand implications quickly.
- Gaining time with executives can be difficult due to their schedules.

Collaboration with Executives
- Data scientists work with executives for major decisions or deeper understanding of company aspects.
- Sometimes, work is refined as it rises through organizational levels.
- Executives may request specific analyses or reports that need to be easily understood.

Organizational Variations
- Depending on organizational size and culture, data sharing practices may vary.
- In larger firms, multiple reviews ensure results align with objectives.
- In smaller or relaxed environments, data scientists can work directly for leaders.

Expectations for Quality and Clarity
- Work must be clean, clear, and error-free at all times.
- Presentations that are unclear or incomplete can create issues.
- If executives struggle to understand the data, they may question its reliability.

Impacts of Successful Collaboration
- Positive feedback from executives can enhance data scientists' credibility.
- Trust from an executive can provide data scientists with more opportunities to utilize data and machine learning throughout the organization.

### Your manager

Manager as a Stakeholder

- A manager can sometimes be a stakeholder in your project.
- They assign tasks, check on progress, and make suggestions.
- Managers want projects to succeed for these reasons:
- Their job is to help you succeed.
- Success reflects positively on them.
- Projects may align with their team goals.

Role of a Manager

- Managers should guide and mentor you throughout the project.
- It's important to discuss struggles with your manager.
- They help find the best solutions and promote your work.
- A manager integrates your work into existing processes and explores opportunities for improvement.

Dual Role of a Manager

- Managers depend on you to deliver quality work.
- They present your reports, models, and analyses to others.
- A manager is both a supporter and someone for whom you deliver work.

Communicating with Your Manager

- You can be more open and vulnerable with your manager.
- It's acceptable to share difficulties, like struggling to finish an analysis.
- Managers can offer personalized advice compared to other stakeholders.

General Communication Tips

- Treat managers like any other colleague.
- Provide clear updates and communicate regularly.
- Deliver work that can be presented well.
- When facing challenges, reach out to your manager first for support.

## Working with stakeholders

To communicate effectively with stakeholders during your data science projects, there
are four core tenets to think about:
- Understand the stakeholder's goals
- Communicate constantly
- Be consistent
- Create a relationship

The following sections go into detail on each of these tenets


### Understanding the stakeholder's goals


Understanding Stakeholder Goals

- Everyone has goals at work influenced by their job and personal traits.
- Goals can vary widely, e. g. , a lead engineer may aim for a promotion, while a senior executive may want to maintain stability before leaving.
- These goals affect how individuals behave at work and interpret situations.

Importance of Understanding Stakeholder Goals

- Understanding stakeholder goals is crucial for data scientists.
- The same analysis may be viewed differently depending on the stakeholder's perspective.
- Example: If a product manager learns their product is underperforming, their reaction could vary based on their goals.

Methods to Discover Stakeholder Goals

- Ask Directly: Inquire about what's important to the stakeholder to encourage openness.
- Ask Around: Gather insights from colleagues who have previous interactions with the stakeholder.
- Infer from Actions: Observe stakeholder reactions to understand their motivations, noting that this method can lead to mistakes.

Building a Mental Model of the Stakeholder

- Develop a mental understanding of how a stakeholder may react to different outcomes or delays.
- Anticipating reactions helps in communicating effectively.

Balancing Goals and Honesty

- Understanding a stakeholder’s motivations doesn't mean compromising personal goals.
- If there’s a conflict between your analysis and the stakeholder’s goals, prioritize truthful analysis over pleasing them.

Delivering Unwelcome News

- When delivering bad news, consider involving a manager or senior team member for support.
- They can help navigate company politics that might be challenging for a junior data scientist.

Framing Difficult Conversations

- Approach tough conversations as collaborative efforts.
- Position yourself as a partner, helping the stakeholder recognize potential opportunities despite the bad news.
- Focus on achieving a shared understanding rather than a technical discussion.

*Key Performance Indicators (KPIs)*

Key Performance Indicators (KPIs) and Objective Key Results (OKRs) are metrics that
a team or organization focuses on because they drive business value. An online retail
team, for example, may focus on orders per month as a number they want to raise.
KPIs are useful for data scientists because they provide explicit quantification of the
goals of the team. If you are able to find out a team's KPIs, you'll be able to frame
all of your analyses and other work in terms of how it affects their KPIs. If an analysis
or method does not relate to a KPI, the team probably won’t be interested.
Not every team has core KPIs, and sometimes, they are constantly changing or are
poorly defined, but if you do have a situation in which you are given KPIs, it's best
not to ignore them. They're often the easiest way to understand your stakeholder's
goals quickly.

### Communicating constantly

Communication Concerns for Data Scientists
- Data scientists often worry about communicating too much or too little.
- It's important to keep stakeholders informed to avoid misunderstandings.
- Lack of communication can lead to stakeholders feeling out of the loop.
- Regular updates help align stakeholder expectations with project realities.

Key Messages for Stakeholders
- Keep stakeholders informed about project timelines, including expected delays.
- Share project progress, discoveries, and any challenges faced.
- Update stakeholders on how work informs business decisions and future steps.
- If significant findings arise, provide recommendations for project changes.

Establishing Communication Routines
- Set up recurring meetings (weekly or biweekly) to ensure regular updates.
- Prepare for meetings with timeline updates, progress notes, and next steps.
- Directly email stakeholders as needed, especially to ask questions.
- If it's intimidating to email senior stakeholders, consult with your manager first.

Adapting Communication Strategies
- If project circumstances change, consider setting up quick meetings for immediate input.
- Proactively arrange meetings rather than waiting for others to do so.
- This approach aids in personal growth and prepares for future roles.

Tailoring Communication Based on Stakeholder Type
- Business stakeholders prefer collaborative meetings for direction.
- Engineers can provide technical answers but may also need guidance on project decisions.
- Executives typically engage only at the beginning (for goal setting) and end (for results review) of projects.

### Being consistent

Restaurant Experience
- Example of a restaurant with inconsistent food quality.
- First visit: Best fajitas ever.
- Second visit: Fajitas lacked seasoning.
- Third visit: Tasty but took over an hour to serve.
- Question: Is this a restaurant you'd want to eat at?

Importance of Consistency in Business
- Businesses thrive on delivering a consistent product.
- Data scientists act as mini-businesses within their organizations.
- Stakeholders are the customers; poor service can lead to them seeking help elsewhere.
- Standardization of work is key for delivering consistent relationships.

#### Standardizing Analyses and Reports

Structure of Analysis
- Use a consistent format: Objective, Data, Conclusions, Next Steps.
- Helps train stakeholders to read and understand materials.

Delivery of Analysis
- Use a standard file type for analyses (e. g. , PowerPoint, PDF).
- Store files in a consistent location (e. g. , Dropbox, network folder).

Style of Analysis
- Maintain visual consistency: same colors and templates.
- Bonus for using the company's colors.

Consistency in Dashboards
- Apply analysis consistency rules to dashboards.
- Keep styling and format uniform across multiple dashboards.
- Store dashboards in a shared location.

Consistency in APIs and Machine Learning Deliverables
- Consistency in design is crucial as portfolios grow.
- Input Consistency
- Standardize the data input format.

Output Consistency
- Structure output in line with the input format and team’s existing APIs.

Authentication Consistency
- Use consistent authentication methods across APIs for security.

Benefits of Standardization
- Helps stakeholders and improves personal workflow.
- Less thinking required on standardized aspects allows focus on interesting work.
- Easier to pass tasks within the data science team.
- Standardization benefits everyone involved.


## Prioritizing work

Task Management as a Data Scientist

- Data scientists must often decide on tasks to work on.
- Project managers may assign work, but data scientists should still recommend tasks.
- Tasks come from various stakeholders and can be classified into three categories:

Quick Tasks from Stakeholders
- Small, urgent requests (e. g. , creating a sales graph).
- Easy to say yes to but can distract from more important projects.
- Accumulation of these tasks complicates productive work.

Long-Term Projects
- Core responsibilities of a data scientist include:
- Building dashboards.
- Conducting long-term analyses.
- Developing models for production.
- These projects are crucial but not always urgent and can take weeks or months.

Ideas with Long-Term Benefits
- Typically more technical tasks (e. g. , creating predictive models).
- Involves work that can increase productivity (e. g. , automating lengthy manual processes).
- Not usually requested by stakeholders but seen as valuable for personal efficiency.

It’s challenging to prioritize tasks when requests come from multiple stakeholders.
- Important stakeholder requests may not align with business priorities.
- Data scientists often cannot decline stakeholder requests due to their influence on business direction.

Relationship Building as an Introvert

- Forming relationships is typically more challenging for introverts.
- The author conducted small experiments to connect with individuals:
- Formed hypotheses based on observations.
- Tested and adjusted interactions based on new information.
- Empathy towards others can improve connections.

Handling Stakeholder Requests

- Data scientists can struggle to balance fulfilling stakeholder requests and managing workload.
- Endless requests can lead to new questions, increasing work rather than reducing it.
- Key questions to consider when choosing tasks:
- Will this work have a significant impact on the company?
- Will this work involve trying something new or just repeating existing processes?



The answers to these two questions create four combinations of types of work:
- Innovative and impactful
- Not innovative but impactful
- Innovative but not impactful
- Neither innovative nor impactful

In the next few sections, we go into each of these combinations in detail.

### Both innovative and impactful work

Innovative Data Science Projects

- Many data scientists aspire to work on projects that significantly change businesses.
- Example project: Using advanced machine learning on untouched inventory data to optimize product ordering and save millions.
- Successful projects can lead to recognition in major publications like Harvard Business Review or Wired.

Requirements for Successful Projects

- Sufficient data must be available for data science methods to be effective.
- The data should contain interesting signals that models can detect.
- The business segment involved needs to be significant enough to impact the company's bottom line.
- The problem must be complex or unique, with minimal prior attempts to address it.

Project Importance

- Projects meeting these criteria generate excitement among stakeholders and data scientists.
- Stakeholders appreciate seeing clear project value.
- Data scientists enjoy experimenting with new methods and data.
- When such projects are identified, they should be supported and nurtured, as they can define a career.
- These projects are rare and often encounter obstacles to success.

### Not innovative but still impactful work

Projects in Data Science

- Not all projects are innovative; they often involve simple data analysis to persuade teams.
- Examples include proving common suspicions and launching products based on data.
- Engineering projects may redeploy existing models from one division to another.
- Streamlining time-consuming tasks is another non-innovative way to improve business.
- Although unglamorous, these projects significantly benefit the company.

Value of Data Science Work

- Helping stakeholders understand the value of data science can lead to greater buy-in.
- Increased buy-in can maintain trust during budget overruns or unsuccessful projects.

Role of Data Scientists

- The primary goal of a data scientist is to provide value to the company, not pursue personal interests.
- Tolerance for less fascinating work is a crucial skill for data scientists.
- If a job lacks interest and learning opportunities, seeking a different position is valid.
- Job satisfaction should be a consideration, but not the sole factor in prioritizing work.

###  Innovative but not impactful work


Innovative but Non-Useful Projects
- Some data science projects focus on new theoretical algorithms with low chances of practical use.
- These projects often become isolated "ivory towers," consuming significant time and resources.
- They can become costly for data science teams, yielding minimal results.
- Despite their inefficiency, these projects attract data scientists due to their interesting nature.

Project Initiation and Focus
- Projects generally start within the data science team based on methodological interest, not business needs.
- Data scientists often pursue new research papers, leading to lengthy trials on their data.
- Results may prove ineffective, and no business need for them is identified.
- Often, data scientists move on to new projects before addressing shortcomings.

Stakeholder Awareness
- Stakeholders often remain unaware of these projects and their goals.
- They might notice data scientists are busy but lack understanding of the specific work.
- Data scientists may assume completed projects will find a practical use, but if they don't appear useful, stakeholders may not perceive them as such.

Advice on Project Selection
- Avoid getting involved in projects that do not contribute to the business.
- Stay aware of how stakeholders perceive the value of your work.

###  Neither innovative nor impactful work

Ineffective Data Science Work
- Many tasks assigned to data scientists lack innovation and impact.
- Classic example: Non-automated, frequently updated reports that go unread.
- Time-consuming tasks can burden data science teams over time.

Small Requests from Executives
- Executives with a preference for data may repeatedly request charts and analyses.
- Example requests: Weekly sales charts for Europe or identifying products with order drops.
- These requests may be easy but consume significant team resources without adding value.

Challenges and Solutions
- Hard to find solutions as the situation is complex.
- Automating reports is time-consuming and may yield limited improvements.
- Refusing repeated requests from high-level stakeholders can risk the team's reputation.

Advocating for Productive Use of Time
- Data scientists should advocate for better use of their time.
- Communicate with managers and stakeholders about the value of tasks.
- Continuous discussions can help challenge the status quo.
- Consider implementing suggested improvements and showcasing them to stakeholders.


##  Concluding remarks

Working with stakeholders is a constant process throughout the course of a project.
You need to understand their needs and why they are asking for them. A project starts
due to a stakeholder request, but what they are requesting will likely change during
the project itself, and it's your responsibility to keep up with the changes. The more
you can align your project with what the stakeholder is asking for, the less likely the
project will be to fail.


Summary
- Stakeholders come in many forms, with many needs.
- Create relationships with stakeholders so that they can consistently rely on you.
- Have continuous communication, and keep stakeholders in the loop on timelines and difficulties with projects.
















