package interfaces
{
	import model.EntityVO;

	public interface IBehavior
	{
		function execute(entity:EntityVO, reqs:* = null):void;
		function set req(value:String):void;
		function get req():String;
		function set when(value:String):void;
		function get when():String;
	}
}