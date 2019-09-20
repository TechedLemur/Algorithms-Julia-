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


x = [1.0 -1.0; 2.0 2.0; 3.0 3.0; 4.0 5.0; 5.0 5.0]
println(binaryintervalsearch(x, 1, 2))
println(binaryintervalsearch(x, 1, 1))
x = [1.0 0.0; 2.0 0.0; 3.0 0.0]
println(binaryintervalsearch(x, 0.5, 2))
println(binaryintervalsearch(x, 0.5, 1))
