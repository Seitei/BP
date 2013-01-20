package behavior_steps
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import interfaces.IBehavior;
	
	import managers.GameManager;
	
	import model.EntityVO;
	
	import utils.Movement;
	import utils.MovieClipContainer;

	public class Attack implements IBehavior
	{
			
		private var _req:String = "enemy_attackable_entities";
		private var _loopable:Boolean = true;
		private var _executeNow:Boolean = false;
		private var _when:String = "loop";
		
		public function Attack(...params){
		   
		}
		
		public function get when():String
		{
			return _when;
		}

		public function set when(value:String):void
		{
			_when = value;
		}

		public function execute(entity:EntityVO, reqs:* = null):void {
			
			for each(var targetedEnt:EntityVO in reqs) {

				if(Point.distance(entity.position, targetedEnt.position) < 20){
					GameManager.getInstance().removeEntity(entity);
					targetedEnt.power -= entity.power;
					
					if(targetedEnt.power <= 0)
						GameManager.getInstance().removeEntity(targetedEnt);
				}
			}
		}
			
		public function get req():String
		{
			return _req;
		}
		
		public function set req(value:String):void
		{
			_req = value;
		}

		public function get loopable():Boolean
		{
			return _loopable;
		}
		
		public function get executeNow():Boolean
		{
			return _executeNow;
		}
		
		public function set executeNow(value:Boolean):void
		{
			_executeNow = value;
		}	
			
			
			
		
		
		
		
	}
}