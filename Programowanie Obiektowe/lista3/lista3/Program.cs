using System;

namespace lista3
{
	public class Lista<T> 
	{
		public Node <T> top;
		public Node <T> bottom;
		public void AddUp(T val)
		{
			if (top == null) {
				top = new Node<T> ();
				top.value = val;
				bottom = top;
			} else {
				top.next = new Node<T> ();
				top.next.value = val;
				top.next.prev = top;
				top = top.next;
			}
		}
		public void AddDown(T val)
		{
			if (bottom == null) {
				bottom = new Node<T> ();
				bottom.value = val;
				top = bottom;
			} else {
				bottom.prev = new Node<T> ();
				bottom.prev.value = val;
				bottom.prev.next = bottom;
				bottom = bottom.prev;
			}
		}
		public T Topval()
		{
			return top.value;
		}
		public T Bottomval()
		{
			return bottom.value;
		}
		public T PopTop()
		{
			if (top!= null){
				T myval = top.value;
				if (top.prev != null) {
					top = top.prev;
					top.next = null;
				}
				else
					top = null;
				return myval;
			} else {
				Console.WriteLine("list is empty!");
				return default (T);
			}
		}
		public T PopBottom()
		{
			if (bottom!= null) {
				T myval = bottom.value;
				if (bottom.next != null) {
					bottom = bottom.next;
					bottom.prev = null;
				}
				else
					bottom = null;
				return myval;
			} else
			{
				Console.WriteLine("list is empty!");
				return default (T);
			}
		}
		public bool isEmpty()
		{
			return top == null;
		}
	}

	public class Node<T>
	{
		public Node <T> next;
		public Node <T> prev;
		public T value;
	}
		
	public class TimeNTon
	{
		public bool checkTime()
		{
			return true;
		}
		static TimeNTon instance;
		public static int N;
		static int already = 0;
		public int val;
		public static TimeNTon Instance
		{get {
			if (already < N)
				instance = new TimeNTon ();
			already += 1;
			return instance;
			}
		}
		private TimeNTon()
		{
			DateTime now = DateTime.Now;
			if (now.DayOfWeek == DayOfWeek.Monday && now.Hour >= 15 && now.Hour <= 18)
				N = 3;
			else
				N = 1;
		}
	}

	class Program
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
			Console.WriteLine(moja.PopTop());
			TimeNTon start = new TimeNTon ();
			Console.WriteLine (TimeNTon.N);
			TimeNTon one = TimeNTon.Instance ();
			one.val = 1;
			TimeNTon two = TimeNTon.Instance ();
			two.val = 2;
			TimeNTon three = TimeNTon.Instance ();
			three.val = 3;
			TimeNTon four = TimeNTon.Instance ();
			three.val = 4;
			Console.WriteLine (one.val);
			Console.WriteLine (two.val);
			Console.WriteLine (three.val);
			Console.WriteLine (four.val);*/

		}
	}
}
