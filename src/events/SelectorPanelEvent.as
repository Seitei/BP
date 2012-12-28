package events
{
	import actions.Action;
	
	import starling.events.Event;
	
	public class SelectorPanelEvent extends Event
	{
		public static const SELECTOR_PANEL_EVENT:String = "selectorPanelEvent";
		private var _actionType:String;
		private var _entityType:String;
		
		public function SelectorPanelEvent(type:String, actionType:String, entityType:String, bubbles:Boolean=false)
		{
			_actionType = actionType;
			_entityType = entityType;
			super(type, bubbles)
				
		}

		public function get actionType():String {
			return _actionType;
		}
		
		public function get entityType():String {
			return _entityType;
		}
	}
}