package model
{
	import flash.geom.Point;
	
	import managers.Manager;
	
	import starling.display.Sprite;
	
	import utils.UnitStatus;

	public class EntityFactoryVO extends EntityVO
	{
		private static const BOT:int = 1;
		private static const TOP:int = 0;
		
		private static var _instance:EntityFactoryVO;
		private var _counter:int = 0;
		private var _playerName:String;
		
		public function EntityFactoryVO():void
		{
		}
		
		public function get playerName():String
		{
			return _playerName;
		}

		public function set playerName(value:String):void
		{
			_playerName = value;
		}
		
		public function makeEntity(player:String, name:String, level:int, position:Point = null):EntityVO {
			
			var entity:EntityVO;
			//fix later when I know how to pass a point inside another class via the class alias net code.
			if(!position) 
				position = new Point();
			
			switch(name) {
				
				case "building_improvement_gold":
					entity = new BuildingImprovementGoldVO(level, position.x, position.y);
					break;
				
				case "tile":
					entity = new TileVO(level, position.x, position.y);
					break;
				
				case "good_old_cannon":
					entity = new GoodOldCannonVO(level, position.x, position.y);
					break;
				
				case "bullet":
					entity = new BulletVO(level, position.x, position.y);
					break;
				
				case "default":
					trace("noob");
					break;
			}
			_counter ++;
			entity.owner = player;
			entity.id = player + entity.name + _counter;
			entity.rotation = 45 * Math.PI / 180;
			
			return entity;	
		}
		
		public static function getInstance():EntityFactoryVO {
			if(!_instance)
				_instance = new EntityFactoryVO();
			return _instance;
		}
	}
}