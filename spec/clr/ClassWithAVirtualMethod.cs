using System;

namespace ClassLibrary
{
	public class ClassWithAVirtualMethod : IHaveAMethod
	{		
		public virtual bool MyMethod(string parameter)
		{
			Console.WriteLine("clr method was called with " + parameter);
			return true;
		}
	}
}
