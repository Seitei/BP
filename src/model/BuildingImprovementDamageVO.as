package model
{
	import flash.geom.Point;
	
	import starling.display.Sprite;
	
	public class BuildingImprovementDamageVO extends EntityVO
	{
		private var _cost:int;
		
		public function BuildingImprovementDamageVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			_cost = 4;
			type = "buildingImprovementDamage";
			skinClass = new SkinClass("building_improvement_damage", "building_improvement_damage", false);
			skinClass.animationsDic["building_improvement_damage"] = true;
			power = 500;
			attackable = true;
		}

	}
}