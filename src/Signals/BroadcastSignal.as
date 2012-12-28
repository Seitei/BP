package Signals
{
	import actions.Action;
	
	import org.osflash.signals.Signal;
	
	public class BroadcastSignal 
	{
		
		public var signal:Signal;
		private var _action:Action;
		
		public function BroadcastSignal(action:Action) {
			signal = new Signal(Action);
			_action = action;
		}
		
		public function dispatch():void
		{
			signal.dispatch(_action);
		}
	}
}



	

