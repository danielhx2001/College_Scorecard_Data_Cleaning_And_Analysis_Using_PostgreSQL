<html>
<h1>🎓 College Scorecard Institutional Analysis (2018–2019)</h1>
  
<body>
<h2>📌 Project Overview</h2>
<p>This project analyzes institution-level data from the U.S. Department of Education’s College Scorecard to examine how institutional characteristics—such as ownership type, selectivity, and cost of attendance—are associated with student outcomes, including graduation rates, retention rates, and early employment outcomes.

The analysis focuses specifically on four-year, bachelor’s degree–granting institutions, with the goal of producing analysis-ready datasets and interpretable insights relevant to institutional research, higher education policy, and data analytics roles.</p>

<h2>🎯 Project Goals</h2>
<p>The main objectives of the project include:<br>
<ul>
<li>Clean and prepare a large unstructured public data set for analysis using <b><em>Postgre SQL</em></b></li>
<li>Explore how <b><em>insitutional ownership</b></em> (Public, Private Non-profit, Private For-profit) relates to students outcomes(retention and graduation)</li>
<li>Find out does school <b><em>selectivity</b></em> (admission rate) have relationship with students' graduation rates and job placement rates</li>
<li>Analyze the <b><em>cost of attendance</b></em> and students outcomes such as graduation rates and job placement rates</li>
</ul>

<h2>📊 Dataset</h2>
<p>
Source: U.S. Department of Education – College Scorecard<br>
Academic Year: 2018–2019<br>
Key Variables:
<ul>
  <li>Institutional characteristics (ownership/control, degree offerings, enrollment size)</li>
  <li>Admissions selectivity (admission rate)</li>
  <li>Cost of attendance (public/private cost measures)</li>
  <li>Student outcomes:<br><ul><li>Retention Rate</li><li>Graduation Rate</li><li>Retention Rate</li><li>Employment outcomes one year after graduation</li></ul></li>
</ul>
</p>

<h2>🛠️ Data Tools Used & Concepts</h2>
<p>
<p font = "20"><em>PostgreSQL</em></p>
<ul>
  <li>Cleaned and prepared large-scale public datasets, including type conversion, standardization of missing values, and construction of analysis-ready variables using COALESCE</li>
  <li>Structured multi-step transformations with Common Table Expressions (CTEs)</li>
  <li>Applied window functions (ROW_NUMBER, PERCENTILE_CONT, NTILE) to compute percentiles, rankings, and group-level benchmarks</li>
  <li>Categorized institutions by ownership, selectivity tiers (admission rate quartiles), and cost tiers (cost of attendance quartiles) using CASE WHEN syntax</li>
  <li>Compared graduation, retention, and employment outcomes across institutional groups using multiple aggregate functions</li>
</ul>
</p>

<h2>💡Conclusions from the analysis</h2>
<p>Institution type: Public and private nonprofit schools have higher graduation and retention rates than private for-profit schools; private nonprofits are slightly higher than publics in graduation.

Selectivity: More selective institutions show higher graduation rates, but employment rates are similar across selectivity tiers (job quality/earnings not available).

Cost: Higher-cost institutions have higher graduation rates, while employment rates are relatively consistent across cost tiers.</p>
</p> 

</body>
</html>
