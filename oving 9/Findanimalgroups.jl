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

function hammingdistance(s1, s2)
    ans = 0
    for i = 1:lastindex(s1)
        if s1[i] != s2[i]
            ans += 1
        end
    end
    return ans
end


function findanimalgroups(animals::Vector{Tuple{String, String}}, k::Int64)
    E = Tuple{Int64,Int64,Int64}[]
    for i = 1:lastindex(animals)-1
        for j = i+1:lastindex(animals)
            push!(E, (hammingdistance(animals[i][2], animals[j][2]), i, j))
        end
    end

    A = findclusters(E, length(animals), k)
    ans = []
    for c in A
        t = []
        for s in c
            push!(t, animals[s][1])
        end
        push!(ans, t)
    end
    return ans
end

@time println(findanimalgroups([("Spurv", "CCATTCGT"), ("Mus", "TAGGCATA"), ("Elg", "CCGGATTA"), ("Hjort", "CCGGAATA"), ("Ugle", "GGATTCGG"), ("Hamster", "TAGGCAGG"), ("Marsvin", "TAGGCATG"), ("Hauk", "GGATGCGG")], 3))
@time println(findanimalgroups([("Ugle", "CGGCACGT"), ("Elg", "ATTTGACA"), ("Hjort", "AATAGGCC")], 2))
