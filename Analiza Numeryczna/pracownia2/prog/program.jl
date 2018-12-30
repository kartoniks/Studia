using Polynomials
using Plots

#Liczenie postaci interpolacyjnej Lagrange

function Lagrange(sigmas, xs) #liczy postać Lagrange na podstawie sigm
    p = Poly([0])
    n = 1
    while(n <= length(sigmas))
        arr = filter(e -> e != xs[n], xs)
        factor = Factor(arr)
        p += (sigmas[n] * factor)
        n += 1
    end
    # println("in lagrange, returning")
    # println(p)
    return p
end

function CountSigmas(xs, ys)
    s = []
    n = 1
    while(n <= length(xs))
        push!(s, Sigma(xs, xs[n], ys[n]))
        n += 1
    end
    return s
end

function Factor(arr) #zwraca wielomian (x-x0)(x-1)...(x-xn)
    p = Poly([1])
    n = 1
    while(n <= length(arr))
        p = p * Poly([-arr[n], 1])
        n += 1
    end
    return p
end

function Sigma(arr, xi, pxi) #liczy sigmy w postaci Lagrange
    ar = filter(e->e != xi, arr)
    s = Factor(ar)
    s = polyval(s, xi)
    s = 1/s
    s *= pxi
    return s
end

function Newtonb(k, sigmas, xs)
    b = 0
    n = 1
    while(n <= k)
        arr = filter(e -> e>xs[k], xs)
        #println(b)
        factor = Factor(arr)(xs[n])
        b += sigmas[n] * factor
        n += 1
        #println(b)
    end
    return b
end

function Newton(sigmas, xs)
    p = Poly(0)
    bs = []
    n = 1
    while(n <= length(sigmas))
        b = Newtonb(n, sigmas, xs)
        push!(bs, Newtonb(n, sigmas, xs))
        n +=1
    end
    
    n = 1
    while(n <= length(sigmas))
        arr = filter(e -> e<xs[n], xs)
        factor = Factor(arr)
        p += (bs[n] * factor)
        n += 1
    end
    return p
end
    
function runge(x)
    return 1/(25x^2+1)
end

function getxs(n, from, to)
    arr = []
    delta = (to-from)/(n-1)
    while(from <= to)
        push!(arr, from)
        from += delta
    end
    return arr
end

function getys(xs, f)
    return map(f, xs)
end

function error(x, xfl)
    return abs(x-xfl)/abs(x)
end
    
function integral(a,b, f, d)
    sum = 0
    while(a<=b)
        sum += f(a)*d
        a += d
    end
    return sum
end

g(x) = runge(x)
from = -1
to = 1

function test() #lagrange versus newton dla funkcji rungego
    cnt = 0
    while(cnt<60)
        cnt += 5
        xs = getxs(cnt, from, to)
        ys = getys(xs, g)
        sigs = CountSigmas(xs,ys)
        lag(x) = Lagrange(sigs, xs)(x)
        newt(x) = Newton(sigs, xs)(x)
        
        g_i = integral(from, to, g, 0.01)
        l_i = integral(from, to, lag, 0.01)
        n_i = integral(from, to, newt, 0.01)
        println(cnt, "   ", error(g_i, l_i), "   ", error(g_i, n_i))
    end
end

from =-10
to =-10
function testfunc()
    cnt = 20
    while(cnt<60)
        cnt += 5
        xs = getxs(cnt, from, to)
        runge_ys = getys(xs, runge)
        sin_ys = getys(xs, sin)
        atan_ys = getys(xs, atan)
        rsigs = CountSigmas(xs,runge_ys)
        ssigs = CountSigmas(xs, sin_ys)
        asigs = CountSigmas(xs, atan_ys)
        rnewt(x) = Newton(rsigs, xs)(x)
        anewt(x) = Newton(asigs, xs)(x)
        snewt(x) = Newton(ssigs, xs)(x)
        
        ainteg = integral(from, to, anewt, 0.01)
        fatan = integral(from, to, atan, 0.01)
        rinteg = integral(from, to, rnewt, 0.01)
        frung = integral(from, to, runge, 0.01)
        sinteg = integral(from, to, snewt, 0.01)
        fsine = integral(from, to, sin, 0.01)
        
        aerror = error(fatan, ainteg)
        rerror = error(frung, rinteg)
        serror = error(fsine, sinteg)
        println("n:", cnt, "  runge:", rerror, "  atan:", aerror, "  sin:", serror)
    end
end
