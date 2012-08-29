package mtsk.drive
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class DModel extends EventDispatcher
	{
		private var _color:uint;
		private var _colorB:uint;
		private var _isPaused:Boolean;
		private var _dotSize:Number = 10;
		public function DModel(color:uint, colorB:uint)
		{
			this._color = color;
			this._colorB = colorB;
			this._isPaused = true;
		}
		public function pause ():void
		{
			this._isPaused = true;
			this.dispatchEvent(new DEvent(DEvent.PAUSED));
		}
		public function unpause():void
		{
			this._isPaused = false;
			this.dispatchEvent(new DEvent(DEvent.UNPAUSED));
		
		}
		public function transition():void
		{
			this._isPaused = true;
			this.dispatchEvent(new DEvent(DEvent.TRANSITION_START));
		}
		public function get color():uint{ return this._color };
		public function get colorB():uint{ return this._colorB };
		public function get isPaused():Boolean{ return this._isPaused; }
		public function get dotSize():Number{ return this._dotSize; }
		
		
	}
}