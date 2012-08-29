
package mtsk.drive
{
	import com.greensock.TweenLite;
	
	import events.GameEvent;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import mtsk.drive.ui.Block;
	import mtsk.drive.ui.BlockEvent;
	import mtsk.drive.ui.Dot;
	import mtsk.ui.BoxArea;

	public class DView
	{
		private var scenario:Drive;
		private var controller:DController;
		private var model:DModel;
		private var boxarea:BoxArea;
		private var dot:Dot;
		public function DView(scenario:Drive, controller:DController, model:DModel)
		{
			this.scenario = scenario;
			this.controller = controller;
			this.model = model;
			this.model.addEventListener(DEvent.TRANSITION_START, ontransition);
			this.boxarea = new BoxArea(new Rectangle(0,0,this.scenario.stage.stageWidth, this.scenario.stage.stageHeight/3),this.model.colorB);
			this.dot = new Dot(this.model);
			this.scenario.addChild(this.boxarea);
			this.scenario.addChild(this.dot);
		}
		private function ontransition(e:DEvent):void
		{
			this.scenario.y = this.scenario.stage.stageHeight;
			TweenLite.to(this.scenario, 1, {
				y: this.scenario.stage.stageHeight - (this.scenario.stage.stageHeight/3)
			});
		}
		private function listenKeys():void
		{
			this.scenario.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onkeys);
			this.scenario.addEventListener(Event.REMOVED_FROM_STAGE, clearAll);
		}
		private function clearAll(e:Event):void
		{
			this.scenario.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onkeys);
		}
		public function activate():void
		{
			this.listenKeys();
			this.startBlockTimer();
			this.model.addEventListener(DEvent.PAUSED, this.onpause);
			this.model.addEventListener(DEvent.UNPAUSED, this.onunpause);
		}
		private var timer:Timer;
		private function startBlockTimer():void
		{
			this.timer = new Timer(4000);
			this.timer.start();
			this.timer.addEventListener(TimerEvent.TIMER, this.spawnBlock);
			this.timer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
		}
		private function spawnBlock(e:TimerEvent):void
		{
			var block:Block = new Block(this.model,this.dot);
			this.scenario.addChild(block);
			block.addEventListener(BlockEvent.COLLISION, this.oncollision);
		}
		private function oncollision(e:BlockEvent):void
		{
			this.scenario.dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
			this.controller.pause();
			this.dark();
		}
		private function onpause(e:DEvent):void{
			if ( this.timer ) this.timer.stop();	
		}
		private function onunpause(e:DEvent):void
		{
			if ( this.timer ) this.timer.start();
		}
		private function onkeys(ke:KeyboardEvent):void
		{
			if ( !this.model.isPaused )
			{
				switch ( ke.keyCode )
				{
					case Keyboard.UP:
						this.dot.up();
						break;
					case Keyboard.DOWN:
						this.dot.down();
						break;
				}
			}
		}
		private function dark():void
		{
			this.boxarea.dark();
		}
	}
}