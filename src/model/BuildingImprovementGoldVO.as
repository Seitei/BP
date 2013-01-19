package model
{
	import behavior_steps.IncreaseGoldIncome;
	
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
			skinClass = new SkinClass("building_improvement_gold", "building_improvement_gold", false);
			skinClass.animationsDic["building_improvement_gold"] = true;
			//buff = new GoldBuff("goldIncomeImprovement", 2, "player");
			power = 500;
		
			//behavior:
			_behavior[0] = [IncreaseGoldIncome, 2];
			
			for (var i:int = 0; i < _behavior.length; i ++){
				
				_behaviorSteps[i] = new _behavior[i][0](_behavior[i].slice(1));
				_behaviorReqs.push(_behaviorSteps[i].req);
				//if at least one behavior step needs to loop, then the entity is a loopable entity and
				//we need to include it in the loopable entities array
				if(_behaviorSteps[i].when == "loop")
					loopable = true;
			}
	
		
		}
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
}