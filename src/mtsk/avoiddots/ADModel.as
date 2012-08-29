package mtsk.avoiddots
{
	import flash.events.EventDispatcher;
	
	import mtsk.avoiddots.ui.ADEvents;
	
	public class ADModel extends EventDispatcher
	{
		private var _width:Number;
		private var _height:Number;
		private var _color:uint;
		private var _count:Number;
		private var _background:Number
		private var _isPaused:Boolean;
		private var _spawnspeed:Number;
		public function ADModel(width:Number=200, height:Number=20,count:Number=5, color:uint=0xFFFFFF,background:uint=0x000000, spawnspeed:Number=1)
		{
			this._width 		= width;
			this._height 		= height;
			this._color 		= color;
			this._count 		= count;
			this._background 	= background;
			this._isPaused 		= true;
			this._spawnspeed	= spawnspeed;
		}
		
		public function pause():void
		{
			this._isPaused = true;
			this.dispatchEvent(new ADEvents(ADEvents.PAUSED));
		}
		public function unpause():void
		{
			this._isPaused = false;
			this.dispatchEvent(new ADEvents(ADEvents.UNPAUSED));
		}
		public function get width():Number {return this._width;}
		public function get height():Number {return this._height;}
		public function get color():Number {return this._color;}
		public function get count():Number {return this._count;}
		public function get background():Number {return this._background;}
		public function get isPaused():Boolean {return this._isPaused;}
		public function get spawnspeed():Number {return this._spawnspeed;}
	}
}