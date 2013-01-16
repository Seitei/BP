package behavior_steps
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import interfaces.IBehavior;
	
	import model.EntityVO;
	
	import utils.Movement;
	import utils.MovieClipContainer;
	import utils.UnitStatus;

	public class Move implements IBehavior
	{
		private var _req:String = "";
		
	   	public function Move(entity:EntityVO = null){
		   
	   	}
		
		public function get req():String
		{
			return _req;
		}

		public function set req(value:String):void
		{
			_req = value;
		}

		public function execute(entity:EntityVO, entitiesSubgroup:Vector.<EntityVO> = null):void {
			
			var spriteEntities:Dictionary = Main.getInstance().getRenderer().getSpriteEntitiesDic();
			var mcc:MovieClipContainer = spriteEntities[entity.id];
			
			//if the entity has a defined target:
			if(entity.positionDest){
				
				//if I'm there
				if(entity.positionDest.equals(entity.position)) {
					entity.positionDest = null;
				}
				else {
					Movement.moveToPoint(mcc, entity.positionDest, entity.speed, true); 
					entity.position.x = mcc.x;
					entity.position.y = mcc.y;
				}
				
				if(entity.status == UnitStatus.IDDLE){
					entity.status = UnitStatus.MOVING_TO_TARGET;
					Main.getInstance().getRenderer().playAnimation(entity.id, "walking", true);
				}
				
			}
			
			//if not we move at 45 degrees:
			else {
				Movement.moveInDirection(mcc, entity.forwardAngle, entity.speed); 
				entity.position.x = mcc.x;
				entity.position.y = mcc.y;
			}
			
			//damage to us
			/*if( entity.position.y > 700 || entity.position.x < 0) {
			Manager.getInstance().updateMyHp(-IAttack(ent).damage);
			removeEntity(ent);
			}*/
			
			//damage to the enemy player
			/*if(entity.position.y < 0 || entity.position.x > 700){
			Manager.getInstance().updateEnemyHp(-IAttack(ent).damage); 
			removeEntity(ent);
			}*/
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		}
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
			
			
			
			
			
		
		
		
		
	}
}