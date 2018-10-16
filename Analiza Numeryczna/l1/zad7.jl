function bin2dec(str)
  num = 0
  for c in str
    num *= 2
    num += Int(c)-Int('0')
  end
  return num
end

function reverseBitString(str)
  bias = 2^10 -1
  m = 1 + bin2dec(str[13:end]) / 2^52
  ex = bin2dec(str[2:12]) - bias
  s = bin2dec(str[1])
  if s==1
    s=-1
  else
    s=1
  end
  val = s * m * 2^ex
  return val
end

println(bits(3.0))
println(reverseBitString(bits(3.0)))
  
