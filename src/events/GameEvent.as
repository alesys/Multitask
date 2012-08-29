package events
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const GAME_OVER:String = "game_over";
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}