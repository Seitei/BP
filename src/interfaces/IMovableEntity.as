package interfaces
{
	import flash.geom.Point;

	public interface IMovableEntity
	{
		function get hasTarget():Boolean;
		function get positionDest():Point;
		function set positionDest(value:Point):void;
	}
}