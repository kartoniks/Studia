f = open('z2words.txt')
words = { s.strip() for s in f.readlines() }

text = 'tamatematykapustkinieznosi'

m = max([len(x) for x in words])
n = len(text)

score = [-1 for i in range(n)]
partition = [0 for i in range(n)]
score[0] = 0

for i in range(n):
    for j in range(max(0, i - m - 1), i + 1):
        if(score[j] != -1):
            if(text[j:i] in words):
                nextscore = (i - j) ** 2
                if(score[i] < score[j] + nextscore):
                    score[i] = score[j] + nextscore
                    partition[i] = j
            elif(i == j + 1 and text[j:i] == '\n'):
                score[i] = score[j]
                partition[i] = partition[j]
            # print(partition)

cuts = []
i = n - 1
while(partition[i] != 0):
    i = partition[i]
    cuts.append(i)
cuts.reverse()

def join_text(text, cuts):
    res = []
    # print(cuts)
    # print(text[21:-1])
    cuts = [ 0 ] + cuts
    for i in range(len(cuts) - 1):
        res.append(text[cuts[i]:cuts[i+1]])
    res.append(text[cuts[-1]:])
    return " ".join(res)

res = join_text(text, cuts)
print(words)