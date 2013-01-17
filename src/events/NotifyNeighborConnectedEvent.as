package events
{
	import actions.Action;
	
	import starling.events.Event;
	
	public class NotifyNeighborConnectedEvent extends Event
	{
		public static const NOTIFY_NEIGHBOR_CONNECTED_EVENT:String = "notifyNeighborConnectedEvent";
		private var _connectionOrder:String;
		
		public function NotifyNeighborConnectedEvent(type:String, connectionOrder:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_connectionOrder = connectionOrder;
		}

		public function get connectionOrder():String {
			return _connectionOrder;
		}
	}
}