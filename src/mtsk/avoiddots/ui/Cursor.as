package mtsk.avoiddots.ui
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class Cursor extends Sprite
	{
		public function Cursor(rect:Rectangle, color:uint)
		{
			this.graphics.beginFill(color, 1);
			this.graphics.drawRect(0, 0, rect.width, rect.height);
			this.graphics.endFill();
			this.x = rect.x;
			this.y = rect.y;
		}
	}
}