using System;

namespace lista3
{
	public class Program
	{
		public static void Main ()
		{
			/*//zad1 testy
			Lista<int> moja = new Lista<int>();
			moja.AddUp (5);
			moja.AddUp (8);
			moja.AddUp (10);
			moja.AddDown (7);
			moja.AddDown (13);
			//Console.WriteLine(moja.Topval());
			//Console.WriteLine (moja.Bottomval ());

			Console.WriteLine(moja.PopTop());
			Console.WriteLine(moja.PopTop());
			Console.WriteLine(moja.PopTop());
			Console.WriteLine(moja.PopTop());
			Console.WriteLine(moja.PopTop());*/
			TimeNTon start = new TimeNTon ();
			Console.WriteLine (TimeNTon.N);
			TimeNTon one = TimeNTon.Instance;
			one.val = 1;
			TimeNTon two = TimeNTon.Instance;
			two.val = 2;
			TimeNTon three = TimeNTon.Instance;
			three.val = 3;
			TimeNTon four = TimeNTon.Instance;
			three.val = 4;
			Console.WriteLine (one.val);
			Console.WriteLine (two.val);
			Console.WriteLine (three.val);
			Console.WriteLine (four.val);
		}
	}
}

