# Skoro mamy podobne czasy dla stopow = {32, 64, 128} sprawdzmy jakie sa bledy przy kazdym ze stopow
# rozmiary = indeksy, iteracjie = 20, rysuje wykres err * 10^18, wyniki zapisane w BladInvStrassStop2.png , z tego  BladStrass_zaleznosc_od_zmiany.png było dobrze też ale źle zapisałem wyniki :/
# te rzeczy wychodzą zupełnie z czapy
indeksy = [128, 256, 512, 1024, 2048]
a = [3.28352e-24 8.94986e-23 3.08026e-21 6.2254e-19 1.33283e-19; 1.1329e-24 1.15167e-22 3.28867e-21 3.57518e-19 5.32419e-20; 1.30968e-24 3.06569e-22 2.94942e-21 1.52337e-19 1.14285e-19]
ai = [9.8256e-25 8.17142e-23 1.28578e-21 1.47343e-19 1.43099e-19; 6.47901e-25 6.32194e-23 1.46342e-22 1.88038e-19 1.39254e-19; 6.50748e-25 3.91214e-23 8.40869e-23 3.92073e-19 1.47434e-19]
