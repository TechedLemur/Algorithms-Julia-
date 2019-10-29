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
    ans = []
    for edge in E
        if 


end
