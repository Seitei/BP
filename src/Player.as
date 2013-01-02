package
{
	import actions.Action;
	
	import events.NotifyEvent;
	
	import flash.events.NetStatusEvent;
	import flash.utils.getTimer;
	
	import net.NetConnect;
	
	public class Player
	{
		private var _nc:NetConnect;
		private var _buffer:Vector.<Action>;
		private var _gold:int;
		private var _goldIncome:int;
		private var _name:String;
		
		public function Player(name:String, nc:NetConnect)
		{
			_name = name;
			_nc = nc;
			_gold = 500;
			_goldIncome = 8;
			_buffer = new Vector.<Action>;
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
		
		public function sendActionBuffer():void {
			_nc.sendActionBuffer(_buffer);
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