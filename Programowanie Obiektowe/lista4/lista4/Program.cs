using System;

namespace lista4
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			PrimeCollection pc = new PrimeCollection();
			foreach (object o in pc)
				Console.WriteLine (o);
			/*
			ListaLeniwa l = new ListaLeniwa ();
			l.element (5);
			String s = l.ToString ();
			Console.WriteLine (s);*/

		}
	}
}
