s = []
push!(s, 2)
push!(s, 5)
println(s)    # gir lista [2,5]
println(s[1]) # dette gir verdien 2
x = pop!(s)
println(x)    # dette gir verdien 5

f = [-6, -44, -47, 27, 35]


function reverseandlimit(array, maxnumber)
    reversed = []
    while length(array) > 0
        x = pop!(array)
        push!(reversed, min(x, maxnumber))
    end
    return reversed

end

println(reverseandlimit(f, 0))
