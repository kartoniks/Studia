f = open('z2words.txt')
words = { s.strip() for s in f.readlines() }

f2 = open('zad2_input.txt')
out = open('zad2_output.txt', 'w')
texts = [s.strip() for s in f2.readlines()]
# print(text)
m = max([len(x) for x in words])

def divide(text):
    n = len(text)
    score = [-1 for i in range(n+1)]
    partition = [0 for i in range(n+1)]
    score[0] = 0

    for i in range(n+1):
        for j in range(max(0, i - m - 1), i + 1):
            if(score[j] != -1):
                # print(text[j:i])
                if(text[j:i] in words):
                    # print("caught text:   "+text[j:i])
                    nextscore = (i - j) ** 2
                    if(score[i] < score[j] + nextscore):
                        score[i] = score[j] + nextscore
                        partition[i] = i-j
    cuts = []
    # print(partition)
    i = n
    while(partition[i] != 0):
        # print(text[i-partition[i]:i])
        cuts.append(text[i-partition[i]:i])
        i -= partition[i]
    cuts.reverse()
    cuts = " ".join(cuts)
    # print(cuts)
    return cuts

for t in texts:
    out.write(divide(t) + "\n")