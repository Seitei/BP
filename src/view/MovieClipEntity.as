package view
{
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	import utils.MovieClipContainer;
	
	public class MovieClipEntity extends MovieClip
	{
		private var _id:String;
		private var _animateOnHover:Boolean;
		private var _addedToJuggler:Boolean;
		private var _frameSprite:MovieClipContainer;
		
		public function MovieClipEntity(textures:Vector.<Texture>,fps:int, id:String, animateOnHover:Boolean = false)
		{
			_id = id;
			_animateOnHover = animateOnHover;
			_frameSprite = new MovieClipContainer();
			super(textures, fps);
		}
	
		public function get frameSprite():MovieClipContainer
		{
			return _frameSprite;
		}

		public function set frameSprite(value:MovieClipContainer):void
		{
			_frameSprite = value;
		}

		public function get addedToJuggler():Boolean
		{
			return _addedToJuggler;
		}

		public function set addedToJuggler(value:Boolean):void
		{
			_addedToJuggler = value;
		}

		public function get animateOnHover():Boolean
		{
			return _animateOnHover;
		}

		public function get id():String
		{
			return _id;
		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}