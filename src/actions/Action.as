package actions
{
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	
	import model.EntityVO;
	
	public class Action
	{
		private var _type:String;
		private var _entity:EntityVO;
		private var _target:*;
		
		public function Action(type:String = "", entity:EntityVO = null, target:* = null):void {
			_type = type;
			_entity = entity;
			_target = target;	
		}
		
		
		public function get target():*
		{
			return _target;
		}

		public function set target(value:*):void
		{
			_target = value;
		}

		public function get entity():EntityVO
		{
			return _entity;
		}

		public function set entity(value:EntityVO):void
		{
			_entity = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

	}
}