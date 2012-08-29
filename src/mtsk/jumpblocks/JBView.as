package mtsk.jumpblocks
{
	import com.greensock.TweenLite;
	
	import events.GameEvent;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import mtsk.jumpblocks.ui.Block;
	import mtsk.jumpblocks.ui.BlockEvent;
	import mtsk.jumpblocks.ui.Dot;
	import mtsk.jumpblocks.ui.Platform;
	import mtsk.ui.BoxArea;
	import mtsk.ui.BoxAreaEvent;

	public class JBView
	{
		private var platform:Platform;
		private var dot:Dot;
		private var controller:JBController;
		private var model:JBModel;
		private var scenario:JumpBlocks;
		private var boxarea:BoxArea; 
		public function JBView(scenario:JumpBlocks,controller:JBController, model:JBModel)
		{
			this.controller = controller;
			this.model = model;
			this.scenario = scenario;
			
			this.drawScenario();
			this.model.addEventListener(JBEvent.TRANSITION_START, this.transition);
			
			
			
			this.scenario.y = this.scenario.stage.stageHeight;
		}
		private function drawScenario():void
		{
			this.dot = new Dot(this.model);
			this.platform = new Platform(this.model.color);
			this.boxarea = new BoxArea(new Rectangle(0,0,this.scenario.stage.stageWidth, this.scenario.stage.stageHeight>>1),this.model.colorBox);
			this.scenario.addChild(this.boxarea);
			this.scenario.addChild(platform);
			this.platform.addChild(dot);
			this.platform.y = this.boxarea.height - 40;
			
		}
		private function transition(e:JBEvent):void
		{
			switch ( this.model.currentTransition )
			{
				case 1:
					TweenLite.to(this.scenario, 1, {
						y: this.scenario.stage.stageHeight >> 1,
						onCompleteParams:[this],
						onComplete: function (view:JBView):void
						{
							view.controller.endTransition();
						}
					});
					break;
				case 2:
					TweenLite.to(this.scenario, 1, {
						y: this.scenario.stage.stageHeight / 3
					});
					this.boxarea.relocate(new Rectangle(0,0,this.scenario.stage.stageWidth,this.scenario.stage.stageHeight / 3));
					TweenLite.to(this.platform,1, {
						y: this.scenario.stage.stageHeight/3 - 40
					});
					break;
			}
		}
		public function activate():void
		{
			this.dot.activate();
			this.listenKeys();
			this.controller.unpause();
			this.startBlocktimer();
			this.model.addEventListener(JBEvent.PAUSED, this.onpause);
			this.model.addEventListener(JBEvent.UNPAUSED, this.onunpause);
		}
		private function listenKeys():void
		{
			
			this.scenario.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeys);
		}
		private function onKeys(e:KeyboardEvent):void
		{
			
			if ( !this.model.isPaused )
			{
				if ( e.keyCode == Keyboard.SPACE )
				{
					this.dot.jump();
				}
			}
		}
		private function onpause(e:JBEvent):void
		{
			this.blocktimer.stop();
		}
		private function onunpause(e:JBEvent):void
		{
			this.blocktimer.start();
		}
		
		private var blocktimer:Timer;
		private function startBlocktimer():void
		{
			this.blocktimer = new Timer(2000);
			this.blocktimer.start();
			this.blocktimer.addEventListener(TimerEvent.TIMER, this.createBlock);
			this.blocktimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
		}
		private function createBlock(e:TimerEvent):void
		{
			var block:Block = new Block(this.model);
			block.activate(this.dot, this.platform);
			block.addEventListener(BlockEvent.COLLISION, this.endGame);
			this.platform.addChild(block);
		}
		private function endGame(e:BlockEvent):void
		{
			
			this.scenario.dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
			this.dark();
		}
		private function dark():void
		{
			this.boxarea.dark();
		}
	}
}