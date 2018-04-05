using System;
using System.Collections;
namespace lista4
{
	public class PrimeCollection : IEnumerable 
	{
		public static int maxPrime = 1;
		Number primes = new Number();
		public IEnumerator GetEnumerator()
		{
			return new ListEnum(primes);
		} 
		/*public void Add(int v)
		{
			Number temp = new Number (v);
			if (primes == null) {
				primes = new Number();
				Add (v);
				return;
			}
			Number last = primes;
			while (last.next != null) 
			{
				last = last.next;
			}
			last.next = temp;
		}*/
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
		public static int NextPrime(int p)
		{
			int ans = p + 1;
			while(!IsPrime(ans))
				ans+=1;
			maxPrime = ans;
			return ans;
		}

		class ListEnum : IEnumerator
		{
			Number list;
			public ListEnum(Number l)
			{
				this.list = l;
			}
			public bool MoveNext()
			{
				//this.list.next = new Number (NextPrime (maxPrime));
				//this.list = this.list.next;
				NextPrime(maxPrime);
				return maxPrime != 2147483647;//value of MaxPrime in integer
				/*if (this.list == null) this.list = new Number();
				else this.list = this.list.next;
				return this.list != null;*/
			}
			public object Current {
				get {
					return maxPrime;
				}
			}
			public void Reset()
			{
				this.list = null;
			}
		}
		public class Number
		{
			public Number(){}
			public Number(int v)
			{
				this.val = v;
			}
			public int val;
			public Number next;
		}
	}
}
