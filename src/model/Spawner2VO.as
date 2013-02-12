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

	public class Spawner2VO extends EntityVO
	{
		private var _cost:int;
		private var _rallypoint:Point;
		
		private var _maxUnits:int = 1;
		private var _currentUnits:int = 0;
			
		public function Spawner2VO(level:int = 1, x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			cost = 3;
			attackable = true;
			name = "spawner2";
			skinClass = new SkinClass("spawner2", "spawner2", false);
			skinClass.animationsDic["spawner2"] = true;
			power = 500;
			entityToSpawn = ["bullet", 1];
			spawningPoint = new Point(18, -18);
			//set what the entity has to show in the selector panel
			initActionButtons();
			
			//behavior:
			behavior[0] = [Spawn, "bullet", 60];
			
			for (var i:int = 0; i < behavior.length; i ++){
				
				_behaviorSteps[i] = new behavior[i][0](behavior[i].slice(1));
				_behaviorReqs.push(_behaviorSteps[i].req);
				//if at least one behavior step needs to loop, then the entity is a loopable entity and
				//we need to include it in the loopable entities array
				if(_behaviorSteps[i].when == "loop")
					loopable = true;
			}
		}
		
		override public function loop(behaviorReqsContent:Array):void {
			for (var i:int = 0; i < behavior.length; i ++){
				_behaviorSteps[i].execute(this, behaviorReqsContent[i]);
			}
		}
		
		private function initActionButtons():void {
			_actionButtons = new Vector.<ActionButtonVO>;
			var sell:ActionButtonVO = new ActionButtonVO("sell", "sell");
			var setRallypoint:ActionButtonVO = new ActionButtonVO("set_rallypoint", "setRallypoint");
			actionButtons.push(sell, setRallypoint);
		}
		
		public function get maxUnits():int
		{
			return _maxUnits;
		}

	}
}