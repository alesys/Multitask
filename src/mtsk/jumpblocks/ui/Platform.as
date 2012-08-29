package mtsk.jumpblocks.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Platform extends Sprite
	{
		private var color:uint;
		
		public function Platform(color:uint)
		{
			this.color = color;
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		public function init(e:Event):void
		{
			this.graphics.beginFill(this.color,1);
			this.graphics.drawRect(0,0,this.stage.stageWidth, 40);
			this.graphics.endFill();
		}
	}
}