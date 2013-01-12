package model
{
	import actions.Action;
	
	import behaviors.Move;
	
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	
	import interfaces.IBehavior;
	import interfaces.IBuyableEntity;
	import interfaces.IEntityVO;
	import interfaces.IMovableEntity;
	import interfaces.ITargeteable;
	import interfaces.IUnitSpawner;
	
	import managers.GameManager;
	
	import starling.core.Starling;
	import starling.display.Sprite;

	public class Spawner1VO extends EntityVO implements IUnitSpawner, IBuyableEntity, ITargeteable
	{
		private var _cost:int;
		private var _spawnRate:Number;
		private var _timePassed:Number = 0;
		private var _entityTypeSpawned:String = "bullet";
		private var _rallypoint:Point;
		
		private var _canSpawn:Boolean;
		private var _maxUnits:int = 1;
		private var _currentUnits:int = 0;
		private var _inheritedForwardAngle:int;
		private var _spawningPoint:Point;
		private var _behaviors:Vector.<IBehavior>;
		
		public function set spawningPoint(value:Point):void {
			_spawningPoint = value;	
		}
		
		public function get spawningPoint():Point {
			return _spawningPoint;
		}		

		public function Spawner1VO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			//TODO temporary fix
			cost = 3;
			canSpawn = true;
			_spawnRate = 60;
			type = "spawner1";
			speed = 1;
			skinClass = new SkinClass("spawner1", "spawner1", false);
			skinClass.animationsDic["spawner1"] = true;
			hp = 500;
			_spawningPoint = new Point(18, -18);
			//set what the entity has to show in the selector panel
			initActionButtons();
			
			_behavior = new Vector.<Class>;
			_behaviors = new Vector.<IBehavior>;
			
			_behavior.push(Move);
			
			
			for (var i:int = 0; i < _behavior.length; i ++){
				_behaviors[i] = new _behavior[i];
			}
			
		}
		
		override public function loop():void {
			for (var i:int = 0; i < 1; i ++){
				_behaviors[i].loop(this);
			}
		}
		
		private function initActionButtons():void {
			_actionButtons = new Vector.<ActionButtonVO>;
			var sell:ActionButtonVO = new ActionButtonVO("sell", "sell");
			var setRallypoint:ActionButtonVO = new ActionButtonVO("set_rallypoint", "setRallypoint");
			actionButtons.push(sell, setRallypoint);
		}
		
		public override function set forwardAngle(angle:int):void {
			_inheritedForwardAngle = angle;
		}
		
		public function get maxUnits():int
		{
			return _maxUnits;
		}

		public function set maxUnits(value:int):void
		{
			_maxUnits = value;
			if(_maxUnits > 0)
				_canSpawn = true;
		}

		public function get cost():int
		{
			return _cost;
		}

		public function set cost(value:int):void
		{
			_cost = value;
		}

		public function get canSpawn():Boolean
		{
			return _canSpawn;
		}
		
		public function set canSpawn(value:Boolean):void
		{
			_canSpawn = value;
		}
		
		public function spawnUnit():void {
			var entity:EntityVO = EntityFactoryVO.getInstance().makeEntity(this.owner, _entityTypeSpawned, new Point(position.x + _spawningPoint.x, position.y + _spawningPoint.y));
			entity.forwardAngle += _inheritedForwardAngle;
			entity.parentContainer = id;
			
			//if there is a rallypoint set
			if(_rallypoint)
				IMovableEntity(entity).positionDest = _rallypoint;
	
			var action:Action = new Action("addEntity", entity);
			GameManager.getInstance().dispatchAction(action);
			//_currentUnits ++;
		}
		
		public function advanceTime():void {
			_timePassed ++;
			if ((_timePassed > spawnRate) && canSpawn) {
				spawnUnit();
				_timePassed = 0;				
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

		public function set rallypoint(point:Point):void {
			_rallypoint = new Point(point.x, point.y); 
		}
		
		public function get rallypoint():Point {
			return _rallypoint;
		}
		
		
	}
}