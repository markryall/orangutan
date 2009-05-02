using System;

namespace ClassLibrary
{
	public class Consumer
	{
		public void Consume(IConsumable consumable)
		{
			consumable.Consume("thing");
		}
	}
}
