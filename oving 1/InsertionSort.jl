liste = [5,3,4,7,9,6]

function InsertionSort!(A)
    for j in 2:length(A)
        key = A[j]
        i = j - 1
        while (i > 0)
            if (A[i] > key)
                A[i+1] = A[i]
            else
                break
            end
            i = i-1
        end
        A[i+1] = key
    end
end
println(liste)
InsertionSort!(liste)
println((liste))
