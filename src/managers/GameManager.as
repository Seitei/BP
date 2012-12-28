package managers
{
	import actions.Action;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	
	import interfaces.IAttack;
	import interfaces.IBuildeable;
	import interfaces.IEntityVO;
	import interfaces.IMovableEntity;
	import interfaces.ITargeteable;
	import interfaces.ITargeter;
	import interfaces.IUnitSpawner;
	
	import model.EntityFactoryVO;
	import model.EntityVO;
	import model.SkinClass;
	import model.UnitVO;
	import model.WorldVO;
	
	import org.osflash.signals.Signal;
	
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.errors.AbstractClassError;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	import utils.GameStatus;
	import utils.Movement;
	import utils.UnitStatus;
	
	import view.SpriteEntity;

	public class GameManager
	{
		private static var _instance:GameManager;
		private var _state:int;
		private var _entities:Array;
		private var _world:WorldVO;
		private var _entitySignal:Signal;
		private var _playerName:String;
		
		public function GameManager()
		{
			_entities = new Array();
			_state = GameStatus.STOPPED;
			_entitySignal = new Signal(Action);
			_entitySignal.add(updateWorld);
			_world = WorldVO.getInstance();
		}
		
		public function get world():WorldVO {
			return _world;
		}
		
		public function get playerName():String
		{
			return _playerName;
		}

		public function set playerName(value:String):void
		{
			_playerName = value;
			_world.playerName = _playerName;
		}

		public function dispatchAction(action:Action):void {
			_entitySignal.dispatch(action);
		}
		
		public function updateWorld(action:Action):void {
			switch(action.type) {
				case "addEntity":
					renderEntity(action.entity);
					_world.addEntity(action.entity);
					break;
				case "sell":
					removeEntity(action.entity);
					break;
				case "setRallypoint":
					_world.updateEntity(action.entity);
					break;
				case "upgrade":
					Main.getInstance().getRenderer().removeEntity(action.entity.id);
					_world.updateEntity(action.entity);
					renderEntity(action.entity);
					break;
			}
		}
		
		//here I receive the other's players actions
		public function updatePlayersWorld(buffer:Vector.<Action>):void {
			
			
			for each ( var action:Action in buffer) {
	
				if(action.type == "addEntity" || action.type == "upgrade"){
					action.entity.position.x = 700 - action.entity.position.x;
					action.entity.position.y = 700 - action.entity.position.y; 
					action.entity.rotation += 180 * (Math.PI / 180);
					if(action.entity is IUnitSpawner && IUnitSpawner(action.entity).rallypoint) {
						IUnitSpawner(action.entity).rallypoint.x = 700 - IUnitSpawner(action.entity).rallypoint.x;
						IUnitSpawner(action.entity).rallypoint.y = 700 - IUnitSpawner(action.entity).rallypoint.y;
					}
				}
				if(action.type == "setRallyPoint")
					IUnitSpawner(action.entity).rallypoint.y = 700 - IUnitSpawner(action.entity).rallypoint.y;
				
				updateWorld(action);
			}
		}
		
		private function renderEntities():void {
			var entities:Array = new Array();
			entities = _world.getEntities();
			for each (var ent:EntityVO in entities) {
				renderEntity(ent);	
			}
		}
		
		public function loop(event:Event):void {
			if (_state == GameStatus.PLAYING || _state == GameStatus.COUNTDOWN_PLAYING)
				updateEntities();	
		}
		
		private function updateEntities():void {
			var spriteEntities:Dictionary = Main.getInstance().getRenderer().getSpriteEntitiesDic();
			var entities:Array = _world.getEntities();
			
			for each (var ent:EntityVO in entities) {
				if(ent is IMovableEntity) {
					if(!IMovableEntity(ent).positionDest.equals(ent.position)) {
						Movement.moveToPoint(spriteEntities[ent.id], IMovableEntity(ent).positionDest, ent.speed, true); 
						ent.position.x = spriteEntities[ent.id].x;
						ent.position.y = spriteEntities[ent.id].y;
						
						if(ent.status == UnitStatus.IDDLE){
							ent.status = UnitStatus.MOVING_TO_TARGET;
							Main.getInstance().getRenderer().playAnimation(ent.id, "walking", true);
						}
					}
					else {
						if(ent.status == UnitStatus.MOVING_TO_TARGET){
							ent.status = UnitStatus.IDDLE;
							Main.getInstance().getRenderer().playAnimation(ent.id, "iddle", true);
						}
					}		
				}
				
				//detect if another unit is in range
				if(ent is ITargeter && ent.status != UnitStatus.BUILDING) {
					IUnitSpawner(ent).canSpawn = false;
					for each(var target:EntityVO in entities) {
						if(target is ITargeteable && ent.owner != target.owner) {
							var entPoint:Point = ent.position.clone();
							var targetPoint:Point = target.position.clone();
							var dist:Number = Point.distance(entPoint, targetPoint);
							if(dist < ITargeter(ent).targetRange){
								IUnitSpawner(ent).canSpawn = true;
								IUnitSpawner(ent).rallypoint = targetPoint;
								break;
							}
						}
					}
				}
					
				//detect collision
				if(ent is IAttack) {
					for each(var targetedEnt:EntityVO in entities) {
						if(targetedEnt.owner != ent.owner && targetedEnt is ITargeteable) {
							var rec:Rectangle = spriteEntities[ent.id].getBounds(spriteEntities[ent.id].parent);
							var rec2:Rectangle = spriteEntities[targetedEnt.id].getBounds(spriteEntities[targetedEnt.id].parent);
							if(rec.intersects(rec2)){
								
								removeEntity(ent);
								targetedEnt.hp -= IAttack(ent).damage;
								
								//if the HQ is getting damaged, then we pass the message to the manager
								if(targetedEnt.type == "hq")
									Manager.getInstance().hp = targetedEnt.hp; 
										
								if(targetedEnt.hp <= 0){
									//end game if someone destroys the HQ
									if(targetedEnt.type == "hq")
										resetGame();
									removeEntity(targetedEnt);
								}
							}
						}
					}
				}
				
				if(ent is IUnitSpawner) {
					if(IUnitSpawner(ent).canSpawn){
						IUnitSpawner(ent).advanceTime();
					}
				}
				
				if(ent is IBuildeable && ent.status == UnitStatus.BUILDING) {
					IBuildeable(ent).advanceConstructionTime();
				}
				
				
			}
		}
		private function resetGame():void {
			//cleaning the world content
			Manager.getInstance().resetGame();	
		}
		
		
		public function set state(state:int):void {
			_state = state;
		}
		
		
		private function renderEntity(ent:EntityVO):void {
			Main.getInstance().getRenderer().renderObject(ent);
		}
		
		private function removeEntity(ent:EntityVO):void {
			if(_world.entitiesDic[ent.parentContainer] is IUnitSpawner) {
				_world.entitiesDic[ent.parentContainer].maxUnits++;				
			}
				
			_world.removeEntity(ent);
			Main.getInstance().getRenderer().removeEntity(ent.id);
			
		}
		
		public static function getInstance():GameManager {
			if( _instance == null )
				_instance = new GameManager();
			return _instance;
		}
	
		
		
		
		
		
	}	
}