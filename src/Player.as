package
{
	import actions.Action;
	
	import events.NotifyEvent;
	import events.NotifyNeighborConnectedEvent;
	import events.NotifyStatusEvent;
	
	import flash.events.NetStatusEvent;
	import flash.utils.getTimer;
	
	import net.NetConnect;
	
	import starling.events.EventDispatcher;
	
	public class Player extends EventDispatcher
	{
		private var _nc:NetConnect;
		private var _buffer:Vector.<Action>;
		private var _gold:int;
		private var _goldIncome:int;
		private var _name:String;
		private var _hp:int;
		//OFFLINE or ONLINE
		private var _online:Boolean;
		
		
		public function Player(name:String, online:Boolean)
		{
			_online = online;
			_name = name;
			
			//if we are working offline, then we dont init netConnect
			if(online) {
				_nc = new NetConnect();
				_nc.addEventListener(NotifyEvent.NOTIFY_PLAYER_READY_EVENT, dispatchReadyMessage);
				_nc.addEventListener(NotifyEvent.NOTIFY_ACTION_EVENT, dispatchActionMessage);
				_nc.addEventListener(NotifyNeighborConnectedEvent.NOTIFY_NEIGHBOR_CONNECTED_EVENT, dispatchBuildPlayersWorld);
				_nc.addEventListener(NotifyStatusEvent.NOTIFY_STATUS, dispatchShowStatus);
			}
			
			_gold = 100;
			_hp = 500;
			_goldIncome = 8;
			_buffer = new Vector.<Action>;
			
			
		}
		
		
		private function dispatchReadyMessage(event:NotifyEvent):void {
			dispatchEvent(event);
		}
		
		private function dispatchActionMessage(event:NotifyEvent):void {
			dispatchEvent(event);
		}
		
		private function dispatchBuildPlayersWorld(event:NotifyNeighborConnectedEvent):void {
			dispatchEvent(event);
		}
		
		private function dispatchShowStatus(event:NotifyStatusEvent):void {
			dispatchEvent(event);
		}
		
		
		public function get hp():int
		{
			return _hp;
		}

		public function set hp(value:int):void
		{
			_hp = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get goldIncome():int
		{
			return _goldIncome;
		}

		public function set goldIncome(value:int):void
		{
			_goldIncome = value;
		}

		public function get gold():int
		{
			return _gold;
		}

		public function set gold(value:int):void
		{
			_gold = value;
		}

		public function addToActionBuffer(action:Action):void {
			_buffer.push(action);
		}
		
		public function sendActionBuffer(online:Boolean):void {
			if(online)
				_nc.sendActionBuffer(_buffer);
			else
				dispatchEvent(new NotifyEvent(NotifyEvent.NOTIFY_ACTION_EVENT, _buffer));
				
			_buffer = new Vector.<Action>;
		}
		
		public function sendReadyMessage(message:String):void {
				_nc.sendReadyMessage(message);
		}
		
		public function receiveMessage(buffer:Vector.<Action>):void {
			//TODO
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}