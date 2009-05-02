namespace ClassLibrary
{
	public interface IConsumable
	{
		bool Consume(string thing);
		bool CanConsume(string thing);
	}
}
