using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class ListaLeniwa
    {
        protected List<int> lista = new List<int>();
        protected Random rnd = new Random();

        public virtual int element(int x)
        {
            if(x>lista.Count)
            {
                for(int i=lista.Count; i<x; i++)
                {
                    lista.Add(rnd.Next(Int32.MaxValue));
                }
            }
            return lista[x-1];
        }

        public int size()
        {
            return lista.Count;
        }
    }
    class Pierwsze : ListaLeniwa
    {
        public static bool IsPrime(int number)
        {
            if (number <= 1) return false;
            if (number == 2) return true;
            if (number % 2 == 0) return false;

            var boundary = (int)Math.Floor(Math.Sqrt(number));

            for (int i = 3; i <= boundary; i += 2)
            {
                if (number % i == 0) return false;
            }

            return true;
        }

        public override int element(int x)
        {
            if (x > lista.Count)
            {
                if(lista.Count==0)
                {
                    lista.Add(2);
                }
                for (int i = lista.Count; i < x; i++)
                {
                    int nextprime = lista[lista.Count - 1]+1;
                    while (!IsPrime(nextprime))
                        nextprime++;
                    lista.Add(nextprime);
                }
            }
            return lista[x - 1];
        }
    }

    class IntStream
    {
        protected int nextnum = -1;

        public virtual int next()
        {
            nextnum += 1;
            return nextnum;
        }

        public bool eos()
        {
            if (nextnum < Int32.MaxValue)
                return false;
            return true;
        }

        public void reset()
        {
            nextnum = -1;
        }
    }

    class PrimeStream : IntStream
    {
        public override int next()
        {
            if (nextnum == Int32.MaxValue)  //gdy wychodzi poza zakres
                return -1;
            nextnum++;
            while (!Pierwsze.IsPrime(nextnum))
                nextnum++;
            return nextnum;
        }
    }

    class RandomStream : IntStream
    {
        Random rnd = new Random();
        public override int next()
        {
            return rnd.Next();
        }
    }

    class RandomWordStream
    {
        PrimeStream _prime = new PrimeStream();
        String text = "";

        static Random random = new Random();
        public static char GetLetter()
        {
            int num = random.Next(0, 26); // Zero to 25
            char let = (char)('a' + num);
            return let;
        }

        public string next()
        {
            text = "";
            int nextprime = _prime.next();
            for (int i = 0; i<nextprime; i++)
            {
                text = text + GetLetter();  //to na pewno da sie zrobić jakoś fajniej
            }
            return text;
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            /*
            //testy zad 4.
            ListaLeniwa test = new ListaLeniwa();
            Console.WriteLine(test.element(100));
            Console.WriteLine(test.element(50));
            Console.WriteLine(test.element(100));
            Console.WriteLine(test.size());

            Pierwsze test2 = new Pierwsze();
            Console.WriteLine(test2.element(5));
            Console.WriteLine(test2.element(3));
            Console.WriteLine(test2.element(8));
            Console.WriteLine(test2.element(5));*/

            //testy zad 1.
            IntStream test = new IntStream();
            Console.WriteLine(test.next());
            Console.WriteLine(test.next());

            PrimeStream pierw = new PrimeStream();
            Console.WriteLine(pierw.next());
            Console.WriteLine(pierw.next());
            Console.WriteLine(pierw.next());
            Console.WriteLine(pierw.next());

            RandomStream random = new RandomStream();
            Console.WriteLine(random.next());
            Console.WriteLine(random.next());

            RandomWordStream word = new RandomWordStream();
            Console.WriteLine(word.next());
            Console.WriteLine(word.next());
            Console.WriteLine(word.next());
            Console.WriteLine(word.next());

            Console.ReadKey();
        }
    }
}
