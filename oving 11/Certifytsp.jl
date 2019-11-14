function certifytsp(path, maxweight, neighbourmatrix)

    if path[1] != path[length(path)]
        return false
    end
    weight = 0
    for i = 1:length(path)-1
        weight += neighbourmatrix[path[i], path[i+1]]
    end
    a = path[2:length(path)]
    sort!(a)
    for i = 1:length(a)
        if i != a[i]
            return false
        end
    end
    if weight > maxweight
        return false
    end
    return true
end
