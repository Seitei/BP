package managers
{
	import actions.Action;
	
	import events.NotifyEvent;
	import events.NotifyNeighborConnectedEvent;
	import events.NotifyStatusEvent;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.drm.AddToDeviceGroupSetting;
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import interfaces.IBuyableEntity;
	
	import model.BackgroundVO;
	import model.EntityFactoryVO;
	import model.EntityVO;
	import model.ShipVO;
	import model.SkinClass;
	import model.TileVO;
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
		private var _entityClickedSignal:Signal;
		private var _playerName:String;
		private var _imReady:Boolean;
		private var _hesReady:Boolean;
		private var _myHp:int;
		private var _ui:UI;
		
		//for the moment, the starter value of the enemy HP is hardcoded to 500
		private var _enemyHp:int = 500;
		
		public function Manager()
		{
			//TODO receive from server
			_playerName = "Player_" + String(int(1000 * Math.random())) + "_";
			_nc = new NetConnect();
			_player = new Player(_playerName, _nc); 
			_gold = _player.gold;
			_goldIncome = _player.goldIncome;
			_myHp = _player.hp;
			_gameManager = GameManager.getInstance();
			_gameManager.playerName = _player.name;
			
			_main = Main.getInstance();
			
			_nc.addEventListener(NotifyEvent.NOTIFY_PLAYER_READY_EVENT, receiveReadyMessage);
			_nc.addEventListener(NotifyEvent.NOTIFY_ACTION_EVENT, receiveActionMessage);
			_nc.addEventListener(NotifyNeighborConnectedEvent.NOTIFY_NEIGHBOR_CONNECTED_EVENT, buildPlayersWorld);
			_nc.addEventListener(NotifyStatusEvent.NOTIFY_STATUS, showStatus);
			
			_entityClickedSignal = new Signal(String, String);
			_entityClickedSignal.add(entityClickedSignalhandler);
			initUI();
			
		}
		
		private function initUI():void {
			UI.getInstance().gold = _gold;
			UI.getInstance().myHp = _myHp;
			UI.getInstance().enemyHp = _enemyHp;
			UI.getInstance().goldIncome = _goldIncome;
			UI.getInstance().playerName = _playerName;
			_ui = UI.getInstance();
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
		
		public function dispatchHandler(clickedEntityId:String, operation:String):void {
			if(_state == GameStatus.STOPPED)
				_entityClickedSignal.dispatch(clickedEntityId, operation);
		}
		
		private function entityClickedSignalhandler(id:String, operation:String):void {
			var entity:EntityVO = WorldVO.getInstance().getEntity(id);
			UI.getInstance().entityClickedHandler(entity, operation);
			
		}
		
		public function buildPlayersWorld(e:NotifyNeighborConnectedEvent = null):void {
			
			UI.getInstance().visible = true;
			// TODO ********************* CHANGE FOR EXTERNAL INPUT //
			//tests only
			//if(e) return;
			if(e){
				if(e.connectionOrder == "second"){
					UI.getInstance().enableButtons(false);
				}
			}
		
			var bgEntity:EntityVO = new BackgroundVO(350, 350);
			var bg_action:Action = new Action("addEntity", bgEntity);
			handler(bg_action);
			
			var shipEntity:EntityVO = new ShipVO(182.5, 700 - 182.5); 
			var ship_action:Action = new Action("addEntity", shipEntity);
			shipEntity.owner = _playerName;
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
						point.x = (j * (30 + 2))  + 28;
						point.y = (j * (30 + 2))  + 16 + 10 * 40 + i * 64;
						var tile:EntityVO = EntityFactoryVO.getInstance().makeEntity(_playerName,"tile", point);
						TileVO(tile).row = j + i;
						var tile_action:Action = new Action("addEntity", tile);
						handler(tile_action);
					}
				}
			}
			
			//send now with a delay, remove this patch when final implementation is in progress
			var timer:Timer = new Timer(200, 1);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			
			_main.startGame();
			
			UI.getInstance().showPlanningUI(true);
		}
		
		private function onTimer(e:TimerEvent):void {
			sendActionBuffer();
		}
		
		public function sendPlayerReadyEvent():void {
			_imReady = true;
			if(_hesReady)
				advanceGameState();
			UI.getInstance().enableButtons(false);
			_player.sendReadyMessage(_playerName + "_placeReadyButton");
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
		
		public function getUI():UI {
			return _ui;
		}
		
		private function showStatus(e:NotifyStatusEvent):void {
			//for fast layout tests
			/*if(e.status.indexOf("NetConnection") != -1){
				buildPlayersWorld();
				UI.getInstance().enableButtons(true);
			}*/
			
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
			
			if(_state == GameStatus.COUNTDOWN_STOPPED) {
				if( _somethingToSend)
					sendActionBuffer();
				UI.getInstance().showPlanningUI(false);
			}
			
			if(_state == GameStatus.STOPPED) {
				updatePlayerGold(_player.goldIncome);
				Main.getInstance().getRenderer().pauseOrResumeAnimations();
				UI.getInstance().showPlanningUI(true);
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
		
		public function get enemyHp():int
		{
			return _enemyHp;
		}
		
		public function updateEnemyHp(value:int):void
		{
			_enemyHp += value;
			UI.getInstance().enemyHp = _enemyHp;
		}
		
		public function get myHp():int
		{
			return _myHp;
		}
		
		public function updateMyHp(value:int):void
		{
			_myHp += value;
			_player.hp = _myHp;
			UI.getInstance().myHp = _myHp;
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
		
		public function get gold():int {
			return _gold;
		}
		
		public function get playerGoldIncome():int {
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
		
		private function receiveReadyMessage(event:NotifyEvent):void {
			_hesReady = true;
			if(_imReady){
				advanceGameState();
				UI.getInstance().enableButtons(false);
			}
			else
				UI.getInstance().enableButtons(true);
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