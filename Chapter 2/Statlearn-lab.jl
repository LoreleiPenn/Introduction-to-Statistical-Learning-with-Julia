using DataFrames, CSV, Distributions, Statistics

x = [1, 2, 3, 4, 5, 6];
println("Beggining of x:", x);
xReshape = reshape(x, 3, 2) |> transpose;
println("Reshaped with a size of 3×2:", xReshape);

x .^ 2

sqrt.(x)

# Now define a random variable x of 50 elements with a normal distribution
x = rand(Normal(), 50)

# Now we create a random variable y by using N(50, 1)
y = x .+ rand(Normal(50, 1), 50)

# Now we compute the correlation matrix between x and y.
cor(x, y)