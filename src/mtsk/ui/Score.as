package mtsk.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	public class Score extends Sprite
	{
		private var textfield:TextField;
		private var textformat:TextFormat;
		private var score:Number = 0;
		private var timer:Timer;
		private var doneLvl1:Boolean;
		private var doneLvl2:Boolean;
		public function Score()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		private function init(e:Event):void
		{
			this.textformat = new TextFormat("Arial",24,0xFFFFFF,true, true);
			this.textformat.bold = true;
			this.textfield = new TextField();
			this.textfield.x = 30;
			this.textfield.y = 30;
			this.textfield.defaultTextFormat=this.textformat;
			this.textfield.text = "Score: "+ this.score.toString()+ " ";
			this.textfield.autoSize = TextFieldAutoSize.LEFT;
			this.textfield.selectable = false;
			this.addChild(this.textfield);
			this.timer = new Timer(500,0);
			this.timer.addEventListener(TimerEvent.TIMER, this.incScore);
		}
		public function unpause():void
		{
			this.timer.start();	
		}
		public function pause():void
		{
			this.timer.stop();
		}
		private function incScore(e:TimerEvent):void
		{
			this.score+=5;
			this.textfield.text = "Score: " + this.score.toString() + " ";
			if ( !this.doneLvl1 && this.score > 200 )
			{
				this.doneLvl1 = true;
				this.pause();
				this.dispatchEvent(new ScoreEvent(ScoreEvent.LEVEL1_COMPLETED));
			}
			if ( !this.doneLvl2 && this.score > 600 )
			{
				this.doneLvl2 = true;
				this.dispatchEvent(new ScoreEvent(ScoreEvent.LEVEL2_COMPLETED));
			}
		}
	}
}