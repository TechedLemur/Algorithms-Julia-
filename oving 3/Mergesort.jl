liste2 = [1 2; 4 6; 5 7]
liste1 = [3 3; 7 5; 8 9; 10 12]
unsort = [3 3; 7 5; 8 9; 10 12; 1 2; 4 6; 5 7]
#println(liste[3, 2])
println(size(liste2)[1])
function mergearrays(x,y,coordinate)        #This can be a lot more effective, still learning Julia
    result = zeros(size(x)[1]+size(y)[1], 2)
    r_index = 1
    index_x = 1
    index_y = 1
    while(index_x <= size(x)[1] && index_y <= size(y)[1])
        number1 = x[index_x, coordinate]
        number2 = y[index_y, coordinate]
        if ( number1 <= number2)
            #push!(result, x[index_x, :] )
            result[r_index, 1]=x[index_x, 1]
            result[r_index, 2]=x[index_x, 2]
            index_x = index_x+1

        else
            #push!(result, y[index_y, :])
            result[r_index, 1]=y[index_y, 1]
            result[r_index, 2]=y[index_y, 2]
            index_y = index_y+1
        end
        r_index = r_index+1
    end

    while(index_x <= size(x)[1])
        result[r_index, 1]=x[index_x, 1]
        result[r_index, 2]=x[index_x, 2]
        index_x = index_x+1
        r_index = r_index+1
    end
    while index_y <= size(y)[1]
        result[r_index, 1]=y[index_y, 1]
        result[r_index, 2]=y[index_y, 2]
        index_y = index_y+1
        r_index = r_index+1
    end
    return result
end

function mergesort(A, coordinate)
    size1 = size(A)[1]
    if size1 == 1
        return A
    end
    s1 = mergesort(view(A, 1:div(size1,2), 1:2 ), coordinate)
    s2 = mergesort(view(A, div(size1,2)+1:size1, 1:2), coordinate)
    return mergearrays(s1, s2, coordinate)
end
#println(mergearrays(liste1,liste2,1))
#println(mergearrays(liste1,liste2,2))
#S1 = view(liste1, 1:2, :)
#println(S1)
println(mergesort([3.0 1.0; 2.0 2.0; 3.0 3.0], 1))
#println(size(unsort)[1])
"""A = [1 2; -1 4]
size1 = size(A)[1]
println(view(A, 1:div(size1,2), 1:2 ))
println(view(A, div(size1,2)+1:size1, 1:2))
"""
