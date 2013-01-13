package behavior_steps
{
	import flash.utils.Dictionary;
	
	import interfaces.IBehavior;
	
	import model.EntityVO;
	
	import utils.Movement;
	import utils.MovieClipContainer;

	public class Attack implements IBehavior
	{
			
		private var _req:String = "enemy_entities";
		
		public function Attack(entity:EntityVO){
		   
		}
		
		public function loop(entity:EntityVO, entitiesSubgroup:Vector.<EntityVO> = null):void {
			trace("ATTACK");
			
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