using System;

namespace ClassLibrary
{
	public class Consumer 
	{
		private int count = 0;
		private IHaveAnEvent eventThing;

		public void CallMethod(IHaveAMethod consumable)
		{
			if (consumable.MyMethod("thing")) Console.WriteLine("Received true");
			else Console.WriteLine("Received false");
		}

		public void RegisterEvent(IHaveAnEvent e)
		{
		 	eventThing = e;
			e.MyEvent += (s,ev) => {
				eventThing.MyMethod("thing");
				count++;
			};
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