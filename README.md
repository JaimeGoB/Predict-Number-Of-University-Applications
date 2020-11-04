# Predict-Number-Of-University-Applications

Given a dataset containing information about colleges such as the number of applicants, enrolled, etc. The target is the predict the number of applicants using **Shrinkage and Dimension Reducion Methods.**


## College Dataset
- Private

A factor with levels No and Yes indicating private or public university

- Apps

Number of applications received

- Accept

Number of applications accepted

- Enroll

Number of new students enrolled

- Top10perc

Pct. new students from top 10% of H.S. class

- Top25perc

Pct. new students from top 25% of H.S. class

- F.Undergrad

Number of fulltime undergraduates

- P.Undergrad

Number of parttime undergraduates

- Outstate

Out-of-state tuition

- Room.Board

Room and board costs

- Books

Estimated book costs

- Personal

Estimated personal spending

- PhD

Pct. of faculty with Ph.D.'s

- Terminal

Pct. of faculty with terminal degree

- S.F.Ratio

Student/faculty ratio

- perc.alumni

Pct. alumni who donate

- Expend

Instructional expenditure per student

- Grad.Rate

Graduation rate

# Mean Square Error Plots 

- Ridge Regression

- Lasso Regression

- Principl Component Regression (PCR)

- Partial Least Squares (PLS)


<p float="left">
  <img src="https://github.com/JaimeGoB/Predict-Number-Of-University-Applications/blob/main/data/ridge.png" length = "450" width="450" />
  <img src="https://github.com/JaimeGoB/Predict-Number-Of-University-Applications/blob/main/data/lasso.png" length = "450" width="450" /> 
  <img src="https://github.com/JaimeGoB/Predict-Number-Of-University-Applications/blob/main/data/pcr.png"   length = "450" width="450" />
  <img src="https://github.com/JaimeGoB/Predict-Number-Of-University-Applications/blob/main/data/pls.png"   length = "450" width="450" />
</p>

# Results

Using Partial Least Squares we get a model with the lowest LOOCV test error.

<img src="https://github.com/JaimeGoB/Predict-Number-Of-University-Applications/blob/main/data/results.png"   length = "600" width="600" />

