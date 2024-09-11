using DataFrames, NearestNeighbors, Distances

data = DataFrame(
    X1 = [0.0, 2.0, 0.0, 0.0, -1.0, 1.0],
    X2 = [3.0, 0.0, 1.0, 1.0, 0.0, 1.0],
    X3 = [0.0, 0.0, 3.0, 2.0, 1.0, 1.0],
    Y = [:red, :red, :red, :green, :green, :red]
)

X = Matrix(data[:, 1:3])
Y = data.Y
tree = KDTree(X')

point = [0, 0, 0]

k₀ = 1
k₁ = 3

for k in [k₀, k₁]
    idxs, dists = knn(tree, point, k, true)
    answer = data[idxs, :]
    answer[!, :distance] = dists
    println("For k = ", k)
    println("The closest point to ", point," is: ", answer)
    println("---")
end