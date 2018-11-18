function mult(M, V) #funkcja mnozaca macierze M V klasycznie
    R = zeros(size(M,1), size(V,2))
    for i = 1:size(M,1)
        for j = 1:size(V,2)
            for k = 1:size(M,1)
                R[i,j] += M[i,k] * V[k,j]
            end
        end
    end
    return R
end

function strassen(A, B, size, stop) #algorytm Strassena, mnozy macierze A, B o rozmiarze size
   if size <= stop
      return mult(A,B)
   end
   half = div(size,2)
   a11 = A[1:half, 1:half]
   a12 = A[1:half, half+1:size]
   a21 = A[half+1:size, 1:half]
   a22 = A[half+1:size, half+1:size]

   b11 = B[1:half, 1:half]
   b12 = B[1:half, half+1:size]
   b21 = B[half+1:size, 1:half]
   b22 = B[half+1:size, half+1:size]

   m1 = strassen(a11 + a22, b11 + b22, half, stop)
   m2 = strassen(a21 + a22, b11, half, stop)
   m3 = strassen(a11, b12 - b22, half, stop)
   m4 = strassen(a22, b21 - b11, half, stop)
   m5 = strassen(a11 + a12, b22, half, stop)
   m6 = strassen(a21 - a11, b11 + b12, half, stop)
   m7 = strassen(a12 - a22, b21 + b22, half, stop)

   c11 = m1 + m4 - m5 + m7
   c12 = m3 + m5
   c21 = m2 + m4
   c22 = m1 - m2 + m3 + m6

   res = vcat(hcat(c11, c12), hcat(c21, c22))
   return res
end
function s_mult(A,B,stop)
   edge1 = size(A, 1)
   edge2 = size(A, 2)
   pow2 = 2^Integer(ceil(max(log(2, edge2),
                             log(2, edge1))))
   if edge1 < pow2 || edge2 < pow2
      zero_ = zeros(pow2-edge1, edge2)
      A = vcat(A, zero_)
      zero_ = zeros(size(A, 1), pow2-edge2)
      A = hcat(A, zero_)    
      zero_ = zeros(edge2, pow2-edge1)
      B = hcat(B, zero_)
      zero_ = zeros(pow2-edge2, size(B,2))
      B = vcat(B, zero_)
   end

   res = strassen(A,B, pow2, stop)
   return res[1:edge1, 1:edge1]
end


function err(M)
   r = size(M, 1)
   c = size(M, 2)
   sum = Float64(0)
   for i in 1:r
      for j in 1:c
         k = M[r,c]
         sum += k*k
      end
   end
    return sum
end

function bestStrass(A, B)
   return s_mult(A, B, 64)
end

#przykładowy test:
#D = rand(-100.0:0.001:100.0, 256, 256)
#@timev println(err(test_normal(D,D,D,4)))
#@timev println(err(test_str(D,D,D,4)))
function testAA()
    for i in 1024:32:1024    #pomiar czasu dla strassena, różne wielkosci
        D = rand(-100.0:0.01:100.0, i, i)
        println(@elapsed s_mult(D,D))
    end
end
#testAA()

# Testowanie błędów i czasów w obliczaniu (A*B)*C - A*(B*C)
function err(M)
    sum = Float64(0)
    for i in Base.eachindex(M)
        k = M[i]
        sum += k*k
    end
    return sum
end

function test_normal(A,B,C)
    return mult(mult(A,B),C) - mult(A, mult(B,C))
end

function test_str(A,B,C,stop)
    return s_mult(s_mult(A,B,stop),C, stop) - s_mult(A,s_mult(B,C, stop), stop)
end

function compare()
    M_size = 64
    for i in 1:10
        A = rand(-100.0:0.001:100.0, M_size, M_size)
        B = rand(-100.0:0.001:100.0, M_size, M_size)
        C = rand(-100.0:0.001:100.0, M_size, M_size)
        S_result = test_str(A,B,C, 64)
        N_result = test_normal(A,B,C)
        println(err(S_result))
        println(err(N_result))
        println("Blad wzgledny:", abs(err(S_result) - err(N_result)) / err(N_result) )
    end
end
#compare()
function memory_usage()
    M_size = 512
    A = rand(-100.0:0.001:100.0, M_size, M_size)
    B = rand(-100.0:0.001:100.0, M_size, M_size)
    @timev mult(A,B)
    @timev s_mult(A,B, 64)
end
#memory_usage()
