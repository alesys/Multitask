package mtsk.drive.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mtsk.drive.DEvent;
	import mtsk.drive.DModel;
	
	public class Block extends Sprite
	{
		private var model:DModel;
		private var size:Number;
		private var vel:Number;
		private var dot:Dot;
		public function Block(model:DModel, dot:Dot)
		{
			this.dot 	= dot;
			this.model 	= model;
			this.vel 	= 2;
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		private function init(e:Event):void
		{
			this.size = this.stage.stageHeight / 9;
			this.drawBlock();
			this.y = this.getCoord();
			this.x = - this.size;
			this.addEventListener(Event.ENTER_FRAME, this.animate);
		}
		private function getCoord():Number
		{
			var r:Number = Math.floor(Math.random()*3);
			return r * this.size;
		}
		private function drawBlock():void
		{
			this.graphics.beginFill(this.model.color, 1);
			this.graphics.drawRect(0,0,this.size, this.size);
			this.graphics.endFill();
		}
		private function animate(e:Event):void
		{
			if ( !this.model.isPaused )
			{
				this.x += this.vel;
				if ( this.x > this.stage.stageWidth )
				{
					this.removeEventListener(Event.ENTER_FRAME, this.animate);
					this.parent.removeChild(this);
				}
				if ( this.hitTestObject(this.dot))
				{
					this.dispatchEvent(new BlockEvent(BlockEvent.COLLISION));
					
				}
			}
			
		}
		
	}
}