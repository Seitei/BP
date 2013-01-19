package model
{
	import behavior_steps.Attack;
	import behavior_steps.Move;
	
	import flash.geom.Point;
	
	import interfaces.ITargeteable;
	
	import starling.display.Sprite;

	public class BulletVO extends EntityVO implements ITargeteable
	{
		private var _damage:int;
		private var _forwardAngle:int;
		
		public function BulletVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			power = 3;
			type = "bullet";
			skinClass = new SkinClass("cannon_bullet", "walking", true);
			skinClass.animationsDic["walking"] = true;
			forwardAngle = -45;
			
			//behavior:
			_behavior[0] = [Move, 2];
			_behavior[1] = [Attack];
			
			for (var i:int = 0; i < _behavior.length; i ++){
				
				_behaviorSteps[i] = new _behavior[i][0](_behavior[i].slice(1));
				_behaviorReqs.push(_behaviorSteps[i].req);
				//if at least one behavior step needs to loop, then the entity is a loopable entity and
				//we need to include it in the loopable entities array
				if(_behaviorSteps[i].when == "loop")
					loopable = true;
			}
		}
		
		override public function loop(behaviorReqsContent:Array):void {
			for (var i:int = 0; i < _behavior.length; i ++){
				_behaviorSteps[i].execute(this, behaviorReqsContent[i]);
			}
		}
	
		
		
		
		
	}
}