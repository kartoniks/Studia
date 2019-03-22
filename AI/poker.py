# zadanie z 1. listy cwiczeniowej
from math import factorial

def choose(n,k):
  if(k>n):
    return 0
  return factorial(n)/(factorial(k)*factorial(n-k))
#how many pairs there are in deck of n cards of different rank
def pair(n):
  return choose(n,1)*choose(4,2)*choose(n-1, 3)*4**3

def twopair(n):
  return choose(n, 2)*choose(4,2)*choose(4,2)*(4*n-8)

def three(n):
  return choose(n,1)*choose(4,3)*choose(n-1,2)*4**2

def straightflush(n):
  return (n-4)*4

def straight(n):
  return (n-4)*4**5-straightflush(n)

def flush(n):
  return choose(n,5)*4-straightflush(n)

def fullhouse(n):
  return n*(n-1)*choose(4,3)*choose(4,2)

def four(n):
  return n*(4*n-4)

blot = [choose(36,5),
        pair(9),
        twopair(9),
        three(9),
        straight(9),
        flush(9),
        fullhouse(9),
        four(9),
        straightflush(9)]
fig = [choose(16,5),
        pair(4),
        twopair(4),
        three(4),
        straight(4),
        flush(4),
        fullhouse(4),
        four(4),
        straightflush(4)]

Omega = fig[0]*blot[0]

for i in range(1, len(fig)):#just low hands
  fig[0]-=fig[i]
  blot[0]-=blot[i]

b_wins = 0
for i in range(1, len(fig)):
  for j in range(0,i):
    b_wins += blot[i]*fig[j]
    
print(blot)
print(fig)
print(b_wins/Omega)