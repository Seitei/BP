package model
{
	import flash.geom.Point;
	import flash.media.ID3Info;
	import flash.utils.Dictionary;
	
	import interfaces.IEntityVO;
	
	import starling.display.Sprite;

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
		private var _entitiesArray:Array;
		private var _unitsArray:Dictionary;
		private var _buildingsArray:Dictionary;
		private var _bulletsArray:Dictionary;
		
		private var _counter:int = 0; 
		private var _playerName:String;
		
		public function WorldVO()
		{
			_entitiesDic = new Dictionary();
			_entitiesArray = new Array();
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
						_entitiesDic[entity.id][property] = value;
						_entitiesArray[count][property] = value;
					}
					break;
				}
				count++;
			}
		}
		
		public function addEntity(entity:EntityVO):void {
			if(entity.parentContainer)
				_entitiesDic[entity.parentContainer].childEntity = entity.id;
			
			_entitiesArray.push(entity);
			_entitiesDic[entity.id] = entity;	
		}
		
		public function removeEntity(entity:EntityVO):void {
			if(entity.parentContainer && _entitiesDic[entity.parentContainer])
				_entitiesDic[entity.parentContainer].childEntity = null;
			
			_entitiesDic[entity.id] = null;
			_entitiesArray.splice(_entitiesArray.indexOf(entity, 0), 1);
			
			/*var count:int = 0;
			for each(var ent:EntityVO in _entitiesArray) {
				if(ent.id == entity.id) {
					_entitiesArray.splice(count, 1);
					break;
				}
				count++;
			}*/
		}
		public function resetContent():void {
			_entitiesDic = new Dictionary();
			_entitiesArray = new Array();
		}
		
		public function getEntity(id:String):EntityVO {
			return _entitiesDic[id];
		}
		
		public function getEntities():Array {
			return _entitiesArray;
		}
		
		public static function getInstance():WorldVO {
			if ( !_instance)
				_instance = new WorldVO();
			return _instance;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}