package model
{
	import flash.geom.Point;
	
	import interfaces.IAttack;
	import interfaces.IEntityVO;
	import interfaces.IMovableEntity;
	import interfaces.ITargeteable;
	
	import starling.display.Sprite;

	public class BulletVO extends EntityVO implements IMovableEntity, IAttack, ITargeteable
	{
		private var _positionDest:Point;
		private var _damage:int;
		private var _hasTarget:Boolean;
		private var _forwardAngle:int;
		
		public function BulletVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			damage = 70;
			type = "bullet";
			speed = 1;
			skinClass = new SkinClass("cannon_bullet", "walking", true);
			skinClass.animationsDic["walking"] = true;
			forwardAngle = -45;
		}
		
		public function get hasTarget():Boolean
		{
			return _hasTarget;
		}

		public function set hasTarget(value:Boolean):void
		{
			_hasTarget = value;
		}

		public function get positionDest():Point
		{
			return _positionDest;
		}

		public function set positionDest(value:Point):void
		{
			_positionDest = value;
		}

		public function get damage():int
		{
			return _damage;
		}

		public function set damage(value:int):void
		{
			_damage = value;
		}

		
	}
}