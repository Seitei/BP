package view
{
	import model.ActionButtonVO;
	
	import starling.textures.Texture;
	
	import utils.ExtendedButton;
	
	public class TileButton extends ExtendedButton
	{
		private var _row:String;
		
		public function TileButton(upState:Texture, row:String, downState:Texture = null, hoverState:Texture = null)
		{
			super(upState, "", downState, hoverState);
		}
	
		public function get row():String
		{
			return _row;
		}

		public function set row(value:String):void
		{
			_row = value;
		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}