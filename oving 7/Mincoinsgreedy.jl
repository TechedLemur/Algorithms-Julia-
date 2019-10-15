function mincoinsgreedy(coins, value)
    ans = 0
    for coin in coins
        while value >= coin
            ans += 1
            value = value - coin
        end
    end
    return ans
end
