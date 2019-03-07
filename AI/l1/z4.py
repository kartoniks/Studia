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

def opt_dist2(bits, n):
  def count1(id):#check for n consecutive 1s starting at id
    ones=0
    for i in range(id, id+n):
      if bits[i]==1:
        ones += 1
    return ones
  bestid=0
  bestcount=0
  for i in range(0, len(bits)-n+1):
    newcount = count1(i)
    if bestcount < newcount:
      bestid=i
      bestcount=newcount
  tochange=0
  for i in range(0, len(bits)):
    if bestid<=i<bestid+n and bits[i]==0:
      tochange += 1
    if (bestid>i or bestid+n<=i) and bits[i]==1:
      tochange += 1
  return tochange


inp = open("zad4_input.txt", "r")
out = open("zad4_output.txt", "w")
for line in inp:
  line = line.split()
  l = list(map(lambda x: ord(x)-ord('0'), line[0]))
  arg2 = ord(line[1]) - ord('0') 
  out.write(str(opt_dist2(l, arg2))+"\n")

# print(opt_dist2([0,0,0,0,0,0,0,0,0,0,1], 1))
# print(correct([1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0], 4))
