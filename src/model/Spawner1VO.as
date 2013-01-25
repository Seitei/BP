package model
{
	import actions.Action;
	
	import behavior_steps.Move;
	import behavior_steps.Spawn;
	
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	
	import interfaces.IBehavior;
	
	import managers.GameManager;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class Spawner1VO extends EntityVO
	{
		private var _cost:int;
		private var _rallypoint:Point;
		
		private var _maxUnits:int = 1;
		private var _currentUnits:int = 0;
			
		public function Spawner1VO(level:int, x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			cost = 3;
			attackable = true;
			type = "spawner1";
			skinClass = new SkinClass("spawner1", "spawner1", false);
			skinClass.animationsDic["spawner1"] = true;
			spawningPoint = new Point(18, -18);
			//set what the entity has to show in the selector panel
			entityToSpawn = new Object();
			entityToSpawn.type = "bullet";
			entityToSpawn.level = 1;
			
			initLevelData();
			applyLevel = level;
			initActionButtons();
			
		}
		
		
		override public function loop(behaviorReqsContent:Array):void {
			for (var i:int = 0; i < behavior.length; i ++){
				_behaviorSteps[i].execute(this, behaviorReqsContent[i]);
			}
		}
		
		private function initLevelData():void {
		 
			levelData[1] = [500,  [[Spawn, this.entityToSpawn.type, this.entityToSpawn.level, 120]], "spawner1_level1"];
			levelData[2] = [1000, [[Spawn, this.entityToSpawn.type, this.entityToSpawn.level,  90]], "spawner1_level2"];
			levelData[3] = [2000, [[Spawn, this.entityToSpawn.type, this.entityToSpawn.level,  80]], "spawner1_level3"];
			levelData[4] = [5000, [[Spawn, this.entityToSpawn.type, this.entityToSpawn.level,  60]], "spawner1_level4"];
				
				
		}
		
		override public function set applyLevel(level:int):void {
			
			power     = power / maxPower * levelData[level][0]; 
			maxPower  = levelData[level][0];
			behavior  = levelData[level][1];
			//TODO
			//this.skinClass = levelData[level][2];

			for (var i:int = 0; i < behavior.length; i ++){
				
				_behaviorSteps[i] = new behavior[i][0](behavior[i].slice(1));
				_behaviorReqs.push(_behaviorSteps[i].req);
				//if at least one behavior step needs to loop, then the entity is a loopable entity and
				//we need to include it in the loopable entities array
				if(_behaviorSteps[i].when == "loop")
					loopable = true;
			}
			
		}
		
		private function initActionButtons():void {
			_actionButtons = new Vector.<ActionButtonVO>;
			var sell:ActionButtonVO = new ActionButtonVO("sell", "sell");
			var setRallypoint:ActionButtonVO = new ActionButtonVO("set_rallypoint", "setRallypoint");
			var upgrade:ActionButtonVO = new ActionButtonVO("upgrade", "upgrade");
			actionButtons.push(sell, setRallypoint, upgrade);
		}
		
		public function get maxUnits():int
		{
			return _maxUnits;
		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}