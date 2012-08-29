package mtsk.avoiddots.ui
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mtsk.ui.BoxArea;
	import mtsk.ui.BoxAreaEvent;

	public class Grid extends Sprite
	{
		private var cursor:Cursor;
		private var count:Number;
		private var currentIndex:Number;
		private var unit:Number;
		private var tween:TweenLite;
		private var boxarea:BoxArea
		public function Grid(count:Number, width:Number, height:Number, color:uint, boxarea:BoxArea)
		{
			this.graphics.lineStyle(1, color,1, true);
			this.graphics.drawRect(0, 0, width, height);
			this.boxarea = boxarea;
			var position:Number = 0;
			var unit:Number = width / count;
			for ( var i:Number = 0; i< count; i++)
			{
				position += unit;
				this.graphics.moveTo(position, 0);
				this.graphics.lineTo(position, height);
				
			}
			this.currentIndex = Math.floor(count / 2);
			this.cursor = new Cursor( new Rectangle( unit * this.currentIndex ,0, unit, height), color);
			this.addChild(this.cursor);
			this.count = count;
			this.unit = unit;
			
			this.boxarea.addEventListener(BoxAreaEvent.RELOCATE_START, this.followboxarea);
			this.boxarea.addEventListener(BoxAreaEvent.RELOCATE_END, this.unfollowboxarea);
		}
		
		public function incPos():void
		{
			if ( this.currentIndex + 1 < this.count )
			{
				this.currentIndex++;
				this.updatePos();
			}
		}
		public function decPos():void
		{
			if ( this.currentIndex - 1 >= 0 ) 
			{
				this.currentIndex--;
				this.updatePos();
			}
		}
		private function updatePos():void
		{
			this.tween = new TweenLite(this.cursor, 0.25, {x:this.currentIndex * this.unit});
		}
		public function pause ():void
		{
			if ( this.tween )
			this.tween.pause();
		}
		public function unpause ():void
		{
			if ( this.tween )
			this.tween.play();
		}
		public function getCursor():Cursor
		{
			return this.cursor;
		}
		private function followboxarea(e:BoxAreaEvent):void
		{
			this.addEventListener(Event.ENTER_FRAME, this.followbox);
		}
		private function unfollowboxarea(e:BoxAreaEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME, this.followbox);
		}
		private function followbox(e:Event):void
		{
			this.x = this.boxarea.width - this.width >> 1;
			this.y = this.boxarea.height - this.cursor.height >> 1;
		}
	}
	
}