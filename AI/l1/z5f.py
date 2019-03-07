import random

size = 7
board = [[1 for x in range(size)] for y in range(size)]
rows = [2,2,7,7,2,2,2]
cols = [2,2,7,7,2,2,2]

inp = open("zad5_input.txt", "r")
out = open("zad5_output.txt", "w")

def opt_dist(xs, D):
  ones = sum(xs)
  maximum = sum(xs[0:D])
  obecny = maximum
  for i in range(1, len(xs)-D+1):
    obecny += xs[i+D-1] - xs[i-1]
    maximum = max(maximum, obecny)
  toAdd = D - maximum
  toRemove = ones - maximum
  return toAdd + toRemove

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
  if board[n][m]==1:
    board[n][m] = 0
  else:
    board[n][m] = 1

def correct():
  for i in range(size):
    if row_dist(i)>0:
      return False
    if col_dist(i)>0:
      return False
  return True

def row_dist(n):
  return opt_dist(board[n], rows[n])
def col_dist(n):
  column = [board[i][n] for i in range(0, size)]
  return opt_dist(column, cols[n])

def board_dist():
  s = 0
  for i in range(0, size):
    s += row_dist(i)
    s += col_dist(i)
  return s

def choose_rand():
  if random.randint(0,1) ==1:
    row = random.randint(0,size-1)
    dist = 9999999
    best_id=0
    for col in range(row,row+size):
      col = col%size
      swap(row, col)
      next_dist = row_dist(row)+col_dist(col)
      if next_dist<dist:
        dist = next_dist
        best_id = col
      swap(row,col)
    col = best_id
    return (row, col)
  else:
    col = random.randint(0,size-1)
    dist = 9999999
    best_id=0
    for row in range(size):
      row = row%size
      swap(row, col)
      next_dist = row_dist(row)+col_dist(col)
      if next_dist<dist:
        dist = next_dist
        best_id = row
      swap(row,col)
    row = best_id
    return (row, col)

def debug():
  for i in range(size):
    print(board[i], opt_dist(board[i], rows[i]))
  for n in range(size):
    column = [board[i][n] for i in range(0, size)]
    print(' ', opt_dist(column, cols[n]), end='')
  print()

def improve():
  for j in range(100):
    for i in range(1000):
      if correct():
        # print("Found")
        return True
      f = choose_rand()
      swap(f[0],f[1])
    board = [[0 for x in range(size)] for y in range(size)]
    # debug()
    # print(j, end='')
    
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

test()


