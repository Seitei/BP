package events
{
	import flash.events.Event;
	
	public class NotifyStatusEvent extends Event
	{
		public static const NOTIFY_STATUS:String = "notifyStatus";
		private var _status:String;
		private var _timestamp:Number = 0;
		
		public function NotifyStatusEvent(type:String, status:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_timestamp = timestamp;
			_status = status;	
		}

		public function get timestamp():Number
		{
			return _timestamp;
		}

		public function get status():String {
			return _status;
		}
	}
}