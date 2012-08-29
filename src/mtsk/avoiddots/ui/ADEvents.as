package mtsk.avoiddots.ui
{
	import flash.events.Event;
	
	public class ADEvents extends Event
	{
		public static const PAUSED:String = "paused";
		public static const UNPAUSED:String = "unpaused";
		public function ADEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}