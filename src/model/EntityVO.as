package model
{
	import flash.geom.Point;
	
	import interfaces.IBehavior;
	import interfaces.IBuff;
	
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
		private var _speed:Number;
		private var _id:String;
		private var _parentContainerId:String;
		private var _childEntityId:String;
		private var _hp:int;
		private var _status:int;
		private var _buff:IBuff;
		private var _owner:String;
		private var _rotation:Number;
		private var _entityTypeSpawned:String;
		private var _spawningPoint:Point;
		private var _forwardAngle:int;
		private var _spawnRate:int;
		private var _damage:int;
		private var _rallypoint:Point;
		private var _spawningpoint:Point;
		private var _positionDest:Point;
		private var _cost:int;
		
		protected var _actionButtons:Vector.<ActionButtonVO>;
		protected var _behavior:Vector.<Class>;
		protected var _behaviorSteps:Vector.<IBehavior>;
		protected var _behaviorReqs:Array;
		
		
		
		
		public function EntityVO()
		{
			position = new Point();
			_rotation = 0;
			_behavior = new Vector.<Class>;
			_behaviorSteps = new Vector.<IBehavior>;
			_behaviorReqs = new Array();
			//_rallypoint = new Point();
			_spawningpoint = new Point();
			//_positionDest = new Point();
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

		public function get damage():int
		{
			return _damage;
		}

		public function set damage(value:int):void
		{
			_damage = value;
		}

		public function get behaviorReqs():Array
		{
			return _behaviorReqs;
		}

		public function get spawnRate():int
		{
			return _spawnRate;
		}

		public function set spawnRate(value:int):void
		{
			_spawnRate = value;
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
		
		public function get entityTypeSpawned():String
		{
			return _entityTypeSpawned;
		}

		public function set entityTypeSpawned(value:String):void
		{
			_entityTypeSpawned = value;
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

		public function get buff():IBuff
		{
			return _buff;
		}

		public function set buff(value:IBuff):void
		{
			_buff = value;
		}

		public function get status():int
		{
			return _status;
		}

		public function set status(value:int):void
		{
			_status = value;
		}

		public function get hp():int
		{
			return _hp;
		}

		public function set hp(value:int):void
		{
			_hp = value;
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

		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
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