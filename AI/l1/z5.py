import random

size = 7
board = [[0 for x in range(size)] for y in range(size)]
rows = [2,2,7,7,2,2,2]
cols = [2,2,7,7,2,2,2]

def write():
  for i in board:
    print(i)
  print()

def swap(n,m):
  if board[n][m]==1:
    board[n][m] = 0
  else:
    board[n][m] = 1

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

def choose_field():
  row = random.randint(0,size-1)
  good_rows = 0
  # while(check_row(row)):
  #   row = (row+1)%size
  #   good_rows +=1
  #   if good_rows == size:
  #     break
  best_col = 0
  best_dif = 0
  print("Row:", row)
  col_bias = random.randint(0,size-1)
  for i in range(0, size):
    col = (col_bias+i)%size
    dif = difference(row, col)
    swap(row,col)
    newdif = difference(row,col)
    swap(row,col)
    if best_dif<dif-newdif:
      best_dif = dif-newdif
      best_col = col
    print(dif, newdif, "coords:", row, col, "improve by:", dif-newdif)
  print("chosen:",row,best_col)
  return (row, best_col)

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
        print("Found")
        return True
      f = choose_rand()
      swap(f[0],f[1])
    

def test():
  write()
  improve()
  write()
test()


