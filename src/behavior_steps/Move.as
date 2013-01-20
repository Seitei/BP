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
		private var _loopable:Boolean = true;
		private var _executeNow:Boolean = false;
		private var _when:String = "loop";
		private var _speed:int = 0;
		
	   	public function Move(...params){
			_speed = params[0][0];   
	   	}
		
		public function get when():String
		{
			return _when;
		}
		
		public function set when(value:String):void
		{
			_when = value;
		}
		
		public function get loopable():Boolean
		{
			return _loopable;
		}

		public function set loopable(value:Boolean):void
		{
			_loopable = value;
		}

		public function get req():String
		{
			return _req;
		}

		public function set req(value:String):void
		{
			_req = value;
		}

		public function execute(entity:EntityVO, reqs:* = null):void {
			
			var spriteEntities:Dictionary = Main.getInstance().getRenderer().getSpriteEntitiesDic();
			var mcc:MovieClipContainer = spriteEntities[entity.id];
			
			//if the entity has a defined target:
			if(entity.positionDest){
				
				//if I'm there
				if(entity.positionDest.equals(entity.position)) {
					entity.positionDest = null;
				}
				else {
					Movement.moveToPoint(mcc, entity.positionDest, _speed, true); 
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
				Movement.moveInDirection(mcc, entity.forwardAngle, _speed); 
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