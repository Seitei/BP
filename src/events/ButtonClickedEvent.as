package events
{
	import flash.geom.Point;
	
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ButtonClickedEvent extends Event
	{
		public static const BUTTON_CLICKED_EVENT:String = "buttonClickedEvent";
		private var _actionType:String;
		private var _entityName:String;
		private var _mouseCursorTexture:Texture;
		private var _startingPosition:Point;
		
		public function ButtonClickedEvent(type:String, startingPosition:Point, actionType:String, entityName:String, mouseCursorTexture:Texture = null, bubbles:Boolean=false)
		{
			_actionType = actionType;
			_entityName = entityName;
			_mouseCursorTexture = mouseCursorTexture;
			_startingPosition = startingPosition;
			super(type, bubbles)
			
		}
		
		public function get actionType():String {
			return _actionType;
		}
		
		public function get entityName():String {
			return _entityName;
		}
		
		public function get mouseCursorTexture():Texture {
			return _mouseCursorTexture;
		}
		
		public function get startingPosition():Point {
			return _startingPosition;
		}
	}
}