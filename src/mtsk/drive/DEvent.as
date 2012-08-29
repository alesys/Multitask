package mtsk.drive
{
	import flash.events.Event;
	
	public class DEvent extends Event
	{
		public static const PAUSED:String = "paused";
		public static const UNPAUSED:String = "unpaused";
		public static const TRANSITION_START:String = "transition_start";
		public function DEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}