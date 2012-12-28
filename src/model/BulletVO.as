package model
{
	import flash.geom.Point;
	
	import interfaces.IAttack;
	import interfaces.IEntityVO;
	import interfaces.IMovableEntity;
	
	import starling.display.Sprite;

	public class BulletVO extends EntityVO implements IMovableEntity, IAttack
	{
		private var _positionDest:Point;
		private var _damage:int;
		
		public function BulletVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			damage = 70;
			type = "bullet";
			speed = 4;
			skinClass = new SkinClass("bullet", "bullet", false);
			skinClass.animationsDic["walking"] = true;
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