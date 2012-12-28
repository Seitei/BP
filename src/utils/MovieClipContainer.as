package utils
{
	import flash.utils.Dictionary;
	
	import model.SkinClass;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MovieClipContainer extends Sprite
	{
		private var _movieClipsDic:Dictionary;
		private var _currentLabel:String;
		private var _movieClipsCount:int = 1;
		private var _paused:Boolean = false;
		private var _isPlaying:Boolean = false;
		private var _id:String;
		private var _skinClass:SkinClass;
		
		public function MovieClipContainer()
		{
			super();
			_movieClipsDic = new Dictionary();
		}
		
		public function get currentLabel():String
		{
			return _currentLabel;
		}

		public function get skinClass():SkinClass
		{
			return _skinClass;
		}

		public function set skinClass(value:SkinClass):void
		{
			_skinClass = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}

		public function addMovieClip(movieClip:MovieClip, label:String, playOnce:Boolean = false, current:Boolean = false):void
		{
			movieClip.name = label;
			_movieClipsDic[label] = movieClip;
			addChild(movieClip);
			Starling.juggler.add(movieClip);
			movieClip.stop();
			if (_movieClipsCount++ == 1 || current) {
				_currentLabel = label;
				
			} else {
				movieClip.visible = false;
			}
			if (playOnce){
				movieClip.addEventListener(Event.COMPLETE, onComplete);
			}
		}
		
		private function onComplete(e:Event):void {
			getCurrentMovieClip().stop();
			getCurrentMovieClip().visible = false;
			_isPlaying = false;
			
		}
	
		public function setCurrentLabel(label:String):void {
			_currentLabel = label;	
		}
		
		public function play(label:String, loop:Boolean = true):void
		{
			if (_currentLabel == label && _isPlaying == true) return;
			
			getCurrentMovieClip().visible = false;
			getCurrentMovieClip().stop();

			_currentLabel = label;
			
			_movieClipsDic[label].loop = loop;
			_movieClipsDic[label].play();
			_movieClipsDic[label].visible = true;
			
			_isPlaying = true;
			
		}
		
		public function stop():void
		{
			getCurrentMovieClip().stop();
			_isPlaying = false;
		}
		
		public function loop(value:Boolean):void
		{
			getCurrentMovieClip().loop = value;
		}
		
		public function pauseOrResume():void
		{
			_isPlaying = !_isPlaying;
			
			if (!_isPlaying) {
				getCurrentMovieClip().pause();
				_isPlaying = false;
				trace("stopping the animations");
			}
			else {
				getCurrentMovieClip().play();
				_isPlaying = true;
				trace("resuming the animations");
			}
		}
		
		public function getCurrentMovieClip():MovieClip
		{
			return _movieClipsDic[_currentLabel];
		}
		
		public function setCurrentMovieClip(label:String):void
		{
			if (_currentLabel == label)
				return;
			
			getCurrentMovieClip().visible = false;
			getCurrentMovieClip().stop();
			
			_currentLabel = label;
			
			_movieClipsDic[label].stop();
			_movieClipsDic[label].visible = true;
		}
		
		
		
		
		
		
		
	}
}