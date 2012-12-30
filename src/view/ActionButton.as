package view
{
	import model.ActionButtonVO;
	
	import starling.textures.Texture;
	
	import utils.ExtendedButton;
	
	public class ActionButton extends ExtendedButton
	{
		private var _actionType:String;
		private var _targetType:String;
		private var _entityType:String;
		private var _actionButtonsVO:Vector.<ActionButtonVO>;
		private var _mouseCursorTexture:Texture;
		
		public function ActionButton(upState:Texture, actionType:String, entityType:String = "", targetType:String = null, actionButtonsVO:Vector.<ActionButtonVO> = null, text:String = "", downState:Texture = null, hoverState:Texture = null, mouseCursorTexture:Texture = null)
		{
			_actionType = actionType;
			_entityType = entityType;
			_targetType = targetType;
			_actionButtonsVO = actionButtonsVO;
			_mouseCursorTexture = mouseCursorTexture;
			super(upState, text, downState, hoverState, mouseCursorTexture);
		}
	
		
		public function get actionButtons():Vector.<ActionButtonVO>
		{
			return _actionButtonsVO;
		}

		public function get entityType():String
		{
			return _entityType;
		}

		public function get targetType():String
		{
			return _targetType;
		}

		public function get actionType():String
		{
			return _actionType;
		}
		
		public function get mouseCursorTexture():Texture {
			return _mouseCursorTexture;
		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}