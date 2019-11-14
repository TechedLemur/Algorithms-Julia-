function find_augmenting_path(source, sink, nodes, flows, capacities)

  function create_path(source, sink, parent)
    # creates a path from source to sink using parent list
    node = sink
    path = Vector{Int}([sink])
    while node ≠ source
      node = parent[node]
      push!(path, node)
    end
    return reverse(path)
  end

  discovered = zeros(Bool, nodes)
  parent = zeros(Int, nodes)
  queue = Queue{Int}()
  enqueue!(queue, source)

  # BFS to find augmenting path, while keeping track of parent nodes
  while !isempty(queue)
    node = dequeue!(queue)
    if node == sink
      return create_path(source, sink, parent)
    end

    for neighbour ∈ 1:nodes
      if !discovered[neighbour] && flows[node, neighbour] < capacities[node, neighbour]
        enqueue!(queue, neighbour)
        discovered[neighbour] = true
        parent[neighbour] = node
      end
    end
  end

  return nothing # no augmenting path found
end

function max_path_flow(path, flows, capacities)
  # find max flow to send through a path
  n = length(path)
  flow = Inf
  for i in 2:n
    u, v = path[i-1], path[i]
    flow = min(flow, capacities[u, v] - flows[u, v])
  end
  return flow
end

function send_flow!(path, flow, flows)
  n = length(path)
  for i in 2:n
    u, v = path[i-1], path[i]
    flows[u, v] += flow
    flows[v, u] -= flow
  end
end

#Task 1
function max_flow(source, sink, nodes, capacities)
    max = 0
    flows = zeros(nodes, nodes)
    while find_augmenting_path(source, sink, nodes, flows, capacities) != nothing
        path = find_augmenting_path(source, sink, nodes, flows, capacities)
        flow = max_path_flow(path, flows, capacities)
        send_flow!(path, flow, flows)
        max += flow
    end

    return flows, max

end

#Task 2
function min_cut(source, sink, nodes, capacities)
    flows, maxFlow = max_flow(source, sink, nodes, capacities)
    s = [source]
    t = [sink]
    for i = 1:nodes
        if find_augmenting_path(source, i, nodes, flows, capacities) != nothing
            if i != sink
                s = union(s, i)
            end
        elseif i != source
            t = union(t, i)
        end
    end
    return s, t
end
