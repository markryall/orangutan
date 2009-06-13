using System;

namespace ClassLibrary
{
	public class Consumer 
	{
		private int count = 0;
		
		public void CallMethod(IHaveAMethod consumable)
		{
			if (consumable.MyMethod("thing")) Console.WriteLine("Received true");
      else Console.WriteLine("Received false");
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
