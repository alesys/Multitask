package mtsk.drive
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Drive extends Sprite
	{
		private var model:DModel;
		private var view:DView;
		private var controller:DController;
		public function Drive()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		private function init(e:Event):void
		{
			this.model = new DModel(0xffffff, 0xFF8800);
			this.controller = new DController(this.model);
			this.view = new DView(this, this.controller, this.model);
			
			this.controller.intro();
		}
		public function activate():void
		{
			this.view.activate();
			this.controller.unpause();	
		}
		public function pause():void
		{
			this.controller.pause();
		}
	}
}