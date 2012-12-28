package managers
{
	import actions.Action;
	
	import events.NotifyEvent;
	import events.NotifyStatusEvent;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.drm.AddToDeviceGroupSetting;
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import interfaces.IBuyableEntity;
	
	import model.EntityFactoryVO;
	import model.EntityVO;
	import model.SkinClass;
	import model.WorldVO;
	
	import net.NetConnect;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	
	import utils.GameStatus;
	import utils.MovieClipContainer;
	
	import view.SpriteEntity;
	import view.UI;
	
	
	public class Manager
	{
		//refers to the position to place the tiles
		private static const BOT:int = 1;
		private static const TOP:int = 0;
		
		private var _gold:int;
		private var _goldIncome:int;
		private var _player:Player;
		private var _nc:NetConnect;
		private var _gameManager:GameManager;
		private static var _instance:Manager;
		private var _state:int = GameStatus.STOPPED;
		private var _somethingToSend:Boolean;
		private var _main:Main;
		private var _entitiesClickedSignal:Signal;
		private var _playerName:String;
		private var _imReady:Boolean;
		private var _hesReady:Boolean;
		private var _hp:int;
		
		public function Manager()
		{
			//TODO receive from server
			_playerName = "Player_" + String(int(1000 * Math.random())) + "_";
			
			_nc = new NetConnect();
			_player = new Player(_playerName, _nc);
			_gameManager = GameManager.getInstance();
			_gameManager.playerName = _player.name;
			
			_main = Main.getInstance();
			
			_nc.addEventListener(NotifyEvent.NOTIFY_PLAYER_READY_EVENT, receivePlayerMessage);
			_nc.addEventListener(NotifyEvent.NOTIFY_ACTION_EVENT, receiveActionMessage);
			_nc.addEventListener(NotifyEvent.NOTIFY_NEIGHBOR_EVENT, buildPlayersWorld);
			_nc.addEventListener(NotifyStatusEvent.NOTIFY_STATUS, showStatus);
			
			_entitiesClickedSignal = new Signal(Array);
			_entitiesClickedSignal.add(entityClickedSignalhandler);
			
		}
		
		public function get hp():int
		{
			return _hp;
		}

		public function set hp(value:int):void
		{
			_hp = value;
			UI.getInstance().hp = _hp;
		}

		public function get goldIncome():int
		{
			return _goldIncome;
		}

		public function set goldIncome(value:int):void
		{
			_goldIncome = value;
			_player.goldIncome = value;
			UI.getInstance().goldIncome = _goldIncome;
		}

		public function get imReady():Boolean
		{
			return _imReady;
		}

		public function set imReady(value:Boolean):void
		{
			_imReady = value;
		}

		public function getPlayerName():String {
			return _player.name;
		}
		
		public function dispatchHandler(clickedEntities:Array, point:Point):void {
			if(_state == GameStatus.STOPPED)
				_entitiesClickedSignal.dispatch(clickedEntities, point);
		}
		
		private function entityClickedSignalhandler(array:Array, point:Point):void {
			var entitiesVector:Vector.<EntityVO> = new Vector.<EntityVO>;
			for each(var id:String in array){
				var entity:EntityVO = WorldVO.getInstance().getEntity(id);
				entitiesVector.push(entity);
			}
			UI.getInstance().entitiesClickedHandler(entitiesVector, point);
		}
		
		public function buildPlayersWorld(event:NotifyEvent = null):void {
			
			// TODO ********************* CHANGE FOR EXTERNAL INPUT //
			var bgEntity:EntityVO = EntityFactoryVO.getInstance().makeEntity(_playerName, "background", new Point(350, 350));
			var bg_action:Action = new Action("addEntity", bgEntity);
			handler(bg_action);
			
			var shipEntity:EntityVO = EntityFactoryVO.getInstance().makeEntity(_playerName, "ship", new Point(182.5, 700 - 182.5)); 
			var ship_action:Action = new Action("addEntity", shipEntity);
				
			handler(ship_action);
			
			var shipConfigurationSlots:Array = new Array();
			
			shipConfigurationSlots[4] = [1, 0, 0, 0, 0, 0, 0, 0, 0];
			shipConfigurationSlots[3] = [1, 1, 1, 0, 0, 0, 0, 0, 0];
			shipConfigurationSlots[2] = [1, 1, 1, 1, 1, 0, 0, 0, 0];
			shipConfigurationSlots[1] = [1, 1, 1, 1, 1, 1, 1, 0, 0];
			shipConfigurationSlots[0] = [1, 1, 1, 1, 1, 1, 1, 1, 1];
			
			for(var i:int = 0; i < shipConfigurationSlots.length; i++) {
			
				for(var j:int = 0; j < shipConfigurationSlots[i].length; j++) {
					if(shipConfigurationSlots[i][j] == 1) {
						
						var point:Point = new Point();
						point.x = (j * (30 + 2))  + 30;
						point.y = (j * (30 + 2))  + 28 + 10 * 40 + i * 64;
						var tile:EntityVO = EntityFactoryVO.getInstance().makeEntity(_playerName,"tile", point);
						tile.rotation = 45 * Math.PI / 180;
						var tile_action:Action = new Action("addEntity", tile);
						handler(tile_action);
					}
				}
			}
			
			//send now with a delay, remove this patch when final implementation is in progress
			var timer:Timer = new Timer(200, 1);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
				
			// TODO ********************* CHANGE FOR EXTERNAL INPUT //
			
			_main.startGame();
		}
		
		private function onTimer(e:TimerEvent):void {
			sendActionBuffer();
		}
		
		public function sendPlayerReadyEvent():void {
			_imReady = true;
			if(_hesReady)
				advanceGameState();
			_player.sendPlayerMessage(_playerName + "_placeReadyButton");
		}
			
		
		public function resetGame():void {
			//temporary - here we come when someone wins
			_state = GameStatus.STOPPED;
			_gameManager.state = _state;
			UI.getInstance().state = _state;

			UI.getInstance().resetUI();
			_gameManager.world.resetContent();
			Main.getInstance().getRenderer().resetDisplayContent();
			Main.getInstance().reset();
			
			buildPlayersWorld();
		}
		
		
		private function showStatus(e:NotifyStatusEvent):void {
			//for fast layout tests
			if(e.status.indexOf("NetConnection") != -1)
				buildPlayersWorld();
			
			_main.storeStatusData(e.status);
		}
		
		public function handler(action:Action):void {
			
			switch(action.type) {
				case "addEntity":
					if(action.entity is IBuyableEntity)
						updatePlayerGold(-IBuyableEntity(action.entity).cost);
					break;
				case "sell":
					updatePlayerGold(+IBuyableEntity(action.entity).cost / 2);
					break;
				case "upgrade":
					updatePlayerGold(-IBuyableEntity(action.entity).cost);
					break;
			}
			
			if(action.entity.buff){
				switch(action.entity.buff.buffType){
					case "goldIncomeImprovement":
						goldIncome += action.entity.buff.buffStats;
				}
			}
			
				
			_gameManager.updateWorld(action);
			
			if(action.entity.type != "background") {
				_player.addToActionBuffer(action);
			}
			_somethingToSend = true;
			
		}
		
		public function updateUITurnCountdown(count:int):void {
			UI.getInstance().updateUITurnCountdown(count);
		}
		
		public function advanceGameState():void {
			
			_hesReady = false;
			_imReady = false;
			_state = GameStatus.nextState(_state);
			_gameManager.state = _state;
			_main.state = _state;
			UI.getInstance().state = _state;
			
			if(_state == GameStatus.COUNTDOWN_STOPPED && _somethingToSend) {
				sendActionBuffer();
			}
			
			if(_state == GameStatus.STOPPED) {
				updatePlayerGold(_player.goldIncome);
				Main.getInstance().getRenderer().pauseOrResumeAnimations();
			}
			
			if(_state == GameStatus.PLAYING) {
				Main.getInstance().getRenderer().pauseOrResumeAnimations();
			}
		}
		
		public function sendActionBuffer():void {
			if (_somethingToSend) {
				_somethingToSend = false;				
				_player.sendActionBuffer();
			}
		}
		
		public function getPlayerGold():int {
			_gold = _player.gold;
			return _gold;
		}
		
		public function getPlayerGoldIncome():int {
			_goldIncome = _player.goldIncome;
			return _goldIncome;
		}
		
		private function updatePlayerGold(value:int):void {
			_player.gold += value;
			UI.getInstance().gold = _player.gold;
		}
		
		private function receiveActionMessage(event:NotifyEvent):void {
			_player.receiveMessage(event.message);
			_gameManager.updatePlayersWorld(event.message);
		}
		
		private function receivePlayerMessage(event:NotifyEvent):void {
			_hesReady = true;
			/*if(_imReady){
				advanceGameState();
				UI.getInstance().updateReadyButton("1_1");
			}
			else
				UI.getInstance().updateReadyButton("0_1");*/
		}
		
		
		public static function getInstance():Manager {
			if ( _instance == null )
				_instance = new Manager;
			return _instance;
		}
		
		public function loop(e:starling.events.Event):void {
			_gameManager.loop(e);
		}
		
		
		
		
		
		
		
		
	}	
}