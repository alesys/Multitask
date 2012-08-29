package mtsk.jumpblocks
{
	import flash.events.Event;

	public class JBEvent extends Event
	{
		public static const TRANSITION_START:String = "transition_start";
		public static const TRANSITION_END:String = "transition_end";
		public static const PAUSED:String = "paused";
		public static const UNPAUSED:String = "unpaused";
		public function JBEvent(type:String)
		{
			super(type);	
		}
	}
}