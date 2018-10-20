x=[1 1 1 1;
   0 1 1 1;
   0 0 1 1;
   0 0 0 1]


function strassen(A, B, size) #algorytm Strassena, mnozy macierze A, B o rozmiarze size
   if size == 1
      return A*B
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

   m1 = strassen(a11 + a22, b11 + b22, half)
   m2 = strassen(a21 + a22, b11, half)
   m3 = strassen(a11, b12 - b22, half)
   m4 = strassen(a22, b21 - b11, half)
   m5 = strassen(a11 + a12, b22, half)
   m6 = strassen(a21 - a11, b11 + b12, half)
   m7 = strassen(a12 - a22, b21 + b22, half)

   c11 = m1 + m4 - m5 + m7
   c12 = m3 + m5
   c21 = m2 + m4
   c22 = m1 - m2 + m3 + m6

   res = vcat(hcat(c11, c12), hcat(c21, c22))
   return res
end

print(strassen(x,x,4))
