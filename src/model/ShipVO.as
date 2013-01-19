package model
{
	import flash.geom.Point;
	
	
	import starling.display.Sprite;

	public class ShipVO extends EntityVO
	{
			
		public function ShipVO(x:int = 0, y:int = 0)
		{
			super();
			position.x = x, position.y = y;
			type = "ship";
			skinClass = new SkinClass("ship", "ship", false);
			skinClass.animationsDic["ship"] = true;
		}
		
	}
}