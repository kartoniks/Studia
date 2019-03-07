import random

size = 7
board = [[0 for x in range(size)] for y in range(size)]
rows = [2,2,7,7,2,2,2]
cols = [2,2,7,7,2,2,2]

inp = open("zad5_input.txt", "r")
out = open("zad5_output.txt", "w")

def write():
  for x in range(0, size):
    for y in range(0,size):
      if(board[x][y]==0):
        board[x][y] = '.'
      else:
        board[x][y] = '#'
  for i in board:
    str1 = ''.join(str(e) for e in i)
    out.write(str1+"\n")

def swap(n,m):
  board[n][m]^=1

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

def check_row(n):
  return correct(board[n], rows[n])
def check_col(n):
  column = [board[i][n] for i in range(0, size)]
  return correct(column, cols[n])
def check_board():
  for i in range(0,size):
    if check_row(i)==False:
      return False
  for i in range(0,size):
    if check_col(i)==False:
      return False
  return True


def difference(n,m):
  rowval = sum(board[n])
  column = [board[i][m] for i in range(0, size)]
  colval = sum(column)
  dif = abs(rowval-rows[n])+abs(colval-cols[m])
  return dif

def choose_rand():
  for i in range(0, size*size):
    row = random.randint(0,size-1)
    col = random.randint(0,size-1)
    dif = difference(row, col)
    swap(row,col)
    newdif = difference(row,col)
    swap(row,col)
    if newdif<dif:
      return(row,col)
  return (row, col)

def improve():
  for j in range(10):
    for i in range(1000):
      if check_board():
        print("Found!")
        return True
      f = choose_rand()
      swap(f[0],f[1])
    

def test():
  # write()
  improve()
  write()

args=[]
for lines in inp:
  lines = lines.split()
  args.append(lines)
for i in range(0, ord(args[0][0])-ord('0')):
  rows[i] = ord(args[i+1][0])-ord('0')
  cols[i] = ord(args[i+8][0])-ord('0')
# print(cols)
# print(args)
test()


