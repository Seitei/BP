package model
{
	import flash.geom.Point;
	
	import starling.display.Sprite;

	public class ActionButtonVO
	{
		private var _name:String;
		private var _actionType:String;
		private var _entityType:String;
		private var _actionButtons:Vector.<ActionButtonVO>;
		
		public function ActionButtonVO(name:String, actionType:String, entityType:String = "")
		{
			_name = name;
			_actionType = actionType;
			_entityType = entityType;
			_actionButtons = new Vector.<ActionButtonVO>;
		}
		
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get actionButtons():Vector.<ActionButtonVO>
		{
			return _actionButtons;
		}

		public function get entityType():String
		{
			return _entityType;
		}

		public function set entityType(value:String):void
		{
			_entityType = value;
		}

		public function get actionType():String
		{
			return _actionType;
		}

		public function set actionType(value:String):void
		{
			_actionType = value;
		}

	}
}