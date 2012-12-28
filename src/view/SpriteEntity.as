package view
{
	import starling.display.Sprite;
	
	public class SpriteEntity extends Sprite
	{
		private var _id:String;
		public function SpriteEntity(id:String)
		{
			_id = id;
			super();
		}
	
		public function get id():String
		{
			return _id;
		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}