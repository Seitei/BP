package behavior_steps
{
	import flash.utils.Dictionary;
	
	import interfaces.IBehavior;
	
	import model.EntityVO;
	
	import utils.Movement;
	import utils.MovieClipContainer;

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

		public function loop(entity:EntityVO, entitiesSubgroup:Vector.<EntityVO> = null):void {
			
			var spriteEntities:Dictionary = Main.getInstance().getRenderer().getSpriteEntitiesDic();
			var mcc:MovieClipContainer = spriteEntities[entity.id];
			
			Movement.moveInDirection(mcc, entity.forwardAngle, entity.speed); 
			entity.position.x = mcc.x;
			entity.position.y = mcc.y;
		}
			
			
			
			
			
			
		
		
		
		
	}
}