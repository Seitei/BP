package model
{
	import flash.geom.Point;
	
	import starling.display.Sprite;

	public class BackgroundVO extends EntityVO
	{
			
		public function BackgroundVO(level:int, x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			type = "background";
			skinClass = new SkinClass("background", "background", false);
			skinClass.animationsDic["background"] = true;
		}
		
	}
}