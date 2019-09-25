function countingsortletters(A,position)
    c = zeros(26)
    b = Array{Any}(undef, size(A, 1))
    for j = 1:size(A, 1)
        c[A[j][position] - '`'] = c[A[j][position] - '`' ] + 1
    end
    println(c)
    for i = 2:26
        c[i] = c[i] + c[i-1]
    end
    println(c)
    for k = size(A, 1):-1:1
        b[convert(Int8,c[A[k][position] - '`' ])] = A[k]
        c[A[k][position] - '`' ] = c[A[k][position] - '`'] - 1
    end
    return b
end



println(countingsortletters(["ccc", "cba", "ca", "ab", "abc"], 2))
#println(size(["ccc", "cba", "ca", "ab", "abc"]))
#print(zeros(27))
println('c' - '`')
