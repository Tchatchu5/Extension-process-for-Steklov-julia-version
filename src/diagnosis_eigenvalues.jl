# Include the functions from the functions.jl file
include("functions.jl")

function main()
    args = ARGS

    # Display prompt and read input for dimension
    if length(args) > 0
        n = parse(Int, args[1])
    else
        print("Which dimension do you want to study? ")
        n = parse(Int, readline())
    end

    # Display prompt and read input for eigenvalue
    if length(args) > 1
        i = parse(Int, args[2])
    else
        print("To which diagnosis eigenvalue do you want to study? ")
        i = parse(Int, readline())
    end

    k = 2
    K = [k]
    Diag_critic_length = []


t_0 = time_ns()
for j in 1:i
    k += 2 * mu(n, j)
    push!(K, k)
    t_1 = time_ns()
    elapsed_time = round((t_1 - t_0) / 10^6, digits=3)
    println(lpad(j, 2, '0'), ": ", K, " -- Elapsed time: ", elapsed_time, " ms")
    t_0 = time_ns()
    
    # First interval that we want to study
    X_j = LinRange(0, 7, max(400, Int(k)))
    # For each value of L, find the sharp upper bound depending on n, k, L
    Y_j = [sharp_upper_bound(n, k, l) for l in X_j]
    diagnosis_eigenvalue_j = maximum(Y_j) > last(Y_j) ? 1 : -1
    push!(Diag_critic_length, diagnosis_eigenvalue_j)
end




    println(Diag_critic_length)

    c = 0
    if Diag_critic_length[end - c] == -1
        println("In dimension $n, the $(K[end - c])th eigenvalue has a critical length at infinity.")
    else
        while (Diag_critic_length[end - c] != -1) && (c < length(Diag_critic_length))
            c += 1
            if Diag_critic_length[end - c] == -1
                println("In dimension $n, from the eigenvalue number $(K[end - c + 1]) to the $(K[end] + 2 * mu(n, i) - 1)th, I only found finite critical lengths.")
            end
        end
    end
end

main()
