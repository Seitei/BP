package behaviors
{
	import flash.utils.Dictionary;
	
	import interfaces.IBehavior;
	
	import model.EntityVO;
	
	import utils.Movement;
	import utils.MovieClipContainer;

	public class Move implements IBehavior
	{
			
		public function loop(entity:EntityVO):void {
			
			var spriteEntities:Dictionary = Main.getInstance().getRenderer().getSpriteEntitiesDic();
			var mcc:MovieClipContainer = spriteEntities[entity.id];
			
			Movement.moveInDirection(mcc, entity.forwardAngle, entity.speed); 
			entity.position.x = mcc.x;
			entity.position.y = mcc.y;
		}
			
			
			
			
			
			
		
		
		
		
	}
}