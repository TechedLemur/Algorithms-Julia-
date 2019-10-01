x = [1 1; 10 0; 2 2; 5 5]

function bruteforce(x)
    ans = distance(x[1, :], x[2, :])
    for i = 1:size(x)[1]
        for j = i+1:size(x)[1]
            ans = min(ans, distance(x[i, :], x[j, :]))
        end
    end
    return ans
end
function distance(x, y)
    return sqrt(abs2(x[1] - y[1]) + abs2(x[2]-y[2]))
end

#println(x[2, :][1])
#println(distance(x[1, :], x[3, :]))

println(bruteforce(x))
