package events
{
	import actions.Action;
	
	import flash.events.Event;
	
	public class NotifyEvent extends Event
	{
		public static const NOTIFY_ACTION_EVENT:String = "notifyActionEvent";
		public static const NOTIFY_PLAYER_READY_EVENT:String = "notifyPlayerReadyEvent";
		public static const NOTIFY_STATUS:String = "notifyStatus";
		private var _message:Vector.<Action>;
		private var _connectionTimestamp:Number;
		
		public function NotifyEvent(type:String, message:Vector.<Action> = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_message = message;	
			_connectionTimestamp = connectionTimestamp;
		}

		public function get connectionTimestamp():Number
		{
			return _connectionTimestamp;
		}

		public function get message():Vector.<Action> {
			return _message;
		}
	}
}