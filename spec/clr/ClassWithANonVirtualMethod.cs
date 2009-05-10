using System;

namespace ClassLibrary
{
	public class ClassWithANonVirtualMethod : IHaveAMethod
	{		
		public bool MyMethod(string parameter)
		{
			Console.WriteLine("clr method was called with " + parameter);
			return true;
		}
	}
}