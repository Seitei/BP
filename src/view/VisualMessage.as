package view
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	
	import utils.ResourceManager;

	public class VisualMessage extends Sprite
	{
		private var _textToShow:String;
		private var _textToShowTxt:TextField;
		private static var ANIMATION_TIME:Number;
		private var _topBar:Image;
		private var _botBar:Image;
		private var _bodyBg:Image;
		
		
		public function VisualMessage(text:String)
		{
			this.x = 400;
			this.y = 350;
			
			_textToShow = text;
			
			_bodyBg = new Image(ResourceManager.getInstance().getTexture("body_bg"));
			_bodyBg.pivotX = _bodyBg.width / 2;
			_bodyBg.pivotY = _bodyBg.height / 2;
			addChild(_bodyBg);
			
			_topBar = new Image(ResourceManager.getInstance().getTexture("top_bar"));
			_topBar.pivotX = _topBar.width / 2;
			_topBar.pivotY = _topBar.height / 2;
			_topBar.y = -100;
			addChild(_topBar);
			
			_botBar = new Image(ResourceManager.getInstance().getTexture("bot_bar"));
			_botBar.pivotX = _botBar.width / 2;
			_botBar.pivotY = _botBar.height / 2;
			_botBar.y = 100;
			addChild(_botBar);
			
			_textToShowTxt = new TextField(200, 50, _textToShow, "Verdana", 20, 0);
			_textToShowTxt.pivotX = _textToShowTxt.width / 2;
			_textToShowTxt.pivotY = _textToShowTxt.height / 2;
			addChild(_textToShowTxt);
			
		}

		public function set textToShow(value:String):void
		{
			_textToShow = value;
			_textToShowTxt.text = value;
		}

	}
}