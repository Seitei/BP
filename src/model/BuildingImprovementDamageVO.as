package model
{
	import buffs.GoldBuff;
	
	import flash.geom.Point;
	
	import interfaces.ITargeteable;
	
	import starling.display.Sprite;
	
	public class BuildingImprovementDamageVO extends EntityVO implements ITargeteable
	{
		private var _cost:int;
		
		public function BuildingImprovementDamageVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			_cost = 4;
			type = "buildingImprovementDamage";
			speed = 0;
			skinClass = new SkinClass("building_improvement_damage", "building_improvement_damage", false);
			skinClass.animationsDic["building_improvement_damage"] = true;
			buff = new GoldBuff("goldIncomeImprovement", 2, "player");
			hp = 500;
		}

	}
}