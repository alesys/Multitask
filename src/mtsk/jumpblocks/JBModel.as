package mtsk.jumpblocks
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class JBModel extends EventDispatcher
	{
		private var _color:uint;
		private var _colorBox:uint;
		private var _isPaused:Boolean;
		private var _isTransitioning:Boolean;
		private var _currentTransition:Number;
		public function JBModel(color:uint, colorBox:uint)
		{
			this._color = color;
			this._colorBox = colorBox;
			this._isPaused = true;
			this._currentTransition = 0;
		}
		public function startTransition():void
		{
			this._currentTransition++;
			this._isTransitioning = true;
			this.dispatchEvent(new JBEvent(JBEvent.TRANSITION_START));
		}
		public function endTransition():void
		{
			this._isTransitioning = false;
			this.dispatchEvent(new JBEvent(JBEvent.TRANSITION_END));
		}
		public function pause():void
		{
			this._isPaused = true;
			this.dispatchEvent(new JBEvent(JBEvent.PAUSED));
		}
		public function unpause():void
		{
			this._isPaused = false;
			this.dispatchEvent(new JBEvent(JBEvent.UNPAUSED));
		}
		public function get color():uint { return this._color; }
		public function get colorBox():uint { return this._colorBox; }
		public function get isPaused():Boolean { return this._isPaused;}
		public function get isTransitioning():Boolean { return this._isTransitioning;}
		public function get currentTransition():Number { return this._currentTransition;}
	}
}