from operator import add
from collections import deque
import copy

class State:
    def __init__(self, t, wk, wr, bk, h=[]):
        def convert(char):
            if(char>'9'):
                return ord(char) - 96
            else:
                return ord(char) - 48
        self.history = h.copy()
        if(t==0 or t==1):
            self.turn = t
            self.w_king = wk.copy()
            self.w_rook = wr.copy()
            self.b_king = bk.copy()
        else:
            self.w_king = []
            self.w_rook = []
            self.b_king = []
            self.w_king.append( convert(wk[0]) )
            self.w_king.append( convert(wk[1]) )
            self.w_rook.append( convert(wr[0]) )
            self.w_rook.append( convert(wr[1]) )
            self.b_king.append( convert(bk[0]) )
            self.b_king.append( convert(bk[1]) )
            if(t=='white'):
                self.turn = 1
            if(t=='black'):
                self.turn = 0
        self.position = [self.w_king, self.w_rook, self.b_king]
        self.history.append(self.position)
        # print(len(self.history))

    def legal(self, who, direction):
        if(who == 'wk'):
            if(1 <= self.w_king[0]+direction[0] <= 8 and 
               1 <= self.w_king[1]+direction[1] <= 8 and
               (abs(self.w_king[0]+direction[0] - self.b_king[0]) > 1 or
               abs(self.w_king[1]+direction[1] - self.b_king[1]) > 1)):
                return True
        if(who == 'wr'):
            if(1 <= self.w_rook[0]+direction[0] <= 8 and 
               1 <= self.w_rook[1]+direction[1] <= 8 and
               (self.w_rook[0]+direction[0] != self.b_king[0] or self.w_rook[1]+direction[1] != self.b_king[1]) and
               (self.w_rook[0]+direction[0] != self.w_king[0] or self.w_rook[1]+direction[1] != self.w_king[1])):
                return True
        if(who == 'bk'):
            if(1 <= self.b_king[0]+direction[0] <= 8 and 
               1 <= self.b_king[1]+direction[1] <= 8 and
               (abs(self.b_king[0]+direction[0] - self.w_king[0]) > 1 or
               abs(self.b_king[1]+direction[1] - self.w_king[1]) > 1) and
               self.b_king[0]+direction[0] != self.w_rook[0] and
               self.b_king[1]+direction[1] != self.w_rook[1]):
                return True
        return False

    def addmoves(self):
        moves = []
        if(self.turn == 0):
            for i in range(-1, 2):
                for j in range(-1, 2):
                    if(j!=0 or i!=0):
                        direction = [i,j]
                        if(self.legal('bk', direction)):
                            moves.append(State(1, self.w_king, self.w_rook, list(map(add, self.b_king, direction)), self.history))
        if(self.turn == 1):
            for i in range(-1, 1):
                for j in range(-1, 1):
                    if(j!=0 or i!=0):
                        direction = [i,j]
                        if(self.legal('wk', direction)):
                            moves.append(State(0, list(map(add, self.w_king, direction)), self.w_rook, self.b_king, self.history))
            for i in range(-7, 8):
                direction = [0, i]
                if(self.legal('wr', direction)):
                    moves.append(State(0, self.w_king, list(map(add, self.w_rook, direction)), self.b_king, self.history))
                direction = [i, 0]
                if(self.legal('wr', direction)):
                    moves.append(State(0, self.w_king, list(map(add, self.w_rook, direction)), self.b_king, self.history))
        return moves

    def mate(self):
        newmoves = self.addmoves()
        if(self.turn==0 and len(newmoves)==0 and
           (self.w_rook[0] == self.b_king[0] or self.w_rook[1] == self.b_king[1])):
            return True
        return newmoves

def runfromstate(st):
    stateQ = [st]
    while(len(stateQ)>0):
        nowState = stateQ.pop(0)
        mateormoves = nowState.mate()
        if(mateormoves==True):
            print(len(nowState.history))
            return nowState.history
        # print(len(nowState.history))
        stateQ = stateQ + mateormoves
        
def readfile():
    f = open("zad1_input.txt", "r")
    for l in f:
        l = l.split()
        state = State(l[0], l[1], l[2], l[3])
        print(runfromstate(state))


readfile()
# mys = State('black', 'g6', 'a1', 'g8')
# print(runfromstate(mys))
# print(mys.addmoves())

