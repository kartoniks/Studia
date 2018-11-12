# DO UŻYCIA WYSTARCZY OSTATNIA FUNKCJA 'doIt' PODAJE SIĘ JEJ LICZBE POWTORZEŃ DLA ALGORYTMU N^3 oraz strassena(stop=64) rysuje wykres łączony na ktorym widać czasy obu algorytmow dla rozmiarow 4-1024
using Plots
using LinearAlgebra
include("strassen.jl")
include("CzasuWyniki.jl")


function test_normal_czasu(ile, size)
    wynik = Float64(0)
    for i in 1:ile
        A = rand(-100.0:0.01:100.0, size, size)
        B = rand(-100.0:0.01:100.0, size, size)
        w = (@elapsed mult(A, B))
        wynik += w
    end
    wynik /= ile
    return wynik
end

function ttest_normal_czasu(ile)
    ind = Int64[]
    wyniki = Float64[]
    for i in 4:1:1024
        w = test_normal_czasu(ile, i)

        ind = vcat(ind, [i])
        wyniki = vcat(wyniki, [w])
    end
    return ind, wyniki
end
function plot_time_normal(ind, wart)
    indeksy, wyniki = ind, wart
    Plots.plot(indeksy, wyniki, line=(:scatter, 1), lab = "normalny", ms=1)
    xlabel!("Rozmiar macierzy")
    ylabel!("czas (s)")
    title!("Czas algorytmu n^3")
    savefig("normalny.jpg")
    return false
end



function test_strassen_czasu(ile, size)
    wynik = Float64(0)
    for i in 1:ile
        A = rand(-100.0:0.01:100.0, size, size)
        B = rand(-100.0:0.01:100.0, size, size)
        w = (@elapsed s_mult(A, B, 64))
        wynik += w
    end
    wynik /= ile
    return wynik
end
 # test_strassen_czasu(1,4096)
function ttest_strassen_czasu(ile)
    ind = Int64[]
    wyniki = Float64[]
    for i in 2:10
        pow = 2 ^ i

        w = test_strassen_czasu(ile, pow)
        ind = vcat(ind, [pow])
        wyniki = vcat(wyniki, [w])
    end
    return ind,wyniki
end
# ind, wynik = ttest_strassen_czasu(20)


function plot_time_strass(ind, wart)
    indeksy, wyniki = ind, wart
    Plots.plot(indeksy, wyniki, line=(:steppre, 1), lab = "strass")
    xlabel!("Rozmiar macierzy")
    ylabel!("czas (s)")
    title!("Czas algorytmu strassena")
    savefig("strass.jpg")
    return false
end

# plot_time_strass(ind, wynik)


function wypelnij_strass(indn, wart)
    poprawka = indn[1] - 1
    newInds = map(i->Int(ceil(log2(i)) - 1), indn)
    wyn = map(i->wart[newInds[i - poprawka]], indn)
    return wyn
end


function plottuj_oba(ind, wn, ws)
    indeksy, wyniki = ind, hcat(wn, ws)
    Plots.plot(indeksy, wyniki, line=([:scatter :steppre], 3), lab = ["normalny", "strass"], ms=5)
    xlabel!("Rozmiar macierzy")
    ylabel!("czas (s)")
    title!("Czas algorytmow normalnego i  strassena")
    savefig("oba.jpg")
    return false
end

# plottuj_oba(indeksyNormal, wynikiNormal, wynikiPrzeindeksowaneStrass)


function doIt(ileNormal, ileStrassen)
    indN, restN = ttest_normal_czasu(ileNormal)
    indS, resS = ttest_strassen_czasu(ileStrassen)

    resS1 = wypelnij_strass(indN, resS)
    plottuj_oba(indN, resN, resS1)
    return
end

function obaPot(ile=20, start_ = 4, end_ = 1024)
    s = Int(floor(log2(start_)))
    e = Int(floor(log2(end_)))
    ind = Int64[]
    svals = Float64[]
    nvals = Float64[]

    # s += 1
    for i in s:e
        pow = 2^i
        sw = Float64(0)
        nw = Float64(0)
        for j in 1:ile
            A = rand(-100.0:0.01:100.0, pow, pow)
            B = rand(-100.0:0.01:100.0, pow, pow)

            sw1 = (@elapsed bestStrass(A, B))
            nw1 = (@elapsed mult(A, B))

            sw += sw1
            nw += nw1
        end

        sw /= ile
        nw /= ile

        ind = vcat(ind, [pow])
        svals = vcat(svals, [sw])
        nvals = vcat(nvals, [nw])
    end

    return ind, svals, nvals
end
t = test_normal_czasu(1, 4096)
t
ts = test_strassen_czasu(1, 4096)

i, s, v = obaPot(20, 4, 1024)

print(v)

ind = [4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096]
vs = [2.827e-7, 9.7675e-7, 1.13864e-5, 6.7521e-5, 0.0005998, 0.00421873, 0.0304357, 0.258856, 1.82804, 12.6364, 95.074557115]
vn = [2.313e-7, 7.9675e-7, 1.12321e-5, 6.88323e-5, 0.000578544, 0.00521803, 0.0416395, 0.39834, 6.66768, 82.5707, 834.604167245]



plottuj_oba(ind, vn, vs)
