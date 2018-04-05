using System;
using System.Collections.Generic;
using System.Collections;

namespace lista4
{
	public interface IList
	{
		bool isEmpty();
		int length ();
	}
	class ListaLeniwa : IList, IEnumerable
	{
		public bool isEmpty()
		{
			return lista.Count == 0;
		}

		public int length()
		{
			return lista.Count;
		}

		public IEnumerator GetEnumerator()
		{
			return lista.GetEnumerator ();
		}

		public override String ToString()
		{
			String s = String.Empty;
			foreach (int e in lista)
				s += e.ToString ();
			return s;
		}

		public int Length
		{
			get{ return lista.Count; }
		}

			
		public List<int> lista = new List<int>() ;
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
	public class Lista<T> : IList
	{
		public Node <T> top;
		public Node <T> bottom;
		private int size = 0;
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
			size += 1;
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
			size += 1;
		}
		public int length()
		{
			return size;
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
				size -= 1;
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
				size -= 1;
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
	public class CommonInterface
	{
		public CommonInterface ()
		{
		}
	}
}

