using System;

namespace ClassLibrary
{
	public class Consumer 
	{
		private int count = 0;
		
		public void CallMethod(IHaveAMethod consumable)
		{
			consumable.MyMethod("thing");
		}
		
		public void RegisterEvent(IHaveAnEvent e)
		{
			e.MyEvent += (s,ev) => Console.WriteLine(s);
		}
		
		public void CallSetter(IHaveAProperty p)
		{
			p.MyProperty = ""+count;
			count++;
		}

		public void CallGetter(IHaveAProperty p)
		{
			Console.WriteLine(p.MyProperty);
		}
	}
}