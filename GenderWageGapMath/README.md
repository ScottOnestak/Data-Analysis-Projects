This econometrics project is a replication and critique of "Mathematical College Majors and the Gender Gap in Wages" by researcher
Catherine J. Weinberger.  The objective of her research was to determine how much of the gender wage gap could be attributed to the
different majors males and females choose in college.

However, I believe there is an omitted variable bias due to the exclusion of a college type variable.  The reasoning behind this can be
found in my write-up (findings.pdf).  

In order to account for this, I cross-reference the initial data set (ICPSR6379.dta) with the HEGIS data set (02202-0001-Data.txt).
The codebooks for both of these datasets are 06379-0001-Codebook.pdf and 02202-0001-Codebook.pdf respectively.

In order to achieve this, I converted the ICPSR6379.dta file into a csv file (stataFile.csv) using the Haven package (transform.R).  
A special thank you to the coders behind the Haven package, which made this project possible.  From there, the datasets were cross-
referenced (GetInfo.java) and transformed back into a dta file (transform.R).

A csv file of the original dataset can be found as the stataFile.csv, and a csv of the cross-referenced dataset can be found as the 
data.csv.

From here, the do file (rep.do) for Stata was executed in order to analyze the results, which are further discussed in the write-up.
The results of running the file can be found under the Do File Run Results.  These are also expressed in chart form in both the 
results.xlsx and the write-up.

Results are further examined in the write-up, but a short summary is provided below.

It was found that simply controlling for the type of institution does relatively little in explaining the wage differential between 
white men and white women.  However, statistically significant interactions were able to explain the different wage gaps women of 
different backgrounds experience better.  For example, white women at elite universities experience an unexplained wage gap of about 
5 percent.  The wage gap experienced by white women with technical college majors is around 3.5 percent.  Finally, women who attend 
either an elite university or a university who have a technical college major also experience an unexplained wage gap of about 
3.5 percent.

Further studies with more accurate measures of individual attributes of institutions are necessary to more accurately control for the 
college attended and the quality of education received.  Studying interactions between specific attributes and white women may help 
explain what institutional qualities are most important in the workforce and reducing the wage gap between the genders from a policy 
perspective going forward.
