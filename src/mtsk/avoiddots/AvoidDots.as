package mtsk.avoiddots
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class AvoidDots extends Sprite
	{
		private var view:ADView;
		private var model:ADModel;
		private var controller:ADController;
		public function AvoidDots()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,this.init);
		}
		private function init(e:Event):void
		{
			this.model 			= new ADModel(200,5,5,0xffffff,0xFF0000,2);
			this.controller = new ADController(model);
			this.view 			= new ADView(this,controller, model);
		}
		public function unpause():void
		{
			this.controller.unpause();
		}
		public function pause():void{
			this.controller.pause();
		}
		public function resize(step:Number):void
		{
			this.pause();
			this.view.resize(step);
		}
	}
}