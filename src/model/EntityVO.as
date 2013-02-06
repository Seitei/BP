package model
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import interfaces.IBehavior;
	
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	import view.ActionButton;
	
	public class EntityVO
	{
		private var _x:Number;
		private var _y:Number;
		private var _position:Point;
		private var _skinClass:SkinClass;
		private var _type:String = "";
		private var _id:String;
		private var _parentContainerId:String;
		private var _childEntityId:String;
		private var _status:int;
		private var _owner:String;
		private var _rotation:Number;
		private var _entityToSpawn:Object;
		private var _spawningPoint:Point;
		private var _forwardAngle:int;
		private var _power:int;
		private var _rallypoint:Point;
		private var _spawningpoint:Point;
		private var _positionDest:Point;
		private var _cost:int;
		private var _tilesAffectedArray:Array;
		private var _loopable:Boolean;
		private var _attackable:Boolean;
		private var _levelData:Array;
		private var _behavior:Array;
		private var _level:int;
		private var _maxPower:int;
		private var _visible:Boolean;
		
		protected var _buffsDic:Dictionary;
		protected var _actionButtons:Vector.<ActionButtonVO>;
		protected var _behaviorSteps:Vector.<IBehavior>;
		protected var _behaviorReqs:Array;
		
		
		public function EntityVO()
		{
			position = new Point();
			_rotation = 0;
			_behavior = new Array();
			_behaviorSteps = new Vector.<IBehavior>;
			_behaviorReqs = new Array();
			_spawningpoint = new Point();
			_levelData = new Array();
			
		}
		
		public function get visible():Boolean
		{
			return _visible;
		}

		public function set visible(value:Boolean):void
		{
			_visible = value;
		}

		public function get maxPower():int
		{
			return _maxPower;
		}

		public function set maxPower(value:int):void
		{
			_maxPower = value;
		}

		public function get level():int
		{
			return _level;
		}
		
		public function set applyLevel(level:int):void {
			
		}

		public function set level(value:int):void
		{
			_level = value;
		}

		public function get behavior():Array
		{
			return _behavior;
		}

		public function set behavior(value:Array):void
		{
			_behavior = value;
		}

		public function get levelData():Array
		{
			return _levelData;
		}

		public function set levelData(value:Array):void
		{
			_levelData = value;
		}

		public function get attackable():Boolean
		{
			return _attackable;
		}

		public function set attackable(value:Boolean):void
		{
			_attackable = value;
		}

		public function get behaviorSteps():Vector.<IBehavior>
		{
			return _behaviorSteps;
		}

		public function set behaviorSteps(value:Vector.<IBehavior>):void
		{
			_behaviorSteps = value;
		}

		public function get loopable():Boolean
		{
			return _loopable;
		}

		public function set loopable(value:Boolean):void
		{
			_loopable = value;
		}

		public function get tilesAffectedArray():Array
		{
			return _tilesAffectedArray;
		}

		public function set tilesAffectedArray(value:Array):void
		{
			_tilesAffectedArray = value;
		}

		public function get cost():int
		{
			return _cost;
		}

		public function set cost(value:int):void
		{
			_cost = value;
		}

		public function get positionDest():Point
		{
			return _positionDest;
		}

		public function set positionDest(value:Point):void
		{
			_positionDest = value;
		}

		public function get spawningpoint():Point
		{
			return _spawningpoint;
		}

		public function set spawningpoint(value:Point):void
		{
			_spawningpoint = value;
		}

		public function get rallypoint():Point
		{
			return _rallypoint;
		}

		public function set rallypoint(value:Point):void
		{
			_rallypoint = value;
		}

		public function get power():int
		{
			return _power;
		}

		public function set power(value:int):void
		{
			_power = value;
		}

		public function get behaviorReqs():Array
		{
			return _behaviorReqs;
		}

		public function get forwardAngle():int
		{
			return _forwardAngle;
		}

		public function set forwardAngle(value:int):void
		{
			_forwardAngle = value;
		}

		public function set spawningPoint(value:Point):void {
			_spawningPoint = value;	
		}
		
		public function get spawningPoint():Point {
			return _spawningPoint;
		}	
		
		public function get entityToSpawn():Object
		{
			return _entityToSpawn;
		}

		public function set entityToSpawn(value:Object):void
		{
			_entityToSpawn = value;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		public function loop(behaviorReqsContent:Array):void {
			
		}
		
		public function get actionButtons():Vector.<ActionButtonVO>
		{
			return _actionButtons;
		}
		
		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			_rotation = value;
		}

		public function get owner():String
		{
			return _owner;
		}

		public function set owner(value:String):void
		{
			_owner = value;
		}

		public function get status():int
		{
			return _status;
		}

		public function set status(value:int):void
		{
			_status = value;
		}

		public function get childEntity():String
		{
			return _childEntityId;
		}

		public function set childEntity(value:String):void
		{
			_childEntityId = value;
		}

		public function get parentContainer():String
		{
			return _parentContainerId;
		}

		public function set parentContainer(value:String):void
		{
			_parentContainerId = value;
		}

		public function set skinClass(value:SkinClass):void
		{
			_skinClass = value;
		}

		public function get skinClass():SkinClass
		{
			return _skinClass;
		}
	
		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position = value;
		}

		
	}
}