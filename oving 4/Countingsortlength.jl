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
        b[convert(Int8,c[length(A[k])+1])] = A[k]
        c[length(A[k])+1 ] = c[length(A[k])+1] - 1
    end
    return b
end

println(countingsortlength(["bbbb", "aa", "aaaa", "ccc"]))
