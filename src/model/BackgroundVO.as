package model
{
	import flash.geom.Point;
	
	import interfaces.IEntityVO;
	
	import starling.display.Sprite;

	public class BackgroundVO extends EntityVO
	{
			
		public function BackgroundVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			type = "background";
			speed = 0;
			skinClass = new SkinClass("background", "background", false);
			skinClass.animationsDic["background"] = true;
		}
		
	}
}