package interfaces
{
	import model.EntityVO;

	public interface IBehavior
	{
		function loop(entity:EntityVO, entitiesSubgroup:Vector.<EntityVO> = null):void;
		function set req(value:String):void;
		function get req():String;
	}
}