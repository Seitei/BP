package interfaces
{
	public interface IBuff
	{
		function set buffType(value:String):void;
		function get buffType():String;
		function set targetType(value:String):void;
		function get targetType():String;
		function set buffStats(value:int):void;
		function get buffStats():int;
		function set targetRange(value:int):void;
		function get targetRange():int;
	}
}