using CSV, DataFrames, GLMakie, GLM, StatsModels

bostonData = CSV.read("Data/Boston.csv", DataFrame) |>
    df -> select(df, Not(:Column1))

model = lm(@formula(medv ~ lstat), bostonData)
summary(model)

predict(model, bostonData)