using Winston
stopy = [4;8;16;32;64;128;256;512;1024]
W4 = [2.4676e-6, 1.542e-6, 4.215e-6, 1.1308e-6, 1.1308e-6, 1.028e-6, 8.224e-7, 1.028e-6, 1.028e-6]
W8 = [1.1515e-5, 2.056e-6, 1.7478e-6, 1.9532e-6, 1.8506e-6, 1.8506e-6, 2.1588e-6, 1.7478e-6, 1.9534e-6]
W16 = [8.05014e-5, 3.21798e-5, 1.28514e-5, 1.11036e-5, 1.30572e-5, 1.27486e-5, 1.18232e-5, 1.2646e-5, 1.43936e-5]
W32 = [0.000612343, 0.00124936, 8.79034e-5, 7.10426e-5, 7.30986e-5, 0.000107232, 9.83902e-5, 0.000115251, 0.000111242]
W64 = [0.00366841, 0.00107654, 0.000831125, 0.00063928, 0.00134878, 0.000551788, 0.00063527, 0.000854053, 0.00120289]
W128 = [0.0231564, 0.00957809, 0.00599214, 0.00596336, 0.00577429, 0.00642374, 0.00608724, 0.00585181, 0.00559858]
W256 = [0.160666, 0.077397, 0.0411692, 0.0491179, 0.0397159, 0.0396462, 0.0377829, 0.0372949, 0.0452739]
W512 = [1.03897, 0.416969, 0.248882, 0.218273, 0.210351, 0.22271, 0.320332, 0.414999, 0.404673]
W1024 = [7.16175, 2.86085, 1.69078, 1.35683, 1.30174, 1.48729, 2.00614, 3.11863, 7.61462]
p = Winston.plot(stopy, W4, stopy, W8, stopy, W16,stopy,W32, stopy, W64, stopy, W128,stopy,W256, stopy, W512, stopy, W1024)
title("wszystkie rozmiary")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")

p4 = Winston.plot(stopy, W4)
title("rozmiar = 4")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")
display(p4)

p8 = Winston.plot(stopy, W8)
title("rozmiar = 8")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")
display(p8)

p16 = Winston.plot(stopy, W16)
title("rozmiar = 16")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")
display(p16)

p32 = Winston.plot(stopy, W32)
title("rozmiar = 32")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")
display(p32)

p64 = Winston.plot(stopy, W64)
title("rozmiar = 64")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")
display(p64)

p128 = Winston.plot(stopy, W128)
title("rozmiar = 128")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")
display(p128)

p256 = Winston.plot(stopy, W256)
title("rozmiar = 256")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")
display(p256)

p512 = Winston.plot(stopy, W512)
title("rozmiar = 512")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")
display(p512)

p1024 = Winston.plot(stopy, W1024, "--")
title("rozmiar = 1024")
xlabel("moment zmiany algorytmu z strassena na normalny")
ylabel("czas (s)")
display(p1024)

display(p)

Winston.savefig(p4, "p4.pdf")
Winston.savefig(p8, "p8.pdf")
Winston.savefig(p16, "p16.pdf")
Winston.savefig(p32, "p32.pdf")
Winston.savefig(p64, "p64.pdf")
Winston.savefig(p128, "p128.pdf")
Winston.savefig(p256, "p256.pdf")
Winston.savefig(p512, "p512.pdf")
Winston.savefig(p1024, "p1024.pdf")
Winston.savefig(p, "p.pdf")

scatter(stopy, W1024)
