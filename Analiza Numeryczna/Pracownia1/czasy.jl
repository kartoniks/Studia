# TESTY CZASU, NA DOLE W TEXU, WYDAJE MI SIE ZE 128 JEST NAJLEPSZE, ZROBIE PROGRAM DO LICZENIA SREDNIEJ Z WIELU ZEBY MIEC DOKLADNE WYNIKI
using Winston

function Mv(M, v)
    res = zeros(size(M,1), 1)
    for i = 1:size(M, 1)
        for j = 1:size(M, 2)
          res[i] += M[i,j] * v[i]
        end
    end
    return res
end
function column(M, c)
    v = zeros(size(M,1),1)
    for i = 1:size(M,1)
        v[i] = M[i,c]
    end
    return v
end
function mult(M, V)
    R = Array{Float64}(undef, size(M,1), 0)
    for i = 1:size(V,2)
        R = hcat(R, Mv(M, column(V, i)))
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

function t(size, stop, ile)
   i = ile
   wynik = 0.0
   while (i>0)
      A = rand(-100.0:0.01:100.0, size, size)
      B = rand(-100.0:0.01:100.0, size, size)
      wynik += (@elapsed s_mult(A, B, stop))
      i -= 1
   end
   wynik /= ile
   return wynik
end
function tt(size, ile)
   s = Int(log2(size))
   wyniki = zeros(9)
   for st in 2:10
      wyniki[st-1] = t(size, 2^st, ile)
   end
   return wyniki
end
function ttt(ile)
   wyniki = tt(4,ile)
   for si in 3:10
      wyniki = hcat(wyniki, tt(2^si, ile))
   end
   return wyniki
end

ile = 50
# wyniki ustawione są kolumnami więc pierwszy wiersz nawiasu opisuje czasy dla kolejnych potęg dwjki dla momentu przejścia = 4, potem 8 itd. ...
# ewentualnie jeśli wolisz to transpose(Wyniki) i będzi wierszami
# Wyniki = ttt(ile)
# # print(transpose(Wyniki))
W4 = tt(4,ile)
W8 = tt(8,ile)
W16 = tt(16,ile)
W32 = tt(32,ile)
W64 = tt(64,ile)
W128 = tt(128,ile)
W256 = tt(256,ile)
W512 = tt(512,ile)
W1024 = tt(1024,ile)


rozmiary = [4;8;16;32;64;128;512;1024]
stopy = [4;8;16;32;64;128;512;1024]
p = Winston.plot()







# function wypisz(wyniki)
#    for i in 0:9
#       print()
#       for j in 1:10


# rozmiar\stop    4	  ,8		,16		,32		,64		,128		,256	,512	,1024
# 	4	,1.029e-6    , 0.0        ,  0.0        ,  0.0        ,  0.0         , 0.0        , 0.0       , 0.0      , 0.0
# 	8	,2.1076e-5   , 2.57e-6    ,  0.0        ,  0.0        ,  0.0         , 0.0        , 0.0       , 0.0      , 0.0
# 	16	,6.1173e-5   , 1.7992e-5  ,  9.767e-6   ,  0.0        ,  0.0         , 0.0        , 0.0       , 0.0      , 0.0
# 	32	,0.000387598 , 0.000135197,  6.3229e-5  ,  4.9864e-5  ,  0.0         , 0.0        , 0.0       , 0.0      , 0.0
# 	64 	,0.0117215   , 0.00114377 , 0.000483727 , 0.000408674 , 0.000507373  , 0.0        , 0.0       , 0.0      , 0.0
# 	128 	,0.0320745   , 0.0121826  ,  0.00607614 ,  0.00287152 ,  0.00304064  , 0.00536572 , 0.0       , 0.0      , 0.0
# 	256 	,0.218867    , 0.0643613  ,  0.0324472  ,  0.0250777  ,  0.0218654   , 0.0247168  , 0.0358328 , 0.0      , 0.0
# 	512 	,1.39026     , 0.428919   ,  0.329012   ,  0.229301   ,  0.257918    , 0.17839    , 0.380727  , 0.406246 , 0.0
# 	1024	,9.95528     , 3.25025    ,  1.86362    ,  1.48972    ,  1.48474     , 1.58493    , 2.4041    , 3.19119  , 7.39681
