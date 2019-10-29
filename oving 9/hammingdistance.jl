function hammingdistance(s1, s2)
    ans = 0
    for i = 1:lastindex(s1)
        if s1[i] != s2[i]
            ans += 1
        end
    end
    return ans
end

println(hammingdistance("ATB", "ART"))
