package model
{
	import buffs.GoldBuff;
	
	import flash.geom.Point;
	
	import interfaces.ITargeteable;
	
	import starling.display.Sprite;
	
	public class BuildingImprovementGoldVO extends EntityVO implements ITargeteable
	{
		private var _cost:int;
		
		public function BuildingImprovementGoldVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			_cost = 4;
			type = "buildingImprovementGold";
			speed = 0;
			skinClass = new SkinClass("building_improvement_gold", "building_improvement_gold", false);
			skinClass.animationsDic["building_improvement_gold"] = true;
			buff = new GoldBuff("goldIncomeImprovement", 2, "player");
			hp = 500;
		}

	}
}