function transitive_closure(adjacency_matrix, nodes)
    n = nodes
    t = zeros(n, n)
    for i = 1:n
        for j = 1:n
            if i == j || (adjacency_matrix[i, j] > 0 && adjacency_matrix[i, j] < typemax(Float64))
                t[i, j] = 1
            end
        end
    end

    function f(a, b)
        return max(a, b)
    end

    function g(a, b)
        return min(a, b)
    end

    d = floyd_warshall(t, n, f, g)

    return d

end
