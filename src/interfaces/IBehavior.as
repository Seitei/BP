package interfaces
{
	import model.EntityVO;

	public interface IBehavior
	{
		function loop(entity:EntityVO):void;
	}
}