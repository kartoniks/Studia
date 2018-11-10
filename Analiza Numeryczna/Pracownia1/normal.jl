
function Mv(M, v)
    res = zeros(size(M,1), 1)
    for i = 1:size(M, 1)
        for j = 1:size(M, 2)
            res[i] += M[i,j] * v[i]
        end
    end
    return res
end

# wyciąga c-tą kolumnę macierzy M i tworzy z niej pionowy wektor
function column(M, c)
    v = zeros(size(M,1),1)
    for i = 1:size(M,1)
        v[i] = M[i,c]
    end
    return v
end
# # wyciąga r-ty wiersz macierzy M i tworzy z niego pionowy wektor
# function row(M, r)
#     v = zeros(size(M,2), 1)
#     for i = 1:size(M,2)
#         v[i] = M[r,i]
#     end
#     return v
# end

function mult(M, V)
    R = Array{Float64}(undef, size(M,1), 0)
    for i = 1:size(V,2)
        R = hcat(R, Mv(M, column(V, i)))
    end
    return R
end


# Testowanie błędów i czasów w obliczaniu (A*B)*C - A*(B*C)
function err(M)
    sum = Float64(0)
    for i in Base.eachindex(M)
        k = M[i]
        sum += k*k
    end
    return sum
end

function test(f)
    for i in 4:10:500
        A = rand(-100.0:0.01:100.0, i, i)
        B = rand(-100.0:0.01:100.0, i, i)
        C = rand(-100.0:0.01:100.0, i, i)
        println(i, " ", err(f(A,B,C,i)))
    end
end

function test_normal(A,B,C,s)
   return (A*B)*C - A*(B*C)
end
function test_my_normal(A,B,C,s)
    return mult(mult(A,B),C) - mult(A,mult(B,C))
end
D = rand(-100.0:0.01:100.0, 500, 500)
#@timev println(err(test_normal(D,D,D,4)))

# for i in 4:10:50
#     M = ones(Float64,i,i)
#     println(i, " ", mult(M,M))
# end
t=[1 2;
   3 4]
       z=[2 0;
          1 2]
println(mult(t,z))
for i in 1024:32:1024    #test dla strassena, różne wielkosci
    D = rand(-100.0:0.01:100.0, i, i)
    #println(err(mult(D,D)))
end
# test(test_my_normal)
