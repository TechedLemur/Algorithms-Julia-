function mincoins(coins, value)

   a = zeros(value)
   a[1] = 1
   inf = typemax(Int)
   for i = 2:value
      a[i] = inf  
      for coin in coins
         q = inf
         if i == coin
            q = 1
         elseif coin < i
            q = min(q, a[i-coin]+1)
         end
      end
      a[i] = q
   end
   return a[value]

end






### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
@test mincoins([4,3,1],18) == 5
@test mincoins([1000,500,100,30,7,1],14) == 2
@test mincoins([40, 30, 20, 10, 1], 90) == 3
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
