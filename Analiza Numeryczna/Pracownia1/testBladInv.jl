using Plots
using LinearAlgebra
include("strassen.jl")

function bestStrass(A,B)
   s_mult(A,B,64)
end


# Dla Danego rozmiaru, 1 iteracja
function test_inv(s)
   A =  rand(-100.0:0.01:100.0, s, s)
   Ainv = inv(A)
   Id = Matrix{Float64}(I, s, s)

   a1 = mult(A, Ainv)
   a1 = a1 - Id
   e1 = err(a1)

   a2 = mult(Ainv, A)
   a2 = a2 - Id
   e2 = err(a2)

   b1 = bestStrass(A, Ainv)
   b1 = b1 - Id
   d1 = err(b1)

   b2 = bestStrass(Ainv, A)
   b2 = b2 - Id
   d2 = err(b2)

   return [e1, e2, d1, d2]
end
# test_inv(8)


# Dla danego rozmiaru i ilości iteracji -> średnia błędu
function ttest_inv(ile, s)
   wynik = zeros(Float64, 4)
   for i in 1:ile
      k = test_inv(s)
      wynik += k
   end
   wynik /= ile
   return wynik
end
# ttest_inv(1,8)

# Base.BigFloat(MathConstants.pi, 1000)

# Dla ilości iteracji -> średnia błędów dla potęg dwójki 4-1024
function tttest_inv(ile)
   wyniki = ttest_inv(ile, 4)
   ind = Int64[4]
   for i in 3:10
      pow = 2 ^ i
      w = ttest_inv(ile, pow)

      ind = vcat(ind, [pow])
      wyniki = hcat(wyniki, w)
   end
   return ind, transpose(wyniki)
end
# tttest_inv(1)
# i,W = tttest_inv(1)


function plottuj(wyn, ind=[4,8,16,32,64,128,256,512,1024], name="pinvy")

   labe = ["mult(A, Ainv)", "mult(Ainv, A)", "bestStrass(A, Ainv)", "bestStrass(Ainv, A)"]

   p1 = Plots.plot()
   w1 = wyn * 10^18
   plot!(ind, w1, lab = labe)
   title!("bledy bezwzgledne przy A * Ainv")
   xlabel!("rozmiar macierzy")
   ylabel!("blad * 10^18")

   savefig(name)
end

function doIt(ile=20, name="invy")
   ind, wyniki = tttest_inv(ile)
   plottuj(wyniki, ind, name)
   return ind, wyniki
end
ind, Wy = doIt(20, "bledyInv")
plottuj(Wy)
