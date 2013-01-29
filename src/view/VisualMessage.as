package view
{
	
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.extensions.ClippedSprite;
	import starling.text.TextField;
	
	import utils.ResourceManager;

	public class VisualMessage extends Sprite
	{
		private var _textToShow:String;
		private var _textToShowTxt:TextField;
		private static var ANIMATION_TIME:Number = 1.0;
		private var _topBar:Image;
		private var _botBar:Image;
		private var _bodyBg:Image;
		private var _clippedText:ClippedSprite;
		
		public function VisualMessage(text:String)
		{
			this.x = 400;
			this.y = 350;
			
			_textToShow = text;
			
			_bodyBg = new Image(ResourceManager.getInstance().getTexture("body_bg"));
			_bodyBg.pivotX = _bodyBg.width / 2;
			_bodyBg.pivotY = _bodyBg.height / 2;
			_bodyBg.scaleY = 0;
			addChild(_bodyBg);
			
			_topBar = new Image(ResourceManager.getInstance().getTexture("top_bar"));
			_topBar.pivotX = _topBar.width / 2;
			_topBar.pivotY = _topBar.height / 2;
			_topBar.y = -100;
			_topBar.x = -750;
			addChild(_topBar);
			
			_botBar = new Image(ResourceManager.getInstance().getTexture("bot_bar"));
			_botBar.pivotX = _botBar.width / 2;
			_botBar.pivotY = _botBar.height / 2;
			_botBar.y = 100;
			_botBar.x = 750;
			addChild(_botBar);
			
			_textToShowTxt = new TextField(700, 200, _textToShow, "Verdana", 60, 0);
			
			_clippedText = new ClippedSprite();
			_clippedText.addChild(_textToShowTxt);
			_clippedText.pivotX = _clippedText.width / 2;
			_clippedText.pivotY = _clippedText.height / 2;
			_clippedText.clipRect = new Rectangle(0, 350, 700, 1);
			addChild(_clippedText);
			
			animate();
			
		}

		private function animate():void {
			
			var topBarTeen:Tween = new Tween(_topBar, ANIMATION_TIME, Transitions.EASE_IN_OUT);
			topBarTeen.animate("x", 0);
			Starling.juggler.add(topBarTeen);
			topBarTeen.onComplete = onTweenComplete;
			
			var botBarTween:Tween = new Tween(_botBar, ANIMATION_TIME, Transitions.EASE_IN_OUT);
			botBarTween.animate("x", 0);
			Starling.juggler.add(botBarTween);
			
			var bodyBgTween:Tween = new Tween(_bodyBg, ANIMATION_TIME, Transitions.EASE_IN_OUT);
			bodyBgTween.animate("scaleY", 1);
			Starling.juggler.add(bodyBgTween);
			
			var timer:Timer = new Timer(20, 25);
			timer.addEventListener(TimerEvent.TIMER, onTimerInitClipped);
			timer.start();
			
		}
		
		private function onTimerInitClipped(e:TimerEvent):void {
			
			_clippedText.clipRect.y --;
			_clippedText.clipRect.height += 2;
		}
		
		private function onTimerEndClipped(e:TimerEvent):void {
			
			_clippedText.clipRect.y ++;
			_clippedText.clipRect.height -= 2;
		}
		
		private function onTweenComplete():void {
			
			var topBarTeen:Tween = new Tween(_topBar, ANIMATION_TIME, Transitions.EASE_IN);
			topBarTeen.animate("x", 750);
			topBarTeen.delay = 0.5;
			topBarTeen.onStart = onEndingTweenStart;
			Starling.juggler.add(topBarTeen);
			
			var botBarTween:Tween = new Tween(_botBar, ANIMATION_TIME, Transitions.EASE_IN);
			botBarTween.delay = 0.5;
			botBarTween.animate("x", -750);
			Starling.juggler.add(botBarTween);
		
			var bodyBgTween:Tween = new Tween(_bodyBg, ANIMATION_TIME, Transitions.EASE_IN_OUT);
			bodyBgTween.delay = 0.5;
			bodyBgTween.animate("scaleY", 0);
			Starling.juggler.add(bodyBgTween);
			
			
			
		}
		
		private function onEndingTweenStart():void {
			
			var timer:Timer = new Timer(20, 25);
			timer.addEventListener(TimerEvent.TIMER, onTimerEndClipped);
			timer.start();
		}
		
		
		
		
		
		public function set textToShow(value:String):void
		{
			_textToShow = value;
			_textToShowTxt.text = value;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

	}
}