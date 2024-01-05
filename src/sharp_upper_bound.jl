# Include the functions from the functions.jl file
include("functions.jl")

# Get user inputs
println("Which dimension do you want to study?")
n = parse(Int, readline())

println("Which eigenvalue do you want to study?")
k = parse(Int, readline())

println("Which meridian length do you want to study?")
L = parse(Float64, readline())

# Calculate and print the sharp upper bound
sharp_bound = sharp_upper_bound(n, k, L)
println("The sharp upper bound for the $k-th Steklov eigenvalue of a hypersurface of revolution in the Euclidean space, with meridian length $L and dimension $n is $sharp_bound")
