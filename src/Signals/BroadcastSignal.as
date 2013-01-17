package Signals
{
	import actions.Action;
	
	import org.osflash.signals.Signal;
	
	public class BroadcastSignal 
	{
		
		public var signal:Signal;
		private var _action:Action;
		private var _sendActionBuffer:Boolean;
		
		public function BroadcastSignal(action:Action, sendActionBuffer:Boolean) {
			signal = new Signal(Action, Boolean);
			_action = action;
			_sendActionBuffer = sendActionBuffer;
		}
		
		public function dispatch():void
		{
			signal.dispatch(_action, _sendActionBuffer);
		}
	}
}



	

