package events
{
	import flash.geom.Point;
	
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ButtonTriggeredEvent extends Event
	{
		public static const BUTTON_TRIGGERED_EVENT:String = "buttonTriggeredEvent";
		private var _clickedPosition:Point;
		
		public function ButtonTriggeredEvent(type:String, clickedPosition:Point, bubbles:Boolean=false)
		{
			_clickedPosition = clickedPosition;
			super(type, bubbles)
			
		}
		
		public function get clickedPosition():Point {
			return _clickedPosition;
		}
	}
}