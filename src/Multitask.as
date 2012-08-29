package
{
	import events.GameEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import mtsk.avoiddots.AvoidDots;
	import mtsk.avoiddots.ui.Grid;
	import mtsk.drive.Drive;
	import mtsk.jumpblocks.JumpBlocks;
	import mtsk.ui.BoxArea;
	import mtsk.ui.GameOver;
	import mtsk.ui.Instructions;
	import mtsk.ui.Score;
	import mtsk.ui.ScoreEvent;
	import mtsk.ui.Title;

	[SWF(width="600", height="600", frameRate="60", backgroundColor="#000000")]
	public class Multitask extends Sprite
	{
		private var avoid:AvoidDots;
		private var score:Score;
		private var jump:JumpBlocks;
		private var drive:Drive;
		private var instructionText:Array;
		private var currentInstructionIndex:Number;
		public function Multitask()
		{
			init();
			
		}
		private function init():void
		{
			this.currentInstructionIndex = 0;
			this.instructionText = [
				"Use LEFT and RIGHT arrow keys to avoid the evil circles.",
				"Use SPACE BAR to jump over the evil Sqares.",
				"Use UP and DOWN arrow keys to avoid crashing."
			];
			
			this.initAvoidDots();
			this.initTitle();
			this.initInstructions();
			this.initScore();
			
		}
		private function initAvoidDots():void
		{
			this.avoid = new AvoidDots();
			this.avoid.addEventListener(GameEvent.GAME_OVER, this.gameover);
			this.addChild(this.avoid);
		}
		private function initTitle():void
		{
			var title:Title = new Title();
			this.addChild(title);
		}
		private function initInstructions():void
		{
			var instructions:Instructions = new Instructions(this.instructionText[this.currentInstructionIndex]);
			instructions.addEventListener(Event.COMPLETE, this.startGame);
			this.addChild(instructions);
			this.currentInstructionIndex++;
		}
		private function initScore():void
		{
			this.score = new Score();
			this.addChild(this.score);
			this.score.addEventListener(ScoreEvent.LEVEL1_COMPLETED, this.onLvl1);
			this.score.addEventListener(ScoreEvent.LEVEL2_COMPLETED, this.onLvl2);
		}
		private function startGame(e:Event):void
		{
			this.avoid.unpause();
			this.score.unpause();
			if ( this.jump )
			{
				if ( this.jump.isActive )
				{
					this.jump.unpause();	
				} else
				{
					this.jump.activate();
				}
			}
			if ( this.drive )
			{
				this.drive.activate();
			}
		}
		private function onLvl1(e:Event):void
		{
			this.avoid.resize(1);
			this.score.pause();
			this.jump = new JumpBlocks();
			this.addChild(this.jump);
			this.jump.addEventListener(GameEvent.GAME_OVER, gameover);
			this.initInstructions();
		}
		private function onLvl2(e:Event):void
		{
			this.avoid.resize(2);
			this.score.pause();
			this.jump.transition();
			this.jump.pause();
			this.drive = new Drive();
			this.drive.addEventListener(GameEvent.GAME_OVER, gameover);
			this.addChild(this.drive);
			this.initInstructions();
		}
		private function gameover(e:GameEvent):void
		{
			this.score.pause();
			this.avoid.pause();
			if ( this.jump) this.jump.pause();
			if ( this.drive) this.drive.pause();
			var gameOver:GameOver = new GameOver();
			this.addChild(gameOver);
			gameOver.addEventListener(Event.COMPLETE, this.reset);
		}
		private function reset(e:Event):void
		{
			this.removeChildren(0, this.numChildren -1);
			this.score = null;
			this.avoid = null;
			this.jump = null;
			this.drive = null;
			this.init();
		}
	}
}