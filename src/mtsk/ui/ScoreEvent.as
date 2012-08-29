package mtsk.ui
{
	import flash.events.Event;
	
	public class ScoreEvent extends Event
	{
		public static const LEVEL1_COMPLETED:String = "level1completed";
		public static const LEVEL2_COMPLETED:String = "level2completed";
		public static const LEVEL3_COMPLETED:String = "level3completed";
		public function ScoreEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}