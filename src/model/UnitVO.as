package model
{
	import actions.Action;
	
	import flash.geom.Point;
	
	import interfaces.IEntityVO;
	import interfaces.IMovableEntity;
	import interfaces.ITargeteable;
	import interfaces.ITargeter;
	import interfaces.IUnitSpawner;
	
	import managers.GameManager;
	
	import starling.display.Sprite;
	
	import utils.UnitStatus;
	

	public class UnitVO extends EntityVO implements IMovableEntity, IUnitSpawner, ITargeter, ITargeteable
	{
		private var _positionDest:Point;
		private var _timePassed:Number = 0;
		private var _spawnRate:int;
		private var _entityTypeSpawned:String;
		private var _rallypoint:Point;
		private var _canSpawn:Boolean;
		private var _targetRange:int;
		private var _maxUnits:int;
		private var _hasTarget:Boolean;
		
		public function UnitVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			status = UnitStatus.IDDLE;
			canSpawn = false;
			speed = 0.5;
			type = "unit";
			spawnRate = 30;
			skinClass = new SkinClass("unit", "iddle", true);
			skinClass.animationsDic["iddle"] = true;
			skinClass.animationsDic["walking"] = true;
			_entityTypeSpawned = "bullet";
			targetRange = 100;
			hp = 250;
		}
		
		public function get hasTarget():Boolean
		{
			return _hasTarget;
		}

		public function set hasTarget(value:Boolean):void
		{
			_hasTarget = value;
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

		public function get positionDest():Point
		{
			return _positionDest;
		}

		public function set positionDest(value:Point):void
		{
			_positionDest = value;
		}

		public function get targetRange():int
		{
			return _targetRange;
		}

		public function set targetRange(value:int):void
		{
			_targetRange = value;
		}

		public function get canSpawn():Boolean
		{
			return _canSpawn;
		}

		public function set canSpawn(value:Boolean):void
		{
			_canSpawn = value;
		}

		public function advanceTime():void {
			_timePassed ++;
			if (_timePassed > spawnRate && canSpawn) {
				spawnUnit();
				_timePassed = 0;				
			}
		}
		
		public function spawnUnit():void {
			var entity:EntityVO = EntityFactoryVO.getInstance().makeEntity(this.owner, _entityTypeSpawned, position);
			entity.parentContainer = id;
			IMovableEntity(entity).positionDest = _rallypoint;
			var action:Action = new Action("addEntity", entity);
			GameManager.getInstance().dispatchAction(action);
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