package mtsk.avoiddots.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mtsk.avoiddots.ADModel;
	
	public class Dot extends Sprite
	{
		private var target:Sprite;
		private var radius:Number;
		private var unit:Number;
		private var color:uint;
		private var speed:Number;
		private var tween:TweenLite;
		private var offset:Point
		private var model:ADModel;
		public function Dot(target:Sprite, model:ADModel, speed:Number, offset:Point)
		{
			this.model		= model;
			this.target 	= target;
			this.unit 		= this.model.width / this.model.count;
			this.radius 	= this.model.height;
			this.color		= this.model.color;
			this.offset		= offset;
			this.speed		= speed;
			this.offset.x	+= this.unit >> 1;
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			this.addEventListener(Event.ENTER_FRAME, this.checkcollision);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.clearall);
			this.model.addEventListener( ADEvents.PAUSED, this.pause);
			this.model.addEventListener( ADEvents.UNPAUSED, this.unpause);
		}
		private function init(e:Event):void
		{
			this.graphics.beginFill(color,1);
			this.graphics.drawCircle(0,0,this.radius);
			this.graphics.endFill();
			this.alpha = 0;
			var yInit:Number = this.radius * -16 + this.offset.y;
			var xInit:Number = Math.floor( Math.random() * this.model.count ) * this.unit + this.offset.x;
			this.y = yInit;
			this.x = xInit;
			
			this.tween = new TweenLite( this, this.speed>>1, {
				y:this.offset.y, 
				alpha: 1,
				ease:Linear.easeNone, 
				onCompleteParams:[this], 
				onComplete: function (dot:Dot):void
				{
					dot.tween = new TweenLite (dot, dot.speed>>1,{
						y: dot.offset.y + dot.radius * 10,
						alpha: 0,
						ease: Linear.easeNone,
						onCompleteParams:[dot],
						onComplete: function (dot:Dot):void
						{
							dot.parent.removeChild(dot);
						}
					})
				}
			}
			);
			
		}
		private function checkcollision(e:Event):void
		{
			if ( !this.model.isPaused )
			if ( this.target.hitTestObject( this ) )
			{
				this.dispatchEvent(new DotEvent(DotEvent.COLLISION));
			}
		}
		private function clearall(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME, this.checkcollision);
		}
		private function pause(e:ADEvents):void
		{
			this.tween.pause();
		}
		private function unpause(e:ADEvents):void
		{
			this.tween.play();
		}
			
	}
}