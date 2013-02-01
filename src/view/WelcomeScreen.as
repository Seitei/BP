package view
{
	import events.ButtonTriggeredEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.ExtendedButton;
	import utils.ResourceManager;
	
	public class WelcomeScreen extends Sprite
	{
		private var _playButton:ActionButton;
		private var _timer:Timer;
		private var _dotsContainer:Sprite;
		
		public function WelcomeScreen()
		{
			super();
			initPlayButton();
		}
		
		private function initPlayButton():void {
			_playButton = new ActionButton(
				ResourceManager.getInstance().getTexture("play_up_btn"), 
				"ready", 
				"",
				null,
				null,
				"",
				ResourceManager.getInstance().getTexture("play_down_btn"), 
				ResourceManager.getInstance().getTexture("play_hover_btn")
			);
			
			_playButton.pivotX = _playButton.width / 2;
			_playButton.pivotY = _playButton.height / 2;
			_playButton.x = 400;
			_playButton.y = 350;
			addChild(_playButton);
			_playButton.addEventListener(ButtonTriggeredEvent.BUTTON_TRIGGERED_EVENT, onReadyButtonTouched);
		}
		
		private function onReadyButtonTouched(e:ButtonTriggeredEvent):void {
			
			removeChild(_playButton, true);
		
			var image:Image = new Image(ResourceManager.getInstance().getTexture("waiting_for_players"));
			image.x = 5;
			image.y = 5;
			addChild(image);
			
			_dotsContainer = new Sprite();
			addChild(_dotsContainer);
			_dotsContainer.x = 150;
			_dotsContainer.y = 16;
			
			_timer = new Timer(700, 4);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
			
			dispatchEvent(new Event("onPlayTouched", true));
		}
	
		private function onTimer(e:TimerEvent):void {
			
			var image:Image = new Image(ResourceManager.getInstance().getTexture("period"));
			image.x = _timer.currentCount * 7;
			_dotsContainer.addChild(image);
			
			if(_timer.repeatCount == _timer.currentCount){
				_dotsContainer.removeChildren(0, -1, true);	
				_timer.reset();
				_timer.start();
			}
		}
	
	
	
	
	
	
	
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}