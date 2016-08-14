//Scott Onestak
//ECO 231W Replication

use "D:\My Documents\theData.dta"

set more off

//rename variables to more understanble variable names
rename Q3SEX SEX
rename Q5RACE RACE
rename Q6AGE AGE
rename Q9A ENROLLED
rename Q1BYN DEGREE
rename Q12 GRADES
rename Q16A HoursPerWeek
rename Q16B FullTime
rename Q22YN FTExpBoolean
rename Q22YR FTExp

//reassign the Q3SEX variable for later use in the regression
//Males are 1... make them 0
//Females are 2... make them 1
replace SEX = 0 if SEX == 1
replace SEX = 1 if SEX == 2

//generate hourly wage variable if there are no missing variables in the formula
//make assumption the person works 52 weeks per year
replace SALARY = . if SALARY == 999999
replace HoursPerWeek = . if HoursPerWeek == 99 | HoursPerWeek == 0
gen hourlyWage = SALARY / 52 / HoursPerWeek

//generate GPA... GPA values are the average of the bin extremes
//for example, when GRADES == 1, the bin is a GPA from 3.75 to 4.00.  therefore,
//take the average of these two to get the middle of the bin, 3.875
gen GPA = .
replace GPA = 3.875 if GRADES == 1
replace GPA = 3.495 if GRADES == 2
replace GPA = 2.995 if GRADES == 3
replace GPA = 2.495 if GRADES == 4
replace GPA = 1.995 if GRADES == 5
replace GPA = 1.495 if GRADES == 6
replace GPA = .625 if GRADES == 7

//generate the math content variable
gen MathCont = .
//GRE = 675 for Engeniering (13) and Physical Science (1900-2000)
replace MathCont = 675 if MAJOR == 13 | inrange(Q2MAJ,1900,2000)
//GRE = 650 for Computer Science (700-800)
replace MathCont = 650 if inrange(Q2MAJ,700,800)
//GRE = 625 for Mathematics (1700-1800)
replace MathCont = 625 if inrange(Q2MAJ,1700,1800)
//GRE = 600 for Economics (2204)
replace MathCont = 600 if Q2MAJ == 2204
//GRE = 575 for Architecture (200-300) and Biology (21)
replace MathCont = 575 if inrange(Q2MAJ,200,300) | MAJOR == 21
//GRE = 500 for Agriculture (100-200), Business(11), Social Science (not Econ)
//(23 & !2240) & (2000-2100) ~ counted psychology with social science because 
//it's a social science and made the results more accurate, and "Other" (30)
replace MathCont = 500 if inrange(Q2MAJ,100,200) | MAJOR == 11 | (MAJOR == 23 & Q2MAJ != 2204) | MAJOR == 30 | inrange(Q2MAJ,2000,2100)
//GRE = 475 for Communications(600-700), Humanities (24), and Health (14)
replace MathCont = 475 if inrange(Q2MAJ,600,700) | MAJOR == 24 | MAJOR == 14
//GRE = 450 for Education(12) and Home Economics (1300-1400)
replace MathCont = 450 if MAJOR == 12 | inrange(Q2MAJ,1300,1400)
//GRE = 425 for Library Science (1600-1700) and Public Affairs (2100-2200)
replace MathCont = 425 if inrange(Q2MAJ,1600,1700) | inrange(Q2MAJ,2100,2200)

//generate the post degree experience.  Get the number of complete years by 
//subtracting from 84 because someone who graduated in 1984 could not have a 
//completed full year of experience.  Then add this to the months, calcuated by
//taking 16 (12 months in a year + 4 because it is being compared for the month
//of April, the 4th month of the year) and subtracting by the month in which
//the individual received the degree to get the number of months.  Then dividing
//by 12 to change the months units into years units.
gen PostDegExp = (84 - Q1BYR) + (16 - Q1BMO)/12

replace SCHOOLTYPE = 3 if SCHOOLTYPE == 4

//gen categories... 12 major controls 
gen MajorControl = 0
replace MajorControl = 1 if inrange(Q2MAJ,500,600)
replace MajorControl = 2 if inrange(Q2MAJ,600,700)
replace MajorControl = 3 if inrange(Q2MAJ,700,800)
replace MajorControl = 4 if Q2MAJ == 2204
replace MajorControl = 5 if inrange(Q2MAJ,800,900)
replace MajorControl = 6 if inrange(Q2MAJ,900,1000)
replace MajorControl = 7 if MAJOR == 24
replace MajorControl = 8 if inrange(Q2MAJ,1700,1800)
replace MajorControl = 9 if Q2MAJ == 1203
replace MajorControl = 10 if (MAJOR == 22 | MAJOR == 21) & MajorControl != 3 & MajorControl != 8
replace MajorControl = 11 if MAJOR == 23 & MajorControl != 4 | inrange(Q2MAJ,2000,2100)

//generate technical majors...engineering, mathematics, physical science, and
//computer science
gen techMAJOR = 0
replace techMAJOR = 1 if inrange(Q2MAJ,900,1000) | inrange(Q2MAJ,1700,1800) | inrange(Q2MAJ,1900,2000) | inrange(Q2MAJ,700,800)

//generate women with technical college majors based on if the person is a 
//woman and if she has a technical major
gen womenTechInt = 0
replace womenTechInt = 1 if techMAJ == 1 & SEX == 1

//generate women in elite schools
gen womenElite = 0
replace womenElite = 1 if SCHOOLTYPE == 0 & SEX == 1

//gen women in elite school with technical majors
gen womenTechElite = 0
replace womenTechElite = 1 if SCHOOLTYPE == 0 & techMAJ == 1 & SEX == 1

//gen women
gen womenTechUpper = 0
replace womenTechUpper = 1 if (SCHOOLTYPE == 0 | SCHOOLTYPE == 1) & techMAJ == 1 & SEX == 1


//generate the natural log of hourly wages for the regression
gen logHourlyWage = ln(hourlyWage)

//gen variable that tells us if the person is in the sample or not
gen inSample = 0

//inSample if: white (RACE == 1)
//             received degree in 83 or 84 (DEGREE == 1)
//             recieved a bachelor's degree (LDEG == 1)
//             employed ft or involuntary pt (FullTime == 1 | FullTime == 2)
//             not enrolled ft (ENROLLED == 2 | ENROLLED == 3)
//             no more than 30 years old (AGE <= 30)
//             earn more than $1 / hour (hourlyWage > 1)
//             no missing data on earnings (SALARY != .)
//             no missing data on hour per week (HoursPerWeek != .)
//             no missing work exp. (FTExpBoolean != 0 & FTExpBoolean != 99 & 
//					FTExp != 99)
//             no missing data on college grades (GRADES != 8 & GRADES != 9)
replace inSample = 1 if RACE == 1 & DEGREE == 1 & LDEG == 1 & (FullTime == 1 | FullTime == 2) & (ENROLLED == 2 | ENROLLED == 3) & AGE <= 30 & hourlyWage > 1 & SALARY != . & HoursPerWeek != . & FTExpBoolean != 0 & FTExpBoolean != 99 & FTExp != 99 & GRADES != 8 & GRADES != 9

//generate tabstat for the rows in table 1 of the paper
//hours worked per week(if not invol. part time) is excluded from this because
//it is calculated on it own directly aftewards
//the sample sizes are additionally not calculated in this step
//0 = White Males
//1 = White Females
//tabstat MathCont hourlyWage GPA FTExp PostDegExp Business Comm CompSci Econ Edu Engin Human Math Nursing Science SocSci if inSample == 1, by(SEX)

//calculate the hours worked per week (if not invol. part time)
//tabstat HoursPerWeek if inSample == 1 & FullTime == 1, by(SEX)

//Sample size White Males
count if inSample == 1 & SEX == 0

//Sample size White Females
count if inSample == 1 & SEX == 1

//Model 1: regress logHourlyWages onto white women, hours, predegree exp.,
//            postdegree exp., and GPA
reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA if inSample == 1,robust

//Model 1 with school type contol
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA i.SCHOOLTYPE if inSample == 1,robust

//Model 2: regress logHourlyWages onto white women, hours, predegree exp.,
//            postdegree exp., GPA, and the 12 major controls
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA i.MajorControl if inSample == 1,robust

//Model 2 with school type control
reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA i.MajorControl i.SCHOOLTYPE if inSample == 1,robust

//Model 3: regress logHourlyWages onto white women, hours, predegree exp.,
//            postdegree exp., GPA, and Mathematical content
reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont if inSample == 1,robust

//Model 3 with school type control
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont i.SCHOOLTYPE if inSample == 1,robust

//Model 4: regress logHourlyWages onto white women, hours, predegree exp.,
//            postdegree exp., GPA, Mathematical Content, and white women with
//            technical college majors
reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenTechInt if inSample == 1,robust

//Model 4 with school type control
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenTechInt i.SCHOOLTYPE if inSample == 1,robust

//interaction of elite school and women... no school type
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenElite if inSample == 1,robust

//school type included
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenElite i.SCHOOLTYPE if inSample == 1,robust

//interaction of elite school, women, and tech major... no school type
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenTechElite if inSample == 1,robust

//school type included
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenTechElite i.SCHOOLTYPE if inSample == 1,robust

//model 4 with elite school and women interaction
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenTechInt womenElite if inSample == 1,robust

//school type
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenTechInt womenElite i.SCHOOLTYPE if inSample == 1,robust

//new model
xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenTechUpper if inSample == 1,robust

xi: reg logHourlyWage SEX HoursPerWeek FTExp PostDegExp GPA MathCont womenTechUpper i.SCHOOLTYPE if inSample == 1,robust
