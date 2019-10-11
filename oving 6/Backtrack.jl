function backtrack(pathweights)
	rows, cols = size(pathweights)
    liste = []
	x = argmin(pathweights[rows, 1:cols])
	push!(liste, (rows, x))
	for i = rows-1:-1:1
		row = pathweights[i, 1:cols]

		if x == 1
			if (row[x] > row[x+1])
				x = 2
			end
		elseif x == cols
			if row[x-1] <= row[cols]
				x = x-1
			end
		else
			mini = row[x+1]
			t = x+1
			if (row[x] <= mini )
				t = x
				mini = row[x]
			end
			if row[x-1] <= mini
				t = x-1
			end
			x = t
		end
		push!(liste, (i, x))
	end
	return liste
end

### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test backtrack([1 1 ; 2 2]) == [(2,1),(1,1)]
    #Dette er samme eksempel som det vist i oppgaveteskten
	@test backtrack([3  6  8  6  3; 10 9  11 10 6; 13 19 13 7  12; 23 17 10 8  9; 23 11 15 11 17]) == [(5,2), (4,3), (3,4), (2,5), (1,5)]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
