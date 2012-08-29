package mtsk.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Title extends Sprite
	{
		public function Title()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
		private function init(e:Event):void
		{
			var title:TextField = new TextField();
			var titleFormat:TextFormat = new TextFormat("Arial",18,0x000000,true, true);
			var footer:TextField = new TextField();
			var footerFormat:TextFormat = new TextFormat("Arial", 11, 0xFFFFFF, false, true);
			
			this.addChild( title);
			this.addChild( footer);
			
			title.selectable = false;
			footer.selectable = false;
			
			title.defaultTextFormat = titleFormat;
			footer.defaultTextFormat = footerFormat;
			
			title.text = "Multitask ";
			footer.text = "code by Rolf ";
			
			title.autoSize = TextFieldAutoSize.RIGHT;
			footer.autoSize = TextFieldAutoSize.RIGHT;
			
			title.x = this.stage.stageWidth - title.width - 10;
			footer.x = this.stage.stageWidth - footer.width - 10;
			title.y = 10;
			footer.y = title.y + title.height - 8;
			
		}
	}
}