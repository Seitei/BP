package model
{
	import flash.geom.Point;
	
	import interfaces.IBuildeable;
	import interfaces.IEntityVO;
	
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
		
		public function makeEntity(player:String, type:String, position:Point):EntityVO {
			
			var entity:EntityVO;
			
			switch(type) {
				case "hq":
					entity = new HQVO(position.x, position.y);
					break;
				case "buildingUnit":
					entity = new BuildingUnitVO(position.x, position.y);
					break;
				case "background":
					entity = new BackgroundVO(position.x, position.y);
					break;
				case "ship":
					entity = new ShipVO(position.x, position.y);
					break;
				case "buildingImprovementGold":
					entity = new BuildingImprovementGoldVO(position.x, position.y);
					break;
				case "buildingTower":
					entity = new BuildingTowerVO(position.x, position.y);
					break;
				case "buildingTowerUpgradeDamage1":
					entity = new BuildingTowerUpgradeDamage1VO(position.x, position.y);
					break;
				case "tile":
					entity = new TileVO(position.x, position.y);
					break;
				case "unit":
					entity = new UnitVO(position.x, position.y);
					break;
				case "bullet":
					entity = new BulletVO(position.x, position.y);
					break;
				case "default":
					trace("noob");
					break;
			}
			_counter ++;
			entity.owner = player;
			entity.id = playerName + entity.type + _counter;
			
			if(entity is IBuildeable)
				entity.status = UnitStatus.BUILDING;
			
			return entity;	
		}
		
		public static function getInstance():EntityFactoryVO {
			if(!_instance)
				_instance = new EntityFactoryVO();
			return _instance;
		}
	}
}