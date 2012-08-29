package mtsk.jumpblocks.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mtsk.jumpblocks.JBModel;

	public class Dot extends Sprite
	{
		private var color:uint;
		private var vel:Number;
		private var isJumping:Boolean;
		private var model:JBModel;
		public function Dot(model:JBModel)
		{
			this.model = model;
			this.color = this.model.color;
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			
		}
		private function init(e:Event):void
		{
			this.graphics.beginFill(this.color,1);
			this.graphics.drawCircle(10,-10,10);
			this.graphics.endFill();
			this.x = 20;
		}
		public function activate():void
		{
			this.y = 0;
			this.vel = 0;
			this.isJumping = false;
			this.addEventListener(Event.ENTER_FRAME, this.animate);	
		}
		public function jump():void
		{
			if ( !this.isJumping )
			{
				this.isJumping = true;
				this.vel = -5;	
			}
		}
		private function animate(e:Event):void
		{
			if ( !this.model.isPaused )
			{
				var g:Number = 0.09;
				var f:Number = 0.98;
				this.vel+= g;
				this.vel*= f;
				if (this.y+this.vel<0) 
				{
					this.y+=this.vel;
				} else
				{
					this.y=0;
					this.isJumping = false;
				}
				if ( this.y<-60 ) this.y = -60;
			}
		}
		
	}
}