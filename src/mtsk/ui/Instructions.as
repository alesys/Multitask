package mtsk.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	public class Instructions extends Sprite
	{
		private var textField:TextField;
		public function Instructions(str:String, bgColor:uint=0xFFFFFF, brdColor:uint=0x000000)
		{
			var textFormat:TextFormat = new TextFormat("Arial",12,0x000000,true, true);
			
			this.textField = new TextField();
			this.textField.defaultTextFormat = textFormat;
			this.textField.text = str;
			addChild(this.textField);
			
			this.textField.border = true;
			this.textField.background = true;
			this.textField.wordWrap = true;
			this.textField.width = 150;
			this.textField.height = 40;
			this.textField.x = 100;
			this.textField.y = 100;
			this.textField.borderColor = brdColor;
			this.textField.backgroundColor = bgColor;
			this.textField.type = TextFieldType.DYNAMIC;
			this.textField.selectable = false;
			this.textField.autoSize = TextFieldAutoSize.LEFT;
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		private function init(e:Event):void
		{
			var timer:Timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.activate);
			timer.start();
		}
		private function activate(e:TimerEvent):void
		{
			this.textField.appendText("\n\nPress any key to START.");
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.startGame,false,0,true);
		}
		private function startGame(e:Event):void
		{
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.startGame);
			this.dispatchEvent(new Event(Event.COMPLETE));
			this.parent.removeChild(this);
		}
			
		
	}
}