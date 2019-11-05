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

function schulze_ranking(preference_matrix , candidates)
    # 1
    n = candidates
    d = preference_matrix




    function f(a, b)
        return max(a, b)
    end

    function g(a, b)
        return min(a, b)
    end

    # 2
    m = floyd_warshall(d, n, f, g)

    for i = 1:n
        for j = 1:n
             if i != j
                 if m[i, j] <= m[j, i]
                     m[i, j] = 0
                 end
             end
         end
     end
     println(m)
    # 3
    wins = []
    for i = 1:n
        s = 0
        for j = 1:n
            if m[i, j] > 0
                s+=1
            end
        end
        push!(wins, (s, Char(64+i)))
    end
    s = ""
    Base.sort!(wins)
    for i = 1:n

        s = string(s, popfirst!(wins)[2])
    end
    return reverse(s)

end

println(schulze_ranking([0 1 2; 2 0 2; 1 1 0;], 3))
@time println(schulze_ranking([0 11 20 14; 19 0 9 12; 10 21 0 17; 16 18 13 0], 4))
