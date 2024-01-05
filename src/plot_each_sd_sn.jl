using Plots

# Include the functions from the functions.jl file
include("functions.jl")

# Ask for user inputs
println("Which dimension do you want to study?")
n = parse(Int, readline())

println("Which eigenvalue do you want to study?")
k = parse(Int, readline())

# First interval that we want to study
X = LinRange(0, 7, max(400, k ^ 2))

# For each value of L, find the sharp upper bound depending on n, k, L
Y = [sharp_upper_bound(n, k, l) for l in X]

# Find the critical length
y_max_index = argmax(Y)
critical_length = if maximum(Y) > last(Y)
    round(X[y_max_index], digits=3)
else
    "infinite"
end

# Refine the interval according to the critical length
if critical_length != "infinite"
    X = LinRange(0, min(critical_length * 4, 7), max(400, k ^ 2))
    Y = [sharp_upper_bound(n, k, l) for l in X]

    y_max_index = argmax(Y)
    critical_length = if maximum(Y) > last(Y)
        round(X[y_max_index], digits=3)
    else
        "infinite"
    end
end

critical_length2 = if maximum(Y) > last(Y)
    "Finite critical length"
else
    "Infinite critical length"
end

# Find the sharp upper bound depending on n, k
upper_bound = round(maximum(Y), digits=if maximum(Y) > last(Y) 3 else 0 end)

# Plotting
p = plot(xlabel="Value of L", ylabel="$(k)th eigenvalue", title=critical_length2)

# Plotting Steklov-Dirichlet eigenvalues
for i in 0:l_0(n, k)
    dirichlet_i = [sigma_dirichlet(n, i, l) for l in X]
    plot!(X, dirichlet_i, color=:blue, label="")
end

# Plotting Steklov-Neumann eigenvalues
for i in 1:l_0(n, k) + 1
    neumann_i = [sigma_neumann(n, i, l) for l in X]
    plot!(X, neumann_i, color=:green, label="")
end

# Plotting the sharp upper bound
plot!(X, Y, color=:red, linewidth=3, label="Critical length $critical_length, \$B_{$n}^{$k}\$= $upper_bound")



# Axis limits
xlims!(0, min(critical_length == round(X[y_max_index], digits=3) ? critical_length * 4 : 7, 7))
ylims!(0, maximum(Y) + 2)

display(p)
