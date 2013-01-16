package interfaces
{
	import model.EntityVO;

	public interface IBehavior
	{
		function execute(entity:EntityVO, entitiesSubgroup:Vector.<EntityVO> = null):void;
		function set req(value:String):void;
		function get req():String;
	}
}