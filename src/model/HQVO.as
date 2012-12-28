package model
{
	import actions.Action;
	
	import flash.geom.Point;
	
	import interfaces.IEntityVO;
	import interfaces.IMovableEntity;
	import interfaces.ITargeteable;
	import interfaces.ITargeter;
	import interfaces.IUnitSpawner;
	
	import managers.GameManager;
	
	import starling.display.Sprite;
	
	import utils.UnitStatus;
	

	public class HQVO extends EntityVO implements ITargeteable
	{
		public function HQVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			status = UnitStatus.IDDLE;
			speed = 0;
			type = "hq";
			skinClass = new SkinClass("hq", "hq", false);
			skinClass.animationsDic["hq"] = true;
			hp = 1500;
		}
	}
}