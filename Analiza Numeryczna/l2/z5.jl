function cof(k)
    if k == 2
        return 0.0
    end
    return (BigFloat(0.5) * (BigFloat(1 + cof(k-1))))^(BigFloat(0.5))
end

function pie(n)
    return BigFloat(BigFloat(2^(n-1)) * sqrt(BigFloat(BigFloat(0.5) * (1 - cof(n-1)))))
end

for i = 3:100
    x = pie(i)
    if x != 0
        println(pie(i))
    else
        println(i)
    end
end
