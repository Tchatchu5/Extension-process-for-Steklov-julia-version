using Memoize


@memoize function mu(n, k)
    # Ensure k is an integer when used as an array index or similar
    k_int = Int(k)
    return (big(n) + 2 * big(k_int) - 2) * factorial(big(n) + big(k_int) - 3) /
           (factorial(big(k_int)) * factorial(big(n) - 2))
end


@memoize function sigma_dirichlet(n, D, L)
    if L == 0
        return Inf
    end
    return ((n + D - 2) * (1 + L / 2)^(2 * D + n - 2) + D) /
           ((1 + L / 2)^(2 * D + n - 2) - 1)
end


@memoize function sigma_neumann(n, N, L)
    return N * ((N + n - 2) * ((1 + L / 2)^(2 * N + n - 2) - 1)) /
           (N * (1 + L / 2)^(2 * N + n - 2) + N + n - 2)
end


@memoize function l_0(n, k)
    k_int = Int(k)  # Convert k to an integer before using it as an index
    list = [mu(n, i) for i in 0:k_int]
    sum = 0
    j = 0
    for i in 0:k_int
        if sum + list[i + 1] > k_int
            return j
        end
        sum += list[i + 1]
        j += 1
    end
    return nothing
end


function l_1(m2_list, k)
    i, accumulator = 1, 0
    while accumulator < k
        accumulator += m2_list[i]
        i += 1
    end
    # Reverse the latest addition that brought us above k
    return i - 1
end


function sharp_upper_bound(n, k, L)
    E = Float64[]
    for i in 0:l_0(n, k)
        push!(E, sigma_dirichlet(n, i, L))
    end
    for i in 1:l_0(n, k) + 1
        push!(E, sigma_neumann(n, i, L))
    end

    M = Int[]
    for i in 0:l_0(n, k)
        push!(M, mu(n, i))
    end
    for i in 1:l_0(n, k) + 1
        push!(M, mu(n, i))
    end

    link_dict = Dict{Float64, Vector{Int}}()
    for i in 1:length(E)
        key = E[i]
        value = M[i]
        if haskey(link_dict, key)
            push!(link_dict[key], value)
        else
            link_dict[key] = [value]
        end
    end

    sort!(E)
    M2 = Int[]
    for e_value in E
        push!(M2, popfirst!(link_dict[e_value]))
    end

    l1 = l_1(M2, k)
    return E[l1]
end
