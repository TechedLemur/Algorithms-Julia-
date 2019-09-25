function countingsortletters(A,position)
    c = zeros(27)
    b = Array{Any}(undef, size(A, 1))
    for j = 1:size(A, 1)
        if (position > length(A[j]))
            c[1] = c[1]+1
        else
            c[A[j][position] - '`' + 1] = c[A[j][position] - '`' + 1] + 1
        end
    end

    for i = 2:27
        c[i] = c[i] + c[i-1]
    end

    for k = size(A, 1):-1:1
        if (position > length(A[k]))
            b[convert(Int8, c[1])] = A[k]
            c[1] = c[1] - 1
        else
            b[convert(Int8, c[A[k][position] - '`' + 1 ])] = A[k]
            c[A[k][position] - '`' + 1 ] = c[A[k][position] - '`' + 1] - 1
        end
    end
    return b
end
function countingsortlength(A)

    m = 0
    for i = 1:length(A)
        m = max(m, length(A[i]))
    end
    c = zeros(m+1)
    b = Array{Any}(undef, size(A, 1))
    for j = 1:length(A)
        c[length(A[j])+1] = c[length(A[j])+1 ] + 1
    end

    for i = 2:m+1
        c[i] = c[i] + c[i-1]
    end

    for k = size(A, 1):-1:1
        b[convert(Int8, c[length(A[k])+1])] = A[k]
        c[length(A[k])+1 ] = c[length(A[k])+1] - 1
    end
    return b
end

function flexradix(A, maxlength)
    b = countingsortlength(A)
    for i = maxlength:-1:1
        b = countingsortletters(b, i)
    end
    return b
end

println(flexradix(["kobra", "aggie", "agg", "kort", "hyblen"], 6))
