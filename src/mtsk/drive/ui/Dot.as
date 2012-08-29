package mtsk.drive.ui
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mtsk.drive.DEvent;
	import mtsk.drive.DModel;
	
	public class Dot extends Sprite
	{
		private var model:DModel;
		private var currentPos:Number;
		private var unit:Number;
		private var offset:Number;
		public function Dot(model:DModel)
		{
			this.model = model;
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		private function init(e:Event):void
		{
			this.drawDot();
			this.currentPos 	= 1;
			this.unit 			= this.stage.stageHeight / 9;
			this.offset 		= this.unit >> 1;
			this.y 				= this.getCoord();
			this.x				= this.stage.stageWidth - this.model.dotSize - 10;
			trace ( "dot", this.x, this.y  );
			this.model.addEventListener(DEvent.PAUSED, this.onpause);
			this.model.addEventListener(DEvent.UNPAUSED, this.onunpause);
		}
		private function onpause(e:DEvent):void
		{
			if ( this.tween)
			this.tween.pause();	
		}
		private function onunpause(e:DEvent):void
		{
			if (this.tween)
			this.tween.play();
		}
		private function drawDot():void
		{
			this.graphics.beginFill(this.model.color);
			this.graphics.drawCircle(0,0,this.model.dotSize);
			this.graphics.endFill();
		}
		private function getCoord():Number
		{
			return (this.currentPos * this.unit) + this.offset;
		}
		public function up():void
		{
			this.currentPos--;
			if ( this.currentPos < 0 ) this.currentPos = 0;
			this.updatePos();
		}
		public function down():void
		{
			this.currentPos++;
			if ( this.currentPos > 2 ) this.currentPos = 2;
			this.updatePos();
		}
		private var tween:TweenLite;
		public function updatePos():void
		{
			this.tween = new TweenLite(this, 0.25, {y:this.getCoord()});
		}
		
	}
}