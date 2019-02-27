from collections import defaultdict
from statistics import stdev, mean
import random

# card_order_dict = {"2":2, "3":3, "4":4, "5":5, "6":6, "7":7, "8":8, "9":9, "10":10,"J":11, "Q":12, "K":13, "A":14}

def straight_flush(hand):
  return flush(hand) and straight(hand)

def four_of_a_kind(hand):
  values = [i[0] for i in hand]
  value_counts = defaultdict(lambda:0)
  for v in values: 
    value_counts[v]+=1
  return sorted(value_counts.values()) == [1,4]

def full_house(hand):
  values = [i[0] for i in hand]
  value_counts = defaultdict(lambda:0)
  for v in values:
    value_counts[v]+=1
  
  return sorted(value_counts.values()) == [2,3]

def flush(hand):
  suits = { i[1] for i in hand }
  return len(suits) == 1

def straight(hand):
  values = [c[0] for c in hand]
  counts = defaultdict(lambda: 0)
  for v in values:
    counts[v] += 1
  value_range = max(values) - min(values)
  return counts.values() == 1 and value_range == 4

def three_of_a_kind(hand):
    values = [i[0] for i in hand]
    value_counts = defaultdict(lambda:0)
    for v in values:
        value_counts[v]+=1
    return set(value_counts.values()) == { 3, 1 }
        
def two_pairs(hand):
    values = [i[0] for i in hand]
    value_counts = defaultdict(lambda:0)
    for v in values:
        value_counts[v]+=1
    if sorted(value_counts.values())==[1,2,2]:
        return True
    else:
        return False

def one_pairs(hand):
    values = [i[0] for i in hand]
    value_counts = defaultdict(lambda:0)
    for v in values:
        value_counts[v]+=1
    if 2 in value_counts.values():
        return True
    else:
        return False

def rank(hand):
  if straight_flush(hand):
    return 9
  if four_of_a_kind(hand):
    return 8
  if full_house(hand):
    return 7
  if flush(hand):
    return 6
  if straight(hand):
    return 5
  if three_of_a_kind(hand):
    return 4
  if two_pairs(hand):
    return 3
  if one_pairs(hand):
    return 2
  return 1

suits = [ 'C', 'S', 'H', 'D' ]

low_cards = [(i, s) for i in range(2, 11) for s in suits ]
high_cards = [(i, s) for i in range(11, 15) for s in suits]

def test_one(low_hand, high_hand):
  return rank(low_hand) > rank(high_hand)

def run(n, low_cards, high_cards):
  wins = 0
  for i in range(n):
    random.shuffle(low_cards)
    random.shuffle(high_cards)
    if test_one(low_cards[0:5], high_cards[0:5]):
      wins += 1
  return wins / n

def run_other_decks():
  for j in range(8):
    low_cards = [(i, s) for i in range(2+j, 11) for s in suits ]
    print("Chance with cards ", 2+j, "to 10: ", run(1000, low_cards, high_cards))
  for j in range(4):
    low_cards = [(i, s) for i in range(2, 11) for s in suits[1:j+2] ]
    print("Chance with ", j+1, "suits: ", run(2000, low_cards, high_cards))
  for j in range(25):
    low_cards = [(i, s) for i in range(2, 11) for s in suits[1:j+2] ]
    s = len(low_cards)
    low_cards = low_cards[:s-j]
    print("Chance without", j+1, "random cards: ", run(1000, low_cards, high_cards))
  
    
    
    

# print("Win chance:", run(10000, low_cards, high_cards))
run_other_decks()