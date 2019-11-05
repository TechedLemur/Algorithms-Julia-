using DataStructures: PriorityQueue, enqueue!, dequeue!

mutable struct Node
    name::String # used to distinguish nodes when debugging
    d::Union{Float64, Nothing} # d for distance
    p::Union{Node, Nothing} # p for predecessor
end
Node(name) = Node(name, nothing, nothing) # constructor used for naming nodes

mutable struct Graph
    V::Array{Node} # V for Vertices
    Adj::Dict{Node, Array{Node}} # Adj for Adjacency
end

function update!(u, v, w)
    x = v.d
    v.d = max(v.d, min(u.d, w[u, v]))
    y = v.d
    if x<y
        v.p = u
    end
end

function initialize!(G, s)
    for v in G.V
        v.d = -typemax(Float64)
    end
    s.d = typemax(Float64)
end

function general_dijkstra!(G, w, s, reverse=false)
    initialize!(G, s)
    S = []
    if reverse
        Q = PriorityQueue(Base.Order.Reverse)
        for u in G.V
            enqueue!(Q, u => u.d)
        end
    else
        Q = PriorityQueue(u => u.d for u in G.V)
    end

    while length(Q) != 0
        u = dequeue!(Q)
        S = union(S, u)
        for v in G.Adj[u]
            update!(u, v, w)
        end
    end

end
