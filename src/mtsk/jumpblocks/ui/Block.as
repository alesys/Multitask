package mtsk.jumpblocks.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mtsk.jumpblocks.JBModel;
	
	public class Block extends Sprite
	{
		private var color:uint;
		private var dot:Dot;
		private var vel:Number;
		private var model:JBModel;
		public function Block(model:JBModel)
		{
			this.model = model;
			this.color = this.model.color;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			this.vel = -1;
		}
		private function init(e:Event):void
		{
			this.graphics.beginFill(this.color, 1);
			this.graphics.drawRect(0,-10,5,10);
			this.graphics.endFill();
		}
		public function activate(dot:Dot, platform:Platform):void
		{
			this.y = 0;
			this.x = platform.width;
			this.dot = dot;
			this.addEventListener(Event.ENTER_FRAME, this.animate);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.remove);
		}
		private function animate(e:Event):void
		{
			if (!this.model.isPaused)
			{
				this.x += this.vel;
				if ( this.x < -this.width )
				{
					this.parent.removeChild(this);
				}
				if ( this.dot.hitTestObject(this))
				{
					this.dispatchEvent(new BlockEvent(BlockEvent.COLLISION));
				}
			}
		}
		private function remove(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME, this.animate);
		}
		
	}
}