mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end

function findset(x::DisjointSetNode)
    if x != x.p
        x.p = findset(x.p)
    end
    return x.p
end


function link!(x::DisjointSetNode, y::DisjointSetNode)
    if x.rank > y.rank
        y.p = x
    else
        x.p = y
        if x.rank == y.rank
            y.rank += 1
        end
    end
end

function union!(x::DisjointSetNode, y::DisjointSetNode)
    link!(findset(x), findset(y))
end

function findclusters(E::Vector{Tuple{Int, Int, Int}}, n::Int, k::Int)
    nodes = []
    for i = 1:n
        push!(nodes, DisjointSetNode())
    end
    sort!(E)

    c = n
    i = 1
    while c > k
        edge = E[i]
        u = nodes[edge[2]]
        v = nodes[edge[3]]

        if (findset(u) != findset(v))
            union!(u, v)
            c -= 1
        end
        i += 1
    end
    ans = []
    for i = 1:length(nodes)
        temp = [i]
        for j = 1:length(nodes)
            if findset(nodes[i]) == findset(nodes[j])
                temp = union(temp, j)
                sort!(temp)
            end
        end
        if temp ∉ ans
            push!(ans, temp)
        end
    end
    return ans
end

E=Tuple{Int64,Int64,Int64}[(1, 1, 2), (2, 1, 3), (3, 2, 3), (1, 2, 1), (2, 3, 1), (3, 3, 2)]
println(findclusters(E, 3, 2))
