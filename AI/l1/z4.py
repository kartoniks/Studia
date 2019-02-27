import copy
import itertools

def correct(bits, n):
  maks = len(bits)
  count = 0
  ind = 0
  while ind<maks and bits[ind]==0:
    ind+=1
  while ind<maks and bits[ind]==1:
    count+=1
    ind+=1
  while ind<maks:
    if bits[ind]==1:
      return False
    ind+=1
  return count == n

def opt_dist(bits, n):
  ind = list(range(0,len(bits)))
  for i in range(1, len(bits)):
    comb = itertools.combinations(ind, i)
    for c in comb:
      nbits = bits.copy()
      # print(c)
      for j in c:
        if nbits[j]==1:
          nbits[j]=0
        else:
          nbits[j]=1
      if correct(nbits, n):
        print(nbits)
        return i


print(opt_dist([0,0,1,0,0,0,1,0,0,0,0], 4))
# print(correct([1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0], 4))
