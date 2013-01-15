package behavior_steps
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import interfaces.IBehavior;
	import interfaces.ITargeteable;
	
	import managers.GameManager;
	
	import model.EntityVO;
	
	import utils.Movement;
	import utils.MovieClipContainer;

	public class Attack implements IBehavior
	{
			
		private var _req:String = "enemy_entities";
		
		public function Attack(entity:EntityVO){
		   
		}
		
		public function loop(entity:EntityVO, entitiesSubgroup:Vector.<EntityVO> = null):void {
			
			for each(var targetedEnt:EntityVO in entitiesSubgroup) {

				if(targetedEnt is ITargeteable) {
				
					if(Point.distance(entity.position, targetedEnt.position) < 20){
						GameManager.getInstance().removeEntity(entity);
						targetedEnt.hp -= entity.damage;
						
						if(targetedEnt.hp <= 0)
							GameManager.getInstance().removeEntity(targetedEnt);
						
					}
					
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

			
			
			
			
			
		
		
		
		
	}
}