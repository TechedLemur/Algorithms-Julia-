function usegreed(coins)
  for i = @views 1:lastindex(coins)-1
        @inbounds if coins[i] % coins[i+1] != 0
            return false
        end
    end
    return true
end
function mincoinsgreedy(coins, value)
    ans = 0
    @inbounds for coin in coins
       while value >= coin
            @fastmath ans += 1
           @fastmath value = value - coin
        end
    end
    return @views ans
end
function mincoins(coins, value)
    @inbounds if usegreed(coins)
        return @views mincoinsgreedy(coins, value)
    end
    a::Array{Int64} = zeros(Int64, value)
    a[1] = 1
   inf = 7000
   @inbounds for i = 2:value
      @fastmath a[i] = inf
      q = inf
      j = lastindex(coins)
      @inbounds while q != 1 && j > 0
         if @views coins[j] < i
            q = @views min(q, @views a[i-coins[j]]+1)
         elseif i == @views coins[j]
            q = 1
            else
             break
         end
         @fastmath j -= 1

      end
      @views a[i] = q
   end
   return @views a[value]

end
@time mincoins([1000,500,100,20,5,1],8)




### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!
"""
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
"""
