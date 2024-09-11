using CSV, DataFrames, Statistics

#=
9.
This exercise involves the Auto data set studied in the lab. Make sure
that the missing values have been removed from the data.
=#

autoDataRaw = CSV.read("data/Auto.csv", DataFrame)
autoDataRaw[!, :horsepower] = map(
    hp -> tryparse(Int, hp) === nothing ? missing : parse(Int, hp),
    autoDataRaw.horsepower
)

autoData = dropmissing(autoDataRaw)

#=
(a) Which of the predictors are quantitative, and which are qualitative?
=#

quantitative = [:mpg, :displacement, :horsepower, :weight, :acceleration]
qualitative = [:cylinders, :year, :origin, :name]

#=
(b) What is the range of each quantitative predictor? You can answer this using
the min() and max() methods.
(c) What is the mean and standard deviation of each quantitative predictor?
=#

function statsDf(df::DataFrame)::DataFrame
    return DataFrame(
        :Column => names(df),
        :Mean => mean.(eachcol(df)),
        :Std => std.(eachcol(df)),
        :Min => minimum.(eachcol(df)),
        :Max => maximum.(eachcol(df))
    )
end

autoStats = statsDf(autoData[!, quantitative])

#=
(d)
Now remove the 10th through 85th observations. What is the range, mean, and standard
deviation of each predictor in the subset of the data that remains?
=#

allRows = 1:nrow(autoData)
rowsToRemove = 10:85
rowsToKeep = setdiff(allRows, rowsToRemove)
autoDataFiltered = autoData[rowsToKeep, :]
autoStatsFiltered = statsDf(autoDataFiltered[!, quantitative])

@df autoData StatsPlots.scatter(
    :weight,
    :mpg,
    group = :origin,
    title = "Weight vs MPG by Origin",
    xlabel = "Weight",
    ylabel = "MPG",
    legend = :topright
)

@df autoData StatsPlots.scatter(
    :weight,
    :mpg,
    group = :cylinders,
    title = "Weight vs MPG by Cylinders",
    xlabel = "Weight",
    ylabel = "MPG",
    legend = :topright
)

@df autoData StatsPlots.scatter(
    :acceleration,
    :mpg,
    group = :cylinders,
    title = "acceleration vs MPG by Cylinders",
    xlabel = "acceleration ",
    ylabel = "MPG",
    legend = :topright
)

@df autoData StatsPlots.scatter(
    :displacement,
    :mpg,
    group = :cylinders,
    title = "displacement vs MPG by Cylinders",
    xlabel = "displacement",
    ylabel = "MPG",
    legend = :topright
)