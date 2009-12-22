using System;

namespace ClassLibrary
{
	public interface IHaveAnEvent
	{
		event EventHandler<EventArgs> MyEvent;
		bool MyMethod(string parameter);
	}
}