function dnasimilarity(s1, s2)
	ans = 0
	for i = 1:max(length(s1), length(s2))
		if (s1[i] == s2[i])
			ans += 1
		end
	end
	return ans
end




### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test dnasimilarity("A", "A") == 1
	@test dnasimilarity("A", "T") == 0
	@test dnasimilarity("ATCG", "ATGC") == 2
	@test dnasimilarity("ATATATA", "TATATAT") == 0
	@test dnasimilarity("ATGCATGC", "ATGCATGC") == 8
	@test dnasimilarity("CAATAAGGATCTGGTAGCTT", "CCTTACTGAAGCCGCTATGC") == 6
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
