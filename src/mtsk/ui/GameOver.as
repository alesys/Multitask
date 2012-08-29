package mtsk.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	public class GameOver extends Sprite
	{
		public function GameOver()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		private function init(e:Event):void
		{
			this.drawBack();
			this.drawMSG();
			this.y = this.stage.stageHeight * -1;
			var timer:Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.show);
			timer.start();
		}
		private function show(e:TimerEvent):void
		{
			
			TweenLite.to(this, 2, {y:0, ease:Bounce.easeOut});
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, listenSpaceBar);
		}
		private function listenSpaceBar(ke:KeyboardEvent):void
		{
			if ( ke.keyCode == Keyboard.SPACE )
			{
				
				this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, listenSpaceBar);
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		private function drawBack():void{
			this.graphics.beginFill(0x000000,0.8);
			this.graphics.drawRect(0,0,this.stage.stageWidth, this.stage.stageHeight);
			this.graphics.endFill();
		}
		private function drawMSG():void
		{
			var textField:TextField = new TextField();
			var textFormat:TextFormat = new TextFormat("Arial",40,0xFFFFFF,true,true);
			this.addChild(textField);
			textField.defaultTextFormat = textFormat;
			textField.text = "GAME OVER";
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.selectable = false;
			textField.x = (this.stage.stageWidth - textField.width) >> 1;
			textField.y = (this.stage.stageHeight - textField.height) >> 1;
			
			var footer:TextField = new TextField();
			var footerFormat:TextFormat = new TextFormat("Arial", 12,0xffffff, false, true);
			this.addChild(footer);
			footer.defaultTextFormat = footerFormat;
			footer.text = "Press SPACEBAR to try again";
			footer.autoSize = TextFieldAutoSize.LEFT;
			footer.selectable = false;
			footer.x = (this.stage.stageWidth - footer.width ) >> 1;
			footer.y = textField.y + textField.height + 10;
		}
	}
}