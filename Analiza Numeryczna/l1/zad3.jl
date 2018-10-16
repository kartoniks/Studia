function polynomial(x)
  return x^3-6*x^2+3*x-0.149
end

function poly2(x)
  return ((x-6)*x+3)*x-0.149
end

println("Float16 value: ", polynomial(Float16(4.71)))
println("Float32 value: ", polynomial(Float32(4.71)))
println("Float64 value: ", polynomial(Float64(4.71)))

exact = -14.636489

println("Float16 error: ", abs((polynomial(Float16(4.71))-exact)/exact))
println("Float32 error: ", abs((polynomial(Float32(4.71))-exact)/exact))
println("Float64 error: ", abs((polynomial(Float64(4.71))-exact)/exact))

println()
println("Float16 value: ", poly2(Float16(4.71)))
println("Float32 value: ", poly2(Float32(4.71)))
println("Float64 value: ", poly2(Float64(4.71)))
println("Float16 error: ", abs((poly2(Float16(4.71))-exact)/exact))
println("Float32 error: ", abs((poly2(Float32(4.71))-exact)/exact))
println("Float64 error: ", abs((poly2(Float64(4.71))-exact)/exact))

