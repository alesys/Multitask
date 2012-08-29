package mtsk.avoiddots
{
	import events.GameEvent;
	
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import mtsk.avoiddots.ui.ADEvents;
	import mtsk.avoiddots.ui.Dot;
	import mtsk.avoiddots.ui.DotEvent;
	import mtsk.avoiddots.ui.Grid;
	import mtsk.ui.BoxArea;

	public class ADView
	{
		private var boxarea:BoxArea;
		private var grid:Grid;
		private var model:ADModel;
		private var controller:ADController;
		private var scenario:AvoidDots;
		private var timer:Timer;
		public function ADView(scenario:AvoidDots, controller:ADController, model:ADModel)
		{
			this.model 		= model;
			this.controller = controller;
			this.scenario 	= scenario;
			this.setup();
			this.listenKeys();
		}
		private function setup():void
		{
			this.boxarea 	= new BoxArea ( new Rectangle(0,0,this.scenario.stage.stageWidth, this.scenario.stage.stageHeight), this.model.background);
			this.grid 		= new Grid( this.model.count, this.model.width, this.model.height, this.model.color, this.boxarea);
			
			this.scenario.addChild(this.boxarea);
			this.scenario.addChild(this.grid);
			
			this.grid.x = this.boxarea.width - this.grid.width >> 1;
			this.grid.y = this.boxarea.height - this.grid.height >> 1;
			
			this.timer = new Timer( this.model.spawnspeed *1000);
			this.timer.addEventListener(TimerEvent.TIMER, this.spawnDot, false, 0, true);
			//this.timer.start();
			
			this.model.addEventListener(ADEvents.PAUSED, this.pause);
			this.model.addEventListener(ADEvents.UNPAUSED, this.unpause);
		}
		private function pause(e:ADEvents):void
		{
			this.timer.stop();
		}
		private function unpause(e:ADEvents):void
		{
			this.timer.start();
		}
		private function listenKeys():void
		{
			this.scenario.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyEvent);
		}
		private function onKeyEvent(ke:KeyboardEvent):void
		{
			if ( !this.model.isPaused )
			{
				switch ( ke.keyCode )
				{
					case Keyboard.RIGHT:
						this.grid.incPos();
						break;
					case Keyboard.LEFT:
						this.grid.decPos();
						break;
				}
			}
		}
		private function spawnDot(te:TimerEvent):void
		{
			var dot:Dot = new Dot(this.grid.getCursor(), this.model, 4, new Point(0, 0));
			dot.addEventListener(DotEvent.COLLISION, this.endGame);
			this.grid.addChild(dot);
		}
		private function endGame(e:DotEvent):void
		{
			this.grid.pause();
			this.model.pause();
			this.scenario.dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
			this.dark();
		}
		public function resize(step:Number):void
		{
			switch (step)
			{
				case 1:
					this.boxarea.relocate(new Rectangle(0,0,this.scenario.stage.stageWidth, this.scenario.stage.stageHeight>>1));
					break;
				case 2:
					this.boxarea.relocate(new Rectangle(0,0,this.scenario.stage.stageWidth, this.scenario.stage.stageHeight/3));
					break;
				
			}
		}
		private function dark():void
		{
			this.boxarea.dark();
		}
	}
}