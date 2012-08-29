package mtsk.jumpblocks.ui
{
	import flash.events.Event;
	
	public class BlockEvent extends Event
	{
		public static const COLLISION:String = "collision";
		public function BlockEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}