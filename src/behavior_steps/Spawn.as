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
		private var _entity:EntityVO;
		private var _timePassed:int;
		private var _req:String = "";
		
		public function Spawn(entity:EntityVO){
			_entity = entity;
		}
		
		public function loop(entity:EntityVO, entitiesSubgroup:Vector.<EntityVO> = null):void {
			
				advanceTime();
		}
		
		public function get req():String
		{
			return _req;
		}
		
		public function set req(value:String):void
		{
			_req = value;
		}

		
		private function advanceTime():void {
			_timePassed ++;
			if ((_timePassed > _entity.spawnRate)) {
				spawnEntity();
				_timePassed = 0;				
			}
		}
			
		
		private function spawnEntity():void {
			var spawnedEntity:EntityVO = EntityFactoryVO.getInstance().makeEntity(_entity.owner, _entity.entityTypeSpawned, new Point(_entity.position.x + _entity.spawningPoint.x, _entity.position.y + _entity.spawningPoint.y));
			spawnedEntity.forwardAngle += _entity.forwardAngle;
			spawnedEntity.parentContainer = _entity.id;
			spawnedEntity.positionDest = _entity.rallypoint;
			var action:Action = new Action("addEntity", spawnedEntity);
			GameManager.getInstance().dispatchAction(action);
		}
			
			
			
			
			
		
		
		
		
	}
}