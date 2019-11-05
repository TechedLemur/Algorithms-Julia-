function floyd_warshall(adjacency_matrix, nodes, f, g)
    d = adjacency_matrix
    n = nodes
    for k = 1:n
        for i = 1:n
            for j = 1:n
                d[i,j]=f(d[i,j],g(d[i,k], d[k,j]))
            end
        end
    end
    return d
end
