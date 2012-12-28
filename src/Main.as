package
{
	import flash.events.TimerEvent;
	import flash.profiler.showRedrawRegions;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import managers.Manager;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.GameStatus;
	
	import view.Renderer;
	import view.UI;
	
	public class Main extends Sprite 
	{
		private static var _instance:Main;
		private static var _renderer:Renderer;
		private var _timer:Timer;
		private var _uiTimer:Timer;
		private var _ui:UI;
		private var _manager:Manager;
		private var _status:String;
		private static const SHOW_DEBUG_INFO:Boolean = true;
		private static const TURN_TIME:int = 998;
		private var _state:int = GameStatus.STOPPED;
		
		public function Main()
		{
			_instance = this;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			_renderer = Renderer.getInstance();
			_ui = UI.getInstance(true);
			_manager = Manager.getInstance();
		}
		
		private function onAdded (e:Event):void
		{
			addChild(_renderer);
			addChild(_ui);
		}
		
		public function startGame():void {
			_uiTimer = new Timer(1000, TURN_TIME);
			_uiTimer.addEventListener(TimerEvent.TIMER, onUITimerEvent);
			_uiTimer.start();
			
			_timer = new Timer(TURN_TIME * 1000, 1);
			_timer.addEventListener(TimerEvent.TIMER, onTimerEvent);
			_timer.start();
		}
		
		private function onUITimerEvent(event:TimerEvent):void {
			_manager.updateUITurnCountdown(TURN_TIME - _uiTimer.currentCount);
		}
		
		private function onTimerEvent(event:TimerEvent):void {
			_manager.advanceGameState();
			_manager.sendActionBuffer();
		}
		
		public function reset():void {
			_state = GameStatus.STOPPED;
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
			
			_uiTimer.stop();
			_uiTimer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
		}
		
		public function set state(state:int):void {
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
			_uiTimer.stop();
			_uiTimer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
			
			_state = state;
			
			if (_state == GameStatus.PLAYING) {
				addEventListener(Event.ENTER_FRAME, loop);
				startGame();
			}
			if(_state == GameStatus.STOPPED) {
				removeEventListener(Event.ENTER_FRAME, loop);
				startGame();
			}
		}
		
		private function loop(event:Event):void {
			_manager.loop(event);
		}
		
		public function storeStatusData(status:String):void {
			_status = status;
			if (SHOW_DEBUG_INFO)
				_ui.storeStatusChange(_status);
		}
		
		public static function getInstance():Main {
			return _instance;
		}
		
		public function getRenderer():Renderer {
			return _renderer;
		}
		
		
		
	}
}