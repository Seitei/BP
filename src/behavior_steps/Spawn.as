package behavior_steps
{
	import actions.Action;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import interfaces.IBehavior;
	
	import managers.GameManager;
	
	import model.EntityFactoryVO;
	import model.EntityVO;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	import utils.Movement;
	import utils.MovieClipContainer;

	public class Spawn implements IBehavior
	{
		private var _timePassed:int;
		private var _entityType:String;
		private var _entityLevel:int;
		private var _spawnRate:int;
		private var _req:String = "";
		private var _loopable:Boolean = true;
		private var _when:String = "loop";
		
		public function Spawn(...params){
			_entityType = params[0][0];
			_entityLevel = params[0][1];
			_spawnRate  = params[0][2];
		}
		
		public function execute(entity:EntityVO, reqs:* = null):void {
			
				advanceTime(entity);
		}
		
		public function get when():String
		{
			return _when;
		}
		
		public function set when(value:String):void
		{
			_when = value;
		}
		
		public function get req():String
		{
			return _req;
		}
		
		public function set req(value:String):void
		{
			_req = value;
		}

		
		private function advanceTime(entity:EntityVO):void {
			_timePassed ++;
			if ((_timePassed > _spawnRate)) {
				spawnEntity(entity);
				_timePassed = 0;				
			}
		}
			
		
		private function spawnEntity(entity:EntityVO):void {
			var spawnedEntity:EntityVO = EntityFactoryVO.getInstance().makeEntity(entity.owner, _entityType, _entityLevel, new Point(entity.position.x + entity.spawningPoint.x, entity.position.y + entity.spawningPoint.y));
			spawnedEntity.forwardAngle += entity.forwardAngle;
			spawnedEntity.parentContainer = entity.id;
			spawnedEntity.positionDest = entity.rallypoint;
			var action:Action = new Action("addEntity", spawnedEntity);
			GameManager.getInstance().dispatchAction(action);
		}
			
		public function get loopable():Boolean
		{
			return _loopable;
		}
		
		
		
		
		
	}
}