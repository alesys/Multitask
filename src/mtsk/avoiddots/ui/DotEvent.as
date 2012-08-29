package mtsk.avoiddots.ui
{
	import flash.events.Event;
	
	public class DotEvent extends Event
	{
		public static const COLLISION:String = "collision";
		public function DotEvent(event:String)
		{
			super(event);
		}
	}
}