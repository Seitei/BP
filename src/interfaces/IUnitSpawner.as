package interfaces
{
	import flash.geom.Point;

	public interface IUnitSpawner
	{
		function spawnUnit():void;
		function advanceTime():void;
		function set rallypoint(point:Point):void;
		function get rallypoint():Point;
		function set canSpawn(value:Boolean):void;
		function get canSpawn():Boolean;
		function set maxUnits(value:int):void
		function get maxUnits():int	
		function set spawnRate(value:Number):void
		function get spawnRate():Number
		function set spawningPoint(value:Point):void
		function get spawningPoint():Point
	}
}