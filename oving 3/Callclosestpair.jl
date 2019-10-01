x = [0.9 1.8; 1.0 2.0; 2.0 7.0; 2.0 3.0; 3.0 2.0; 3.0 3.5; 3.0 4.0; 3.0 3.0; 4.0 5.0; 6.0 6.0; 7.0 1.0]

y = [7.0 1.0; 0.9 1.8; 1.0 2.0; 3.0 2.0; 2.0 3.0; 3.0 3.0; 3.0 3.5; 3.0 4.0; 4.0 5.0; 6.0 6.0; 2.0 7.0]

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
function binaryintervalsearch(x, delta, coordinate)
    Size = size(x)[1]
    if (Size % 2 == 1 )
        median = x[div(Size, 2)+1, coordinate]
    else
        median = (x[div(Size, 2), coordinate] + x[div(Size, 2)+1, coordinate])/2
    end

    lshift = 0
    left = view(x, 1:div(Size, 2), coordinate)
    lindex = size(left)[1]

    while(lindex > 0 && left[lindex] >= (median - delta))
        lshift = lshift+1
        lindex = lindex-1
    end
    rshift = 0
    right = view(x, div(Size, 2)+1+ Size % 2:Size, coordinate)
    rindex = 1
    while(rindex <= size(right)[1] && rindex > 0 && right[rindex] <= (median + delta))
        rshift = rshift+1
        rindex = rindex+1
    end
    if (rshift == 0 && lshift == 0)
        if Size % 2 == 1
            return div(Size, 2)+1, div(Size, 2)+1
        end
        return -1, -1
    end
    a = size(left)[1]-lshift+1
    b = size(left)[1] + rshift+1
    return size(left)[1]-lshift+1, size(left)[1] + rshift+ Size % 2
end
function splitintwo(x,y)

    xSize = size(x)[1]
    #ySize = size(y)[1]
    lMax = div(xSize, 2)+xSize % 2

    xLeft = Dict()

    for l = 1:lMax
        count = get(xLeft, x[l, 1:2], 0)
        xLeft[x[l, 1:2]] = count + 1
    end

    yLeft = zeros(lMax, 2)
    yRight = zeros(xSize -lMax, 2)

    xMedian = (x[lMax, 1] + x[div(xSize, 2)+1, 1])/2

    j = 1

    k = 1
    for i = 1:xSize

        if (y[i, 1] < xMedian )
            yLeft[j, 1] = y[i, 1]
            yLeft[j, 2] = y[i, 2]
            j += 1
        elseif (y[i, 1] > xMedian)
            yRight[k, 1] = y[i, 1]
            yRight[k, 2] = y[i, 2]
            k += 1
        else
            if (get(xLeft, y[i, 1:2], 0)) != 0
                yLeft[j, 1] = y[i, 1]
                yLeft[j, 2] = y[i, 2]
                j += 1
                xLeft[y[i, 1:2]] = get(xLeft, y[i, 1:2], 0) - 1
            else
                yRight[k, 1] = y[i, 1]
                yRight[k, 2] = y[i, 2]
                k += 1
            end

        end
    end

    xLeft = view(x, 1:lMax, 1:2)
    xRight = view(x, lMax+1:xSize, 1:2)

    return xLeft, xRight, yLeft, yRight
end

function closestpair(x,y)

    if size(x, 1) <= 3
        return bruteforce(x)

    else
        xLeft, xRight, yLeft, yRight = splitintwo(x, y)
        d1 = closestpair(xLeft, yLeft)
        d2 = closestpair(xRight, yRight)
        t = binaryintervalsearch(y, min(d1, d2), 2)
        if !(t[1] == -1 || t[2] == -1)
            d3 = bruteforce(y[t[1]:t[2], 1:2])
        else
            d3 = max(d1, d2)
        end
    end
    return min(d1, d2, d3)
end



println(closestpair(x, y))
