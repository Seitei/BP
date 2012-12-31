package view
{
	import Signals.BroadcastSignal;
	
	import actions.Action;
	
	import events.ButtonClickedEvent;
	import events.SelectorPanelEvent;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import interfaces.IBuyableEntity;
	import interfaces.IUnitSpawner;
	
	import managers.Manager;
	
	import model.ActionButtonVO;
	import model.EntityFactoryVO;
	import model.EntityVO;
	import model.UnitVO;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	import utils.GameStatus;
	import utils.ResourceManager;
	
	public class UI extends Sprite
	{
		private static var _instance:UI;
		private static const DEFAULT:int = 0;
		private static const WAITING_FOR_TARGET:int = 1;
		private static const BOT:int = 1;
		private static const TOP:int = 0;
		
		private var _clickedEntity:EntityVO;
		private var _broadcastSignal:BroadcastSignal;
		private var _manager:Manager;
		private var _stateTxt:TextField;
		private var _playerNameTxt:TextField;
		private var _playerName:String;
		private var _countDownTxt:TextField;
		private var _statusNetTxt:TextField;
		private var _timer:Timer;
		private var _state:int = GameStatus.STOPPED;
		private var _messageCount:int = 1;
		private var _showingCountDown:Boolean;
		private var _selectorPanel:SelectorPanel;
		private var _status:int = DEFAULT;
		private var _action:Action;
		private var _gold:int;
		private var _goldIncome:int;
		private var _hp:int;
		private var _rallypointContainer:Sprite;
		private var _statusArray:Array;
		private var _showingEntityUI:Boolean = false;
		private var _actionBar:ActionBar;
		private var _mouseCursorImage:Image;
		private var _actionIssued:Action;
		
		public function UI(showDebugData:Boolean)
		{
			_manager = Manager.getInstance();
			_gold = _manager.getPlayerGold();
			_goldIncome = _manager.getPlayerGoldIncome();
			_playerName = _manager.getPlayerName(); 
			_statusArray = new Array();
				
			initActionbar();
			
			if (showDebugData)
				showDebugInfo();
		}
		
		public function set hp(value:int):void
		{
			_hp = value;
			_actionBar.hp = _hp;
		}

		private function initActionbar():void {
			_actionBar = new ActionBar();
			_actionBar.x = 700;
			_actionBar.gold = _gold;
			_actionBar.goldIncome = _goldIncome;
			addChild(_actionBar);
			_actionBar.addEventListener(ButtonClickedEvent.BUTTON_CLICKED_EVENT, onButtonClicked);	
		}
		
		private function onButtonClicked(e:ButtonClickedEvent):void {
			
			//_manager.sendPlayerReadyEvent();
			
			//here we hide the mouse and show the ghost image of the entity if the button had a mouse cursor texture set
			if(e.mouseCursorTexture) {
				Mouse.hide();
				_mouseCursorImage = new Image(e.mouseCursorTexture);
				addChild(_mouseCursorImage);
				
				_mouseCursorImage.x = e.startingPosition.x;
				_mouseCursorImage.y = e.startingPosition.y;
				_mouseCursorImage.touchable = false;
				_mouseCursorImage.pivotX = _mouseCursorImage.width / 2;
				_mouseCursorImage.pivotY = _mouseCursorImage.height / 2;
				stage.addEventListener(TouchEvent.TOUCH, onMove);
			}
			
			var newEntity:EntityVO = EntityFactoryVO.getInstance().makeEntity(_playerName, e.entityType, null);
			_actionIssued = new Action(e.actionType, newEntity);
			
		}
		
		private function onMove(e:TouchEvent):void {
			var touch:Touch = e.touches[0];
			
			if(touch.phase == "hover"){
				_mouseCursorImage.x = touch.globalX;		
				_mouseCursorImage.y = touch.globalY;
			}
		}
		
		
		public function set playerName(value:String):void
		{
			_playerName = value;
		}

		public function set gold(value:int):void {
			_gold = value;
			_actionBar.gold = value;		
		}
		
		public function set goldIncome(value:int):void
		{
			_goldIncome = value;
			_actionBar.goldIncome = value;
		}
		
		public function entityClickedHandler(entity:EntityVO):void {
			if(_status == WAITING_FOR_TARGET){
				if(_action.entity is IUnitSpawner) {
					//IUnitSpawner(_action.entity).rallypoint = point; 
					//_action.target = point;
					dispatchSignal(_action);
					//showRallyPoint(point);					
					_status = DEFAULT;
				}
			}
			else {
				_clickedEntity = entity;
				if(_actionIssued) {
					_actionIssued.entity.position = _clickedEntity.position;
					
					//restoring the mouse appearance
					Mouse.show();
					removeChild(_mouseCursorImage);
					_mouseCursorImage.dispose();
					
					dispatchSignal(_actionIssued);
					_actionIssued = null;
				}
				else {
					showEntityUI(_clickedEntity);
				}
			}
		}
		
		
		private function showEntityUI(entity:EntityVO):void {
			
			
			_showingEntityUI = true;
			/*if(_selectorPanel)
				removeEntityUI();*/
			_selectorPanel = new SelectorPanel(entity.actionButtons, entity.position);
			_selectorPanel.addEventListener("selectorPanelEvent", onSelectorTouched);
			_selectorPanel.x = entity.position.x; _selectorPanel.y = entity.position.y;
			addChild(_selectorPanel);
			
		}
		
		 
		private function showRallyPoint(entityPosition:Point, rallyPoint:Point):void {
			_showingEntityUI = true;
			//da line
			_rallypointContainer = new Sprite();
			
			var diff:Point = entityPosition.subtract(rallyPoint); 
			var dist:Number = diff.length;
			
			var quad:Quad = new Quad(2, dist, 0xff5500);
			quad.x = entityPosition.x; quad.y = entityPosition.y;
			
			quad.rotation = Math.atan2(diff.y, diff.x) + 90 * (Math.PI / 180);
			_rallypointContainer.addChild(quad);
			
			//da point
			var texture:Texture = ResourceManager.getInstance().getTexture("rallypoint");
			
			var rallypoint:Button = new Button(texture);
			rallypoint.x = rallyPoint.x; rallypoint.y = rallyPoint.y;
			rallypoint.pivotX = rallypoint.width/2; rallypoint.pivotY = rallypoint.width/2;
			rallypoint.useHandCursor = false;
			_rallypointContainer.addChild(rallypoint);
			
			addChild(_rallypointContainer);
		}

		
		public function updateUITurnCountdown(count:int):void {
			_actionBar.updateUITurnCountdown(count);
		}
			
		private function onSelectorTouched(e:SelectorPanelEvent):void {
				
				var action:Action;
				
				switch(e.actionType) {
					case "addEntity":
						var newEntity:EntityVO = EntityFactoryVO.getInstance().makeEntity(_playerName, e.entityType, _clickedEntity.position);
						action = new Action(e.actionType, newEntity);
						break;
					case "sell":
						action = new Action(e.actionType, _clickedEntity);
						break;
					case "setRallypoint":
						//TODO change mouse cursor to a custom one
						_status = WAITING_FOR_TARGET;
						//action = new Action(e.actionType, entity);
						break;
					case "upgrade":
						var entity2:EntityVO = EntityFactoryVO.getInstance().makeEntity(_playerName, e.entityType, _clickedEntity.position);
						entity2.id = _clickedEntity.id;
						entity2.parentContainer = _clickedEntity.parentContainer;
						action = new Action(e.actionType, entity2);
						break;
				}
			dispatchSignal(action);
			removeEntityUI();
		}
		
		private function dispatchSignal(action:Action):void {
			if(action.type == "addEntity" && IBuyableEntity(action.entity).cost > _manager.getPlayerGold()) {
				trace("cant do bro");
			}
			else {
				_broadcastSignal = new BroadcastSignal(action);
				_broadcastSignal.signal.add(_manager.handler);
				_broadcastSignal.dispatch();
				//to test stuff I send right away
				_manager.sendActionBuffer();
			}
		}
		
		public function removeEntityUI():void {
			if(!_showingEntityUI) return;
			
			removeChild(_selectorPanel);
			_selectorPanel.dispose();

			if(_rallypointContainer){
				removeChild(_rallypointContainer);
				_rallypointContainer.dispose();
			}
			_showingEntityUI = false;
		}
		
		private function showDebugInfo():void {
			_stateTxt = new TextField(100, 50, "STOPPED");
			_stateTxt.x = -15;
			_stateTxt.y = -10;
			addChild(_stateTxt);
			
			_playerNameTxt = new TextField(100, 50, _playerName);
			_playerNameTxt.x = -5;
			_playerNameTxt.y = 5;
			
			addChild(_playerNameTxt);
		}
		
		public function storeStatusChange(status:String):void {
			showNewNetStatusLine(status);
			_messageCount ++;
		}
		
		private function showNewNetStatusLine(status:String):void {
			var statusNetTxt:TextField = new TextField(200, 20, status, "Verdana", 10);
			statusNetTxt.x = 0;
			statusNetTxt.y = 150;
			statusNetTxt.y = 10 * _messageCount + 30;
			
			addChild(statusNetTxt);
		}
		
		public function set state(state:int):void {
			_state = state;
			_stateTxt.text = GameStatus.textStatusArray[_state];
			
			if(_state == GameStatus.COUNTDOWN_PLAYING || _state == GameStatus.COUNTDOWN_STOPPED){
				showCountDown();
			}
			
			if(_state == GameStatus.STOPPED)
				_actionBar.resetReadyButtons();
			
			if(_state == GameStatus.COUNTDOWN_STOPPED && _showingEntityUI)
				removeEntityUI();
		}
		
		public function resetUI():void {
			_showingCountDown = false;
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			removeChild(_countDownTxt);
		}
		
		public function showCountDown():void {
			_showingCountDown = true;
			_timer = new Timer(1000, 3);
			_countDownTxt = new TextField(200, 100, "3", "Verdana", 60);
			_countDownTxt.x = 300;
			_countDownTxt.y = 200;
			addChild(_countDownTxt);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
			_actionBar.hideTurnCountdown();
		}
		
		private function onTimer(e:TimerEvent):void {
			_countDownTxt.text = String(int(_countDownTxt.text) - 1);
			if ( int(_countDownTxt.text) == 0) {
				_showingCountDown = false;
				removeChild(_countDownTxt);
				_timer.removeEventListener(TimerEvent.TIMER, onTimer);
				_manager.advanceGameState();
			}
				
		}
		
		public static function getInstance(showDebugData:Boolean = true):UI {
			if ( _instance == null )
				_instance = new UI(showDebugData);
			return _instance;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}