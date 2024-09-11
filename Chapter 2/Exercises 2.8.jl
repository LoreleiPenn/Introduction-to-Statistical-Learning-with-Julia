using CSV, DataFrames, CategoricalArrays, StatsPlots, PairPlots, WGLMakie
#=
8.

This exercise relates to the College data set, which can be found in the file College.csv
on the book website. It contains a number of variables for 777 different universities and
colleges in the US. The variables are:

• Private : Public/private indicator
• Apps : Number of applications received
• Accept : Number of applicants accepted
• Enroll : Number of new students enrolled
• Top10perc : New students from top 10 % of high school class
• Top25perc : New students from top 25 % of high school class
• F.Undergrad : Number of full-time undergraduates
• P.Undergrad : Number of part-time undergraduates
• Outstate : Out-of-state tuition
• Room.Board : Room and board costs
• Books : Estimated book costs
• Personal : Estimated personal spending
• PhD : Percent of faculty with Ph.D.s
• Terminal : Percent of faculty with terminal degree
• S.F.Ratio : Student/faculty ratio
• perc.alumni : Percent of alumni who donate
• Expend : Instructional expenditure per student
• Grad.Rate : Graduation rate
=#

#=
a)
Use the pd.read_csv() function to read the data into Python. Call the loaded data
college. Make sure that you have the directory set to the correct location for the
data.
=#
collegeData = CSV.read("data/College.csv", DataFrame)

#=
b)
Look at the data used in the notebook by creating and running a new cell with just
the code college in it. You should notice that the first column is just the name of
each university in a column named something like Unnamed: 0. We don’t really want
pandas to treat this as data. However, it may be handy to have these names for later.
Try the following commands and similarly look at the resulting data frames:
=#
rename!(collegeData, :Column1 => :College)

#=
c)
Use the describe() method of to produce a numerical summary of the variables in the
data set.
=#
describe(collegeData) |> df -> show(df; allrows=true)

#=
d)
Use the pd.plotting.scatter_matrix() function to produce a scatterplot matrix of
the first columns [Top10perc, Apps, Enroll]. Recall that you can reference a list
C of columns of a data frame A using A[C].
=#
layout = [:Top10perc, :Apps, :Enroll]
pairplot(collegeData[!, layout])

#=
e)
Use the boxplot() method of college to produce side-by-side boxplots of Outstate
versus Private.
=#

StatsPlots.boxplot(collegeData.Private, collegeData.Outstate, group = collegeData.Private)

#=
f)
Create a new qualitative variable, called Elite, by binning the Top10perc variable
into two groups based on whether or not the proportion of students coming from the
top 10% of their high school classes exceeds 50%.
=#

collegeData[!, :Elite] = cut(collegeData.Top10perc, [0, 50, 100], labels=["No", "Yes"])

#=
g)
Use the plot.hist() method of college to produce some histograms with differing numbers
of bins for a few of the quantitative variables. The command plt.subplots(2, 2) may be
useful: it will divide the plot window into four regions so that four plots can be made
simultaneously. By changing the arguments you can divide the screen up in other combinations.
=#
