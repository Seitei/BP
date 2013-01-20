package model
{
	import flash.geom.Point;
	import flash.media.ID3Info;
	import flash.utils.Dictionary;
	
	import starling.display.Sprite;
	import starling.errors.AbstractClassError;

	public class WorldVO
	{
		//refers to the position to place the tiles
		private static const BOT:int = 0;
		private static const TOP:int = 1;
		
		private var _x:Number;
		private var _y:Number;
		private var _skinClass:String;
		private var _speed:Number = 1;
		public var type:String = "unit";
		private static var _instance:WorldVO;
		private var _entitiesDic:Dictionary;
		private var _entitiesArray:Vector.<EntityVO>;
		private var _entitiesSubgroupsDic:Dictionary;
		private var _unitsArray:Dictionary;
		private var _buildingsArray:Dictionary;
		private var _bulletsArray:Dictionary;
		private var _playersNamesArray:Array;
		
		private var _counter:int = 0; 
		private var _playerName:String;
		
		public function WorldVO()
		{
			_entitiesDic = new Dictionary();
			_entitiesArray = new Vector.<EntityVO>;
			
			_entitiesSubgroupsDic = new Dictionary();
				_entitiesSubgroupsDic["loopable_entities"] = new Vector.<EntityVO>;
				
				
			
			_playersNamesArray = new Array();
		}

		public function get playerName():String
		{
			return _playerName;
		}

		public function set playerName(value:String):void
		{
			_playerName = value;
			EntityFactoryVO.getInstance().playerName = _playerName;
		}

		public function get entitiesDic():Dictionary
		{
			return _entitiesDic;
		}

		public function updateEntity(entity:EntityVO, property:String = "", value:* = null):void {
			
			var count:int= 0;
			for each(var ent:EntityVO in _entitiesArray) {
				if(ent.id == entity.id) {
					if(property == ""){
						_entitiesArray[count] = entity;
						_entitiesDic[entity.id] = entity;
					}
					else{
						_entitiesArray[count][property] = value;
						_entitiesDic[entity.id][property] = value;
					}
					break;
				}
				count++;
			}
		}
		
		private function createSubgroupVectors(owner:String):void {
			if((owner != _playersNamesArray[0] || _playersNamesArray.length == 0)){
				_playersNamesArray.push(owner);
				_entitiesSubgroupsDic[owner] = new Vector.<EntityVO>;
				_entitiesSubgroupsDic[owner + "_attackable_entities"] = new Vector.<EntityVO>; 
			}
		}
		
		public function addEntity(entity:EntityVO):void {
			
			//TODO -> change this when ship and background gets implemented
			if(entity.owner){
				if(_playersNamesArray.length < 2){
					createSubgroupVectors(entity.owner);
				}
				
				_entitiesSubgroupsDic[entity.owner].push(entity);
				
				if(entity.attackable){
					_entitiesSubgroupsDic[entity.owner + "_attackable_entities"].push(entity);
				}
			}

			if(entity.parentContainer)
				_entitiesDic[entity.parentContainer].childEntity = entity.id;
			
			_entitiesArray.push(entity);
			_entitiesDic[entity.id] = entity;	
			
			if(entity.loopable){
				_entitiesSubgroupsDic["loopable_entities"].push(entity);
			}
				
			
		}
		
		public function removeEntity(entity:EntityVO):void {
			if(entity.parentContainer && _entitiesDic[entity.parentContainer])
				_entitiesDic[entity.parentContainer].childEntity = null;
			
			_entitiesDic[entity.id] = null;
			_entitiesArray.splice(_entitiesArray.indexOf(entity, 0), 1);
			
			for each(var entityVector:Vector.<EntityVO> in _entitiesSubgroupsDic){
				
				if(entityVector.indexOf(entity, 0) != -1)
					entityVector.splice(entityVector.indexOf(entity, 0), 1);
					
			}
			
			
		}
		
		private function getEnemyName(owner:String):String {
			if(_playersNamesArray[0] == owner)
				return _playersNamesArray[1];
			else
				return _playersNamesArray[0];
		}
		
		public function getEntitiesSubgroup(subgroup:String, owner:String = "all"):Vector.<EntityVO> {
			
			switch(subgroup) {
				case "enemy_entities":
					return _entitiesSubgroupsDic[getEnemyName(owner)];
					break;
			
				case "ally_entities":
					return _entitiesSubgroupsDic[owner];
					break;
				
				case "loopable_entities":
					return _entitiesSubgroupsDic["loopable_entities"];
					break;
				
				case "enemy_attackable_entities":
					return _entitiesSubgroupsDic[getEnemyName(owner) + "_attackable_entities"];
					break;
				
				case "all_entities":
					return _entitiesArray;
					break;
				
				default:
					return null;
					break;
			}
		}
		
		public function getEntity(id:String):EntityVO {
			return _entitiesDic[id];
		}
		
		public function getEntities():Vector.<EntityVO> {
			return _entitiesArray;
		}
		
		public static function getInstance():WorldVO {
			if ( !_instance)
				_instance = new WorldVO();
			return _instance;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}