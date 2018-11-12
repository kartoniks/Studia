# pierwsza współrzędna x, musi być taka sama jak pierwsza współrzędna y, tyle ile size(y, 2) tyle wykresów
# Skoro czas w zależności od zmiany = {32, 64, 128} jest bardzo podobny, sprawdźmy jakie są błędy dla każdego z tych sposobów, przy rozmiarach z zakresu 128-2048
using Plots
using LinearAlgebra
include("strassen.jl")

function strassStop(A, B, stop)
    return s_mult(A, B, stop)
end

function jakas(s)
    A =  rand(-100.0:0.01:100.0, s, s)
    Ainv = inv(A)
    Id = Matrix{Float64}(I, s, s)


    b1 = strassStop(A, Ainv, 32)
    b1 = b1 - Id
    d1 = err(b1)

    b2 = strassStop(Ainv, A, 32)
    b2 = b2 - Id
    d2 = err(b2)

    b3 = strassStop(A, Ainv, 64)
    b3 = b3 - Id
    d3 = err(b3)

    b4 = strassStop(Ainv, A, 64)
    b4 = b4 - Id
    d4 = err(b4)


    b5 = strassStop(A, Ainv, 128)
    b5 = b5 - Id
    d5 = err(b5)

    b6 = strassStop(Ainv, A, 128)
    b6 = b6 - Id
    d6 = err(b6)

    return [d1,d3,d5], [d2,d4,d6]
end

# a = jakas(1024)

function tjakas(ile, s)
    w, wi = zeros(Float64, 3), zeros(Float64, 3)
    for i in 1:ile
        k, ki = jakas(s)

        w += k
        wi += ki
    end
    w /= ile
    wi /= ile
    return w, wi
end

# h, hi = tjakas(5,1024)
# print(h)
# print(hi)

function ttjakas(ile, start_=128, end_=2048)
    s,e = Int(log2(start_)), Int(log2(end_))

    w,wi = tjakas(ile, start_)
    ind = [start_]
    s+=1
    for i in s:e
        pow = 2^i
        k, ki = tjakas(ile, pow)

        w,wi = hcat(w, k), hcat(wi, ki)
        ind = vcat(ind, [pow])
    end

    return ind, w, wi
end

# ind, A, Ai = ttjakas(10, 128, 1024)
# print(ind)
# print(A)
# print(Ai)
# hcat(A, Ai)
# a = A * 10^18
# ai = Ai * 10^18
# Plots.plot(ind, transpose(vcat(a, ai)))
# transpose(vcat(a,ai))
# vcat(a, ai)


function plottuj(wart, ind, name="sprawdzBladOdStopa2")
    labe = ["A*inv(A) zmiana = 32", "A*inv(A) zmiana = 64", "A*inv(A) zmiana = 128", "inv(A)*A zmiana = 32", "inv(A)*A zmiana = 64", "inv(A)*A zmiana = 128"]
    markercolors = [:green :orange :black :purple :red  :brown]
    markershapes = [:circle]

    p = Plots.plot()
    plot!(ind, wart, lab=labe, shape = markershapes, color = markercolors)
    # scatter!(ind, wart, lab=labe)
    title!("Bledy Strassena w zaleznosci od rozmiaru zmiany")
    xlabel!("Rozmiar")
    ylabel!("blad bezwzgledny * 10^18")

    savefig(name)
end

function doIt(ile, name="sprawdzBladOdStopa")
    ind, A, Ai = ttjakas(ile)
    a = A * 10^18
    ai = Ai * 10^18

    plottuj(transpose(vcat(a, ai)), ind)
    return  ind, A, Ai
end
indeksy, be, bei = doIt(20)
# indeksy
# plottuj(transpose(vcat(a, ai)), ind)

plottuj(transpose(vcat(be,bei) * 10^18), indeksy, "pliku")
