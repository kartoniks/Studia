import random
from random import randint, sample

f = open('z2words.txt')
words = { s.strip() for s in f.readlines() }
m = max([len(x) for x in words])
f2 = open('zad2_input.txt')
texts = [s.strip() for s in f2.readlines()]

def random_divide(s):
  if(len(s)==0):
    return ''
  for r in range(100):
    i = random.randint(0, max(0,len(s)-1))
    j = i +1+ random.randint(0,m)
    if j>=len(s):
      j=len(s)
    if s[i:j] in words:
      l_word = random_divide(s[0:i])
      now = s[i:j]
      r_word = random_divide(s[j:])
      return l_word+' '+now+' '+r_word
  return s

def add_spaces(str):
  n = len(str)
  k = randint(0, n - 1)
  spaces = sample(range(1, n), k)
  spaces.extend([0, n])
  spaces.sort()
  # print(spaces)
  text = []
  for j in range(1, len(spaces)):
    text.append(str[spaces[j - 1]:spaces[j]])
  return text

def test():
  for t in texts:
    spaced = add_spaces(t)
    cnt=0
    while not all([ w in words for w in spaced]):
      spaced = add_spaces(t)
      cnt += 1
      if cnt==10000:
        break
    print(" ".join(spaced))

def test2():
  print(random_divide('alamakota'))
  for t in texts:
    print(" ".join(random_divide(t).split()))

test2()  
