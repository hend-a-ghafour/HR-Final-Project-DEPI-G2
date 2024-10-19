/* Note:
	This database & its tables were created by python "HR - Final Project - DEPI.ipynb" */


Use Human_Resources

-- Altering the E_Personal_Details Table & Assigning "Emp_ID" as Primary Key:
SELECT	*
FROM	Work_Profile

-- 1- Modifying Data Types:
ALTER TABLE		Work_Profile
ALTER COLUMN	Emp_ID NVARCHAR(15) NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Position NVARCHAR(40) NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Department NVARCHAR(40) NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Salary MONEY NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Salary_Level NVARCHAR(20) NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Hire_Date DATE NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Tenure INT NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Role_Tenure INT NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Promotion_Gap INT NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Manager_Tenure INT NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Overtime NVARCHAR(10) NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Business_Travel NVARCHAR(20) NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Equity_Grant INT NOT NULL

ALTER TABLE		Work_Profile
ALTER COLUMN	Turnover NVARCHAR(10) NOT NULL

-- 2- Assigning Primary Key:
ALTER TABLE		Work_Profile
ADD CONSTRAINT  PK_Work PRIMARY KEY CLUSTERED (Emp_ID)


-- Altering the Education_Level Table & Assigning "Edu_Level_ID" as Primary Key:
SELECT	*
FROM	Education_Level

-- 1- Modifying Data Types:
ALTER TABLE		Education_Level
ALTER COLUMN	Edu_Level_ID INT NOT NULL

ALTER TABLE		Education_Level
ALTER COLUMN	Edu_Level NVARCHAR(40) NOT NULL

-- 2- Assigning Primary Key:
ALTER TABLE		Education_Level
ADD CONSTRAINT  PK_Edu PRIMARY KEY CLUSTERED (Edu_Level_ID)


-- Altering the E_Personal_Details Table & Assigning Primary & Foreign Keys:
SELECT	*
FROM	Employee_Information

-- 1- Modifying Data Types:
ALTER TABLE		Employee_Information
ALTER COLUMN	Emp_ID NVARCHAR(15) NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	F_Name NVARCHAR(40) NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	L_Name NVARCHAR(40) NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	Gender NVARCHAR(20) NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	Age_Stages NVARCHAR(20) NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	Age INT NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	Race NVARCHAR(50) NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	Marital_Status NVARCHAR(20) NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	Edu_Level_ID INT NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	Major NVARCHAR(40) NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	State NVARCHAR(10) NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	Comute_Distance INT NOT NULL

ALTER TABLE		Employee_Information
ALTER COLUMN	Distance_Level NVARCHAR(20) NOT NULL

-- 2- Assigning Primary & Foreign Keys:
ALTER TABLE		Employee_Information
ADD CONSTRAINT  PK_Emp PRIMARY KEY CLUSTERED (Emp_ID)

ALTER TABLE		Employee_Information
ADD CONSTRAINT  FK_Emp FOREIGN KEY (Emp_ID) REFERENCES Work_Profile (Emp_ID)

ALTER TABLE		Employee_Information
ADD CONSTRAINT  FK_Edu FOREIGN KEY (Edu_Level_ID) REFERENCES Education_Level (Edu_Level_ID)


-- Altering the Satisfaction_Level Table & Assigning "Satisfaction_ID" as Primary Key:
SELECT	*
FROM	Satisfaction_Level

-- 1- Modifying Data Types:
ALTER TABLE		Satisfaction_Level
ALTER COLUMN	Satisfaction_ID INT NOT NULL

ALTER TABLE		Satisfaction_Level
ALTER COLUMN	S_Level NVARCHAR(20) NOT NULL

-- 2- Assigning Primary Key:
ALTER TABLE		Satisfaction_Level
ADD CONSTRAINT  PK_Satisfy PRIMARY KEY CLUSTERED (Satisfaction_ID)


-- Altering the Rating_Level Table & Assigning "Rating_ID" as Primary Key:
SELECT	*
FROM	Rating_Level

-- 1- Modifying Data Types:
ALTER TABLE		Rating_Level
ALTER COLUMN	Rating_ID INT NOT NULL

ALTER TABLE		Rating_Level
ALTER COLUMN	R_Level NVARCHAR(20) NOT NULL

-- 2- Assigning Primary Key:
ALTER TABLE		Rating_Level
ADD CONSTRAINT  PK_Rating PRIMARY KEY CLUSTERED (Rating_ID)


-- Altering the Performance_Level Table & Assigning Primary & Foreign Keys:
SELECT	*
FROM	Performance_Rating

-- 1- Modifying Data Types:
ALTER TABLE		Performance_Rating
ALTER COLUMN	Performance_ID NVARCHAR(15) NOT NULL

ALTER TABLE		Performance_Rating
ALTER COLUMN	Emp_ID NVARCHAR(15) NOT NULL 

ALTER TABLE		Performance_Rating
ALTER COLUMN	Review_Date Date NOT NULL

ALTER TABLE		Performance_Rating
ALTER COLUMN	Environ_Satis_Level INT NOT NULL

ALTER TABLE		Performance_Rating
ALTER COLUMN	Job_Satis_Level INT NOT NULL

ALTER TABLE		Performance_Rating
ALTER COLUMN	Relationship_Satis_Level INT NOT NULL

ALTER TABLE		Performance_Rating
ALTER COLUMN	Train_Opp_Year INT NOT NULL

ALTER TABLE		Performance_Rating
ALTER COLUMN	Train_Opp_Taken INT NOT NULL

ALTER TABLE		Performance_Rating
ALTER COLUMN	Work_Life_Bal INT NOT NULL

ALTER TABLE		Performance_Rating
ALTER COLUMN	Self_Rating INT NOT NULL

ALTER TABLE		Performance_Rating
ALTER COLUMN	Mgr_Rating INT NOT NULL

-- 2- Assigning Primary & Foreign Keys:
ALTER TABLE		Performance_Rating
ADD CONSTRAINT PK_Performance PRIMARY KEY CLUSTERED (Performance_ID)

ALTER TABLE		Performance_Rating
ADD CONSTRAINT  FK_Performance FOREIGN KEY (Emp_ID) REFERENCES Work_Profile (Emp_ID)

ALTER TABLE		Performance_Rating
ADD CONSTRAINT  FK_SatisfyE FOREIGN KEY (Environ_Satis_Level) REFERENCES Satisfaction_Level (Satisfaction_ID)

ALTER TABLE		Performance_Rating
ADD CONSTRAINT  FK_SatisfyJ FOREIGN KEY (Job_Satis_Level) REFERENCES Satisfaction_Level (Satisfaction_ID)

ALTER TABLE		Performance_Rating
ADD CONSTRAINT  FK_SatisfyR FOREIGN KEY (Relationship_Satis_Level) REFERENCES Satisfaction_Level (Satisfaction_ID)

ALTER TABLE		Performance_Rating
ADD CONSTRAINT  FK_SatisfyW FOREIGN KEY (Work_Life_Bal) REFERENCES Satisfaction_Level (Satisfaction_ID)

ALTER TABLE		Performance_Rating
ADD CONSTRAINT  FK_RatingS FOREIGN KEY (Self_Rating) REFERENCES Rating_Level (Rating_ID)

ALTER TABLE		Performance_Rating
ADD CONSTRAINT  FK_RatingM FOREIGN KEY (Mgr_Rating) REFERENCES Rating_Level (Rating_ID)

			--------------------------------------------------------------------------------------------------------------

-- Creating the necessary views:
-- 1- Employee Details:
		-- Inserting Education level column into the Employee Information table
CREATE OR ALTER VIEW Emp_Details AS
	SELECT	Emp_ID,F_Name+' '+L_Name Full_Name, Gender, Age_Stages, Age, Race,Marital_Status,Edu_Level,
			Major, State, Comute_Distance, Distance_Level
	FROM	Employee_Information EI LEFT JOIN Education_Level EL
				ON EI.Edu_level_ID = EL.Edu_Level_ID

SELECT	*
FROM	Emp_Details

-- 2- Performance Evaluation:
		-- Replacing the Satisfaction & Rating Indicators
CREATE OR ALTER VIEW Performance_Evaluation AS
	SELECT	Performance_ID,Emp_ID, Review_Date,YEAR(Review_Date) Review_Year,E.S_Level Environ_Satis_Level,
			J.S_Level Job_Satis_Level, R.S_Level Relationship_Satis_Level,	W.S_Level Work_Life_Bal,Train_Opp_Year,
			Train_Opp_Taken,S.R_Level Self_Rating, M.R_Level Mgr_Rating
	
	FROM	Performance_Rating P	LEFT JOIN	Satisfaction_Level E	ON	P.Environ_Satis_Level		=	E.Satisfaction_ID
									LEFT JOIN	Satisfaction_Level J	ON	P.Job_Satis_Level			=	J.Satisfaction_ID
									LEFT JOIN	Satisfaction_Level R	ON	P.Relationship_Satis_Level	=	R.Satisfaction_ID
									LEFT JOIN	Satisfaction_Level W	ON	P.Work_Life_Bal				=	W.Satisfaction_ID
						  			LEFT JOIN	Rating_Level M			ON	P.Mgr_Rating				=	M.Rating_ID
									LEFT JOIN	Rating_Level S			ON	P.Self_Rating				=	S.Rating_ID			  
SELECT	*
FROM Performance_Evaluation

-- 3- Work Details:
		-- Adding the total Number of evaluations made to each Employee & checking whether they are evaluated or not
		-- Calculated the Hiring Year & the Attrition year
CREATE OR ALTER VIEW Work_Details AS
	SELECT		W.Emp_ID, Department, Position,Salary,Salary_Level, Hire_Date, YEAR(Hire_Date) Hiring_Year,Tenure, Role_Tenure, 
				Promotion_Gap, Manager_Tenure,Overtime, Business_Travel, Equity_Grant, COUNT(Performance_ID) Number_of_Ratings, 
				CASE
				WHEN COUNT(Performance_ID) = 0 THEN 'No Evaluation'
				ELSE 'Had Evaluation'
				END AS Evaluation_Status,
				Turnover,
				CASE
				WHEN Turnover LIKE 'Yes' THEN CAST(YEAR(Hire_Date)+ Tenure AS INT)
				ELSE NULL
				END AS Attrition_Year
	FROM		Work_Profile W	LEFT JOIN	Performance_Evaluation P	ON	W.Emp_ID = P.Emp_ID
	GROUP BY	W.Emp_ID, Position, Department,Salary,Salary_Level, Hire_Date,Tenure, Role_Tenure, 
				Promotion_Gap, Manager_Tenure,Overtime, Business_Travel, Equity_Grant, Turnover

SELECT	*
FROM	Work_Details

SELECT	DISTINCT Tenure,Evaluation_Status 
FROM	Work_Details 
WHERE	Evaluation_Status LIKE 'No%'

SELECT		DISTINCT Position,Equity_Grant, AVG(salary) Average_Salary,COUNT(Emp_ID) Employee_Count
FROM		Work_Details 
GROUP BY	Position,Equity_Grant
ORDER BY	Position,Equity_Grant

SELECT		DISTINCT Number_of_Ratings
FROM		Work_Details 
WHERE		Turnover LIKE 'Yes'

-- Conclusion:
	-- All the employees who had No Performance Ratings were working for a year or less than a year
	-- All the resigned employees were rated either for 9 or 10 times before leaving the company