package model
{
	import behavior_steps.Attack;
	import behavior_steps.Move;
	
	import flash.geom.Point;
	
	import interfaces.IEntityVO;
	import interfaces.ITargeteable;
	
	import starling.display.Sprite;

	public class BulletVO extends EntityVO implements ITargeteable
	{
		private var _positionDest:Point;
		private var _damage:int;
		private var _forwardAngle:int;
		
		public function BulletVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			damage = 3;
			type = "bullet";
			speed = 2;
			skinClass = new SkinClass("cannon_bullet", "walking", true);
			skinClass.animationsDic["walking"] = true;
			forwardAngle = -45;
			
			//behavior:
			_behavior.push(Move);
			_behavior.push(Attack);
			
			for (var i:int = 0; i < _behavior.length; i ++){
				_behaviorSteps[i] = new _behavior[i](this);
				_behaviorReqs.push(_behaviorSteps[i].req);
			}
		}
		
		override public function loop(behaviorReqsContent:Array):void {
			for (var i:int = 0; i < _behavior.length; i ++){
				_behaviorSteps[i].loop(this, behaviorReqsContent[i]);
			}
		}
	
		
		
		
		
	}
}