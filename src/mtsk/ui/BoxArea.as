package mtsk.ui
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/*
		Creates a Rectangle 
			methods: 
				relocate(rec:Rectangle);
	*/
	public class BoxArea extends Sprite
	{
		private var animDuration:Number = 1;
		public function BoxArea (rec:Rectangle, color:uint)
		{
			this.graphics.beginFill(color, 1);
			this.graphics.drawRect(0,0,rec.width, rec.height);
			this.graphics.endFill();
			
			this.x = rec.x;
			this.y = rec.y;
		}
		
		/* 
			Relocates the box. 
			Dispatches BoxAreaEvent.RELOCATE_START and BoxAreaEvent.RELOCATE_END
		*/
		public function relocate (rec:Rectangle):void
		{
			this.dispatchEvent(new BoxAreaEvent(BoxAreaEvent.RELOCATE_START));
			TweenLite.to( this, this.animDuration, {
				x:rec.x, 
				y:rec.y, 
				width:rec.width, 
				height:rec.height,
				onCompleteParams:[this], 
				onComplete: function (target:BoxArea):void
				{
					target.dispatchEvent(new BoxAreaEvent(BoxAreaEvent.RELOCATE_END));
				}
			} );
			
		}
		public function dark ():void
		{
			TweenLite.to(this, 1, {alpha:0.25} );	
		}
	}
}