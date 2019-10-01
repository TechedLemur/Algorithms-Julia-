x = [1.0 2.0; 2.0 3.0; 3.0 2.0; 3.0 4.0; 3.0 3.0; 4.0 5.0; 6.0 6.0; 7.0 1.0]

y = [7.0 1.0; 1.0 2.0; 3.0 2.0; 2.0 3.0; 3.0 3.0; 3.0 4.0; 4.0 5.0; 6.0 6.0]

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


println(splitintwo(x, y))

#println(size(x, 1))
#println(zeros(5, 2))
