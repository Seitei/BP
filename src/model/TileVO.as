package model
{
	import flash.geom.Point;
	
	import starling.display.Sprite;

	public class TileVO extends EntityVO
	{
		private var _row:int;
		
		public function TileVO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			type = "tile";
			skinClass = new SkinClass("tile", "hover", true);
			skinClass.animationsDic["hover"] = true;
			skinClass.animationsDic["selected"] = true;
			
			//set what the entity has to show in the selector panel
			//disabled for the moment
			//initActionButtons();
			
		}
		
		public function get row():int
		{
			return _row;
		}

		public function set row(value:int):void
		{
			_row = value;
		}

		private function initActionButtons():void {

			var main_selector_units:ActionButtonVO = new ActionButtonVO("main_selector_units", "container");
			var building_unit:ActionButtonVO = new ActionButtonVO("building_unit", "addEntity", "buildingUnit");
			main_selector_units.actionButtons.push(building_unit);
			
			var main_selector_improvements:ActionButtonVO = new ActionButtonVO("main_selector_improvements", "container");
			var building_improvement_gold:ActionButtonVO = new ActionButtonVO("building_improvement_gold", "addEntity", "buildingImprovementGold");
			main_selector_improvements.actionButtons.push(building_improvement_gold);
			
			var main_selector_towers:ActionButtonVO = new ActionButtonVO("main_selector_towers", "container");
			var building_tower:ActionButtonVO = new ActionButtonVO("building_tower", "addEntity", "buildingTower");
			main_selector_towers.actionButtons.push(building_tower, building_tower, building_tower, building_tower);
			
			actionButtons.push(main_selector_towers, main_selector_units, main_selector_improvements);
		}
			
	}
}