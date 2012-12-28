package Signals
{
	import actions.Action;
	
	import model.EntityVO;
	
	import org.osflash.signals.Signal;
	
	public class EntityClickedSignal 
	{
		
		public var signal:Signal;
		private var _entity:EntityVO;
		
		public function EntityClickedSignal(entity:EntityVO) {
			signal = new Signal(entity);
			_entity = entity;
		}
		
		public function dispatch():void
		{
			signal.dispatch(_entity);
		}
	}
}





