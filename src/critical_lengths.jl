# Include the functions from the functions.jl file
include("functions.jl")

# Ask for user inputs
println("Which dimension do you want to study?")
n = parse(Int, readline())

println("To which eigenvalue do you want to check?")
k = parse(Int, readline())

# Interval that we want to study
X = LinRange(0, 7, max(400, k^2))
Y = []

for m in 1:k
    Y_m = [sharp_upper_bound(n, m, l) for l in X]

    # Find the critical length
    ym_max_index = argmax(Y_m)
    critical_length_m = if maximum(Y_m) > Y_m[end]
        X[ym_max_index]
    else
        -1
    end

    push!(Y, critical_length_m)
end

# Check for critical length
if Y[end] == -1
    println("In dimension $n, the $k-th eigenvalue has a critical length at infinity.")
else
    local i = length(Y)
    while Y[i] != -1 && i > 1
        i -= 1
    end
    if Y[i] == -1
        println("In dimension $n, from the eigenvalue number $(i + 1) to the $k-th, I only found finite critical lengths.")
    end
end
