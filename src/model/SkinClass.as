package model
{
	import flash.utils.Dictionary;

	public class SkinClass
	{
		private var _skinName:String;
		private var _animate:Boolean;
		private var _animateOnHover:Boolean;
		private var _animateOnEnterFrame:Boolean;
		private var _animationsDic:Dictionary;
		private var _buildingAnimationMethod:String;
		private var _originalMcc:String;
		
		public function SkinClass(skinName:String = "", originalMcc:String = "",  animate:Boolean = true)
		{
			_animationsDic = new Dictionary();
			_skinName = skinName;	
			_animate = animate;
			_animateOnEnterFrame = animateOnEnterFrame;
			_originalMcc = originalMcc;
		}

		
		public function get originalMcc():String
		{
			return _originalMcc;
		}

		public function set originalMcc(value:String):void
		{
			_originalMcc = value;
		}

		public function get buildingAnimationMethod():String
		{
			return _buildingAnimationMethod;
		}

		public function set buildingAnimationMethod(value:String):void
		{
			_buildingAnimationMethod = value;
		}

		public function get animationsDic():Dictionary
		{
			return _animationsDic;
		}
		
		public function set animationsDic(dic:Dictionary):void
		{
			_animationsDic = dic;
		}

		public function get animateOnEnterFrame():Boolean
		{
			return _animateOnEnterFrame;
		}

		public function set animateOnEnterFrame(value:Boolean):void
		{
			_animateOnEnterFrame = value;
		}

		public function get animeOnHover():Boolean
		{
			return _animateOnHover;
		}

		public function set animeOnHover(value:Boolean):void
		{
			_animateOnHover = value;
		}

		public function get animate():Boolean
		{
			return _animate;
		}

		public function set animate(value:Boolean):void
		{
			_animate = value;
		}

		public function get skinName():String
		{
			return _skinName;
		}

		public function set skinName(value:String):void
		{
			_skinName = value;
		}

	}
}