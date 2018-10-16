for i=1:10
  x = Float64(2-i*10e-7)
  y=Float64(1/x)
  z = Float64(x*y)
  #println(z)
  if z != 1
    println(x)
  end
end
