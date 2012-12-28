package model
{
	import actions.Action;
	
	import flash.geom.Point;
	
	import interfaces.IBuildeable;
	import interfaces.IBuyableEntity;
	import interfaces.IEntityVO;
	import interfaces.IMovableEntity;
	import interfaces.ITargeteable;
	import interfaces.ITargeter;
	import interfaces.IUnitSpawner;
	
	import managers.GameManager;
	
	import starling.display.Sprite;
	
	import utils.UnitStatus;

	public class BuildingTowerVO extends EntityVO implements IBuyableEntity, ITargeter, IUnitSpawner, ITargeteable, IBuildeable
	{
		private var _cost:int;
		private var _timePassed:Number = 0;
		private var _constructionTimePassed:Number = 0;
		private var _spawnRate:int;
		private var _entityTypeSpawned:String;
		private var _rallypoint:Point;
		private var _canSpawn:Boolean;
		private var _targetRange:int;
		private var _maxUnits:int;
		private var _constructionTime:Number;
		
		public function BuildingTowerVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			status = UnitStatus.IDDLE;
			_cost = 2;
			type = "buildingTower";
			speed = 0;
			skinClass = new SkinClass("building_tower", "building_tower", false);
			skinClass.animationsDic["building_tower"] = true;
			skinClass.buildingAnimationMethod = "360"; 
			canSpawn = false;
			spawnRate = 30;
			_entityTypeSpawned = "bullet";
			targetRange = 1000;
			hp = 500;
			_constructionTime = 120;
			
			//set what the entity has to show in the selector panel
			initActionButtons();
			
		}
		
		private function initActionButtons():void {
			
			var sell:ActionButtonVO = new ActionButtonVO("sell", "sell");
			
			var upgrade:ActionButtonVO = new ActionButtonVO("upgrade", "container");
			var upgrade_damage_1:ActionButtonVO = new ActionButtonVO("upgrade_damage_1", "upgrade", "buildingTowerUpgradeDamage1");
			var upgrade_armor_1:ActionButtonVO = new ActionButtonVO("upgrade_armor_1", "upgrade", "buildingTowerVOUpgradeArmor1");
			
			upgrade.actionButtons.push(upgrade_damage_1, upgrade_armor_1);
			
			
			
			actionButtons.push(sell, upgrade);
		}
		
		public function get constructionTime():Number
		{
			return _constructionTime;
		}

		public function set constructionTime(value:Number):void
		{
			_constructionTime = value;
		}

		public function get cost():int
		{
			return _cost;
		}

		public function set cost(value:int):void
		{
			_cost = value;
		}
		
		public function get targetRange():int
		{
			return _targetRange;
		}
		
		public function set targetRange(value:int):void
		{
			_targetRange = value;
		}
		
		public function get maxUnits():int
		{
			return _maxUnits;
		}
		
		public function set maxUnits(value:int):void
		{
			_maxUnits = value;
		}
		
		public function get rallypoint():Point
		{
			return _rallypoint;
		}
		
		public function set rallypoint(value:Point):void
		{
			_rallypoint = value;
		}
		
		public function get canSpawn():Boolean
		{
			return _canSpawn;
		}
		
		public function set canSpawn(value:Boolean):void
		{
			_canSpawn = value;
		}
		
		public function setRallyPoint(position:Point):void {
			_rallypoint = position;
		}
		
		public function advanceTime():void {
			_timePassed ++;
			if (_timePassed > _spawnRate && canSpawn) {
				spawnUnit();
				_timePassed = 0;				
			}
		}
		
		public function spawnUnit():void {
			var entity:EntityVO = EntityFactoryVO.getInstance().makeEntity(this.owner, _entityTypeSpawned, new Point(position.x, position.y));
			entity.parentContainer = id;
			IMovableEntity(entity).positionDest = _rallypoint;
			var action:Action = new Action("addEntity", entity);
			GameManager.getInstance().dispatchAction(action);
		}
		
		public function advanceConstructionTime():void {
			_constructionTimePassed ++;
			if (_constructionTimePassed >= constructionTime){
				status = UnitStatus.IDDLE;
			}
		}
		
		public function get spawnRate():Number
		{
			return _spawnRate;
		}
		
		public function set spawnRate(value:Number):void
		{
			_spawnRate = value;
		}
		
		
		
		
		
		
		
		
		
		
		
		
	}
}