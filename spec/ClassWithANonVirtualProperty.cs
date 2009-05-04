using System;

namespace ClassLibrary
{
	public class ClassWithANonVirtualProperty : IHaveAProperty
	{
		private string _MyProperty;
		public string MyProperty
		{
			get
			{
				Console.WriteLine("clr getter called");
				return _MyProperty;
			}
			set
			{
				Console.WriteLine("clr setter called");
				_MyProperty = value;
			}
		}
	}
}