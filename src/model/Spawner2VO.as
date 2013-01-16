package model
{
	import actions.Action;
	
	import behavior_steps.Move;
	import behavior_steps.Spawn;
	
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	
	import interfaces.IBehavior;
	import interfaces.ITargeteable;
	
	import managers.GameManager;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class Spawner2VO extends EntityVO implements ITargeteable
	{
		private var _cost:int;
		private var _rallypoint:Point;
		
		private var _maxUnits:int = 1;
		private var _currentUnits:int = 0;
			
		public function Spawner2VO(x:int = 0, y:int = 0)
		{
			position.x = x, position.y = y;
			//TODO temporary fix
			cost = 3;
			type = "spawner2";
			speed = 1;
			spawnRate = 60;
			skinClass = new SkinClass("spawner2", "spawner2", false);
			skinClass.animationsDic["spawner2"] = true;
			hp = 500;
			entityTypeSpawned = "bullet";
			spawningPoint = new Point(18, -18);
			//set what the entity has to show in the selector panel
			initActionButtons();
			
			//behavior:
			_behavior.push(Spawn);
			
			for (var i:int = 0; i < _behavior.length; i ++){
				_behaviorSteps[i] = new _behavior[i](this);
				_behaviorReqs.push(_behaviorSteps[i].req);
			}
		}
		
		override public function loop(behaviorReqsContent:Array):void {
			for (var i:int = 0; i < _behavior.length; i ++){
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