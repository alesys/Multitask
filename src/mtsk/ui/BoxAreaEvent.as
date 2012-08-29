package mtsk.ui
{
	import flash.events.Event;
	
	public class BoxAreaEvent extends Event
	{
		public static const RELOCATE_START:String = "relocate-start";
		public static const RELOCATE_END:String = "relocate-end";
		public function BoxAreaEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}