from collections import deque
from operator import add
import copy

visited=set()
stateQ=deque([])
def parse(t, wk, wr, bk, h=[]):
    def convert(char):
        if(char>'9'):
            return ord(char) - 96
        else:
            return ord(char) - 48
    wk = [convert(wk[0]), convert(wk[1])]
    wr = [convert(wr[0]), convert(wr[1])]
    bk = [convert(bk[0]), convert(bk[1])]
    if(t=='white'):
        turn = 1
    if(t=='black'):
        turn = 0
    return (turn, wk[0], wk[1], wr[0], wr[1], bk[0], bk[1], [])
        
    
def legal(state, who, dir):
    turn = state[0]
    wk = [state[1], state[2]]
    wr = [state[3], state[4]]
    bk = [state[5], state[6]]
    history = state[7]
    if(who == 'wk'):
        if(1 <= wk[0]+dir[0] <= 8 and 
            1 <= wk[1]+dir[1] <= 8 and
            (abs(wk[0]+dir[0] - bk[0]) > 1 or
            abs(wk[1]+dir[1] - bk[1]) > 1)):
            return True
    if(who == 'wr'):
        if(1 <= wr[0]+dir[0] <= 8 and 
            1 <= wr[1]+dir[1] <= 8 and
            (wr[0]+dir[0] != bk[0] or wr[1]+dir[1] != bk[1]) and
            (wr[0]+dir[0] != wk[0] or wr[1]+dir[1] != wk[1])):
            return True
    if(who == 'bk'):
        if(1 <= bk[0]+dir[0] <= 8 and 
            1 <= bk[1]+dir[1] <= 8 and
            (abs(bk[0]+dir[0] - wk[0]) > 1 or
            abs(bk[1]+dir[1] - wk[1]) > 1) and
            (bk[0]+dir[0] != wr[0] or bk[0]+dir[0] == wr[0] == wk[0] and (bk[1]+dir[1]<wk[1]<wr[1] or bk[1]+dir[1]>wk[1]>wr[1])) and
            (bk[1]+dir[1] != wr[1] or bk[1]+dir[1] == wr[1] == wk[1] and (bk[0]+dir[0]<wk[0]<wr[0] or bk[0]+dir[0]>wk[0]>wr[0]))):
            return True
    return False

def alreadysearched(s):
    if(s in visited):
        return True
    visited.add(s)
    return False

def addmoves(state):
    global stateQ
    turn = state[0]
    wk = [state[1], state[2]]
    wr = [state[3], state[4]]
    bk = [state[5], state[6]]
    history = state[7]
    nonzero = False
    if(turn == 0):
        for i in range(-1, 2):
            for j in range(-1, 2):
                if(j!=0 or i!=0):
                    dir = [i,j]
                    if(legal(state, 'bk', dir)):
                        nonzero=True
                        newhis = copy.deepcopy(history)
                        newhis.append(['bk', dir[0], dir[1]])
                        state_new = (1, wk[0], wk[1], wr[0], wr[1], bk[0]+dir[0], bk[1]+dir[1], newhis)
                        if(alreadysearched(state_new[0:7])):
                            continue
                        stateQ.append(state_new)
    if(turn == 1):
        for i in range(-1, 2):
            for j in range(-1, 2):
                if(j!=0 or i!=0):
                    dir = [i,j]
                    if(legal(state, 'wk', dir)):
                        nonzero=True
                        newhis = copy.deepcopy(history)
                        newhis.append(['wk', dir[0], dir[1]])
                        state_new = (0, wk[0]+dir[0], wk[1]+dir[1], wr[0], wr[1], bk[0], bk[1], newhis)
                        if(alreadysearched(state_new[0:7])):
                            continue
                        stateQ.append(state_new)
        for i in range(-7, 8):
            dir = [0, i]
            if(legal(state, 'wr', dir)):
                nonzero=True
                newhis = copy.deepcopy(history)
                newhis.append(['wr', dir[0], dir[1]])
                state_new = (0, wk[0], wk[1], wr[0]+dir[0], wr[1]+dir[1], bk[0], bk[1], newhis)
                if(1<wr[1]+dir[1]<8 or alreadysearched(state_new[0:7])):
                    continue
                stateQ.append(state_new)
            dir = [i, 0]
            if(legal(state, 'wr', dir)):
                nonzero=True
                newhis = copy.deepcopy(history)
                newhis.append(['wr', dir[0], dir[1]])
                state_new = (0, wk[0], wk[1], wr[0]+dir[0], wr[1]+dir[1], bk[0], bk[1], newhis)
                if(1<wr[1]+dir[1]<8 or alreadysearched(state_new[0:7])):
                    continue
                stateQ.append(state_new)
    return nonzero

def mate(state):
    turn = state[0]
    wr = [state[3], state[4]]
    bk = [state[5], state[6]]
    canmove = addmoves(state)
    if(turn==0 and (not canmove) and
        (wr[0] == bk[0] and abs(wr[1]-bk[1]>1) or wr[1] == bk[1] and abs(wr[0]-bk[0]>1))):
        return True
    return False

def runfromstate(st):
    stateQ.append(st)
    while(stateQ):
        nowState = stateQ.popleft()
        history = copy.deepcopy(nowState[7])
        print(len(history))
        if(mate(nowState)):
            return history
        
def readfile():
    global visited
    global stateQ
    f = open("zad1_input.txt", "r")
    for l in f:
        l = l.split()
        mystate = parse(l[0], l[1], l[2], l[3])
        visited=set()
        stateQ=deque([])
        # print(legal(mystate, 'wk', [1,0]))
        print(runfromstate(mystate))

readfile()