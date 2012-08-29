package mtsk.jumpblocks
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class JumpBlocks extends Sprite
	{
		private var view:JBView;
		private var controller:JBController;
		private var model:JBModel;
		private var _isActive:Boolean;
		public function JumpBlocks()
		{
			this._isActive = false;
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		private function init(e:Event):void
		{
			this.model = new JBModel(0xFFFF00, 0x00FF00);
			this.controller = new JBController(this.model);
			this.view = new JBView(this,this.controller, this.model);
			
			this.controller.intro();
		}
		public function activate():void
		{
			this.view.activate();
			this._isActive = true;
		}
		public function transition():void
		{
			this.controller.transition();
		}
		public function get isActive():Boolean{ return this._isActive;}
		public function pause():void
		{
			this.controller.pause();
		}
		public function unpause():void
		{
			this.controller.unpause();
		}
	}
}