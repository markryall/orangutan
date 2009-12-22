using System;

namespace ClassLibrary
{
	public class Consumer 
	{
		private IHaveAnEvent eventThing;
		private string getterValue;

		public void CallMethod(IHaveAMethod consumable)
		{
			consumable.MyMethod("thing");
		}

		public void RegisterEvent(IHaveAnEvent e)
		{
		 	eventThing = e;
			e.MyEvent += (s,ev) => eventThing.MyMethod("thing");
		}

		public void CallSetter(IHaveAProperty p)
		{
			p.MyProperty = getterValue;
		}

		public void CallGetter(IHaveAProperty p)
		{
			getterValue = p.MyProperty;
		}
	}
}