package view
{
	import Signals.BroadcastSignal;
	import Signals.EntityClickedSignal;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import managers.Manager;
	
	import model.EntityVO;
	
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	import utils.MovieClipContainer;
	import utils.ResourceManager;
	import utils.UnitStatus;

	public class Renderer extends Sprite
	{
		private static const BOT:int = 1;
		private static const TOP:int = 0;
		private static var BGSPEED:Number = 0.5;
		
		private static var _instance:Renderer;
		private var _manager:Manager;
		private var _spriteEntityDic:Dictionary;
		private var _playerName:String;
		private var _stateChangeRelatedAnimationsDic:Dictionary;
		private var _hoveredEntity:MovieClipContainer;
		private var _backgroundImagesArray:Array;
		private var _prevBGImage:int;
		private var _nextBGImage:int;
		private var _bgContainer:Sprite;
		private var _myShip:Sprite;
		private var _enemyShip:Sprite;
		
		public function Renderer()
		{
			_spriteEntityDic = new Dictionary();
			_stateChangeRelatedAnimationsDic = new Dictionary();
			_manager = Manager.getInstance();
			_bgContainer = new Sprite();
			addChild(_bgContainer);
		}
		
		public function set playerName(value:String):void
		{
			_playerName = value;
		}

		public function renderEntity(entity:EntityVO):void {
			
			var mcc:MovieClipContainer = new MovieClipContainer();
			mcc.id = entity.id;
			mcc.skinClass = entity.skinClass;
				
			for (var animation:String in entity.skinClass.animationsDic) {
				var value:Boolean = entity.skinClass.animationsDic[animation];
				var key:String = animation;
				
				if(entity.skinClass.animate){
					var frames:Vector.<Texture> = ResourceManager.getInstance().getTextures(entity.skinClass.skinName, key, entity.skinClass.animate);
					var mc:MovieClip = new MovieClip(frames, 30);
					mcc.addMovieClip(mc, key);
				}
				else {
					var frame:Vector.<Texture> = new Vector.<Texture>;
					frame[0] = ResourceManager.getInstance().getTexture(entity.skinClass.skinName);
					var mc2:MovieClip = new MovieClip(frame, 30);
					mcc.addMovieClip(mc2, key);
				}
			}
				
			mcc.x = entity.position.x; mcc.y = entity.position.y;
			
			
			
			mcc.pivotX = mcc.width/2; mcc.pivotY = mcc.height/2;

			if(entity.rotation)
				mcc.rotation = entity.rotation; 
			
			_spriteEntityDic[entity.id] = mcc;
			
			//if(entity.owner == _playerName) {
				mcc.addEventListener(TouchEvent.TOUCH, onTouch);
				mcc.useHandCursor = true;
			//}
			
			if(entity.type == "tile"){
				if(entity.owner == _playerName)
					_myShip.addChild(mcc);
				else {
					_enemyShip.addChild(mcc);
					mcc.x -= 335;
					mcc.y -= 335;
				}
			}
			else
				addChild(mcc);
			
			mcc.setCurrentMovieClip(mcc.skinClass.originalMcc);
			
			/*var quad:Quad = new Quad(2, 2);
			addChild(quad); quad.x = entity.position.x; quad.y = entity.position.y;*/
		}
		
		public function pauseOrResumeAnimations():void {
			for each(var id:String in _stateChangeRelatedAnimationsDic){
				_spriteEntityDic[id].pauseOrResume();
			}
		}
		
		public function resetDisplayContent():void {
			for each(var mcc:MovieClipContainer in _spriteEntityDic){
				removeEntity(mcc.id);
			}
		}
		
		public function playAnimation(id:String, animation:String, stateChangeRelatedAnimation:Boolean = false):void {
			
			//play animation
			if(stateChangeRelatedAnimation)
				_stateChangeRelatedAnimationsDic[id] = id;
			
			_spriteEntityDic[id].play(animation);
			
		}
		
		public function removeEntity(entityId:String):void {
			removeChild(_spriteEntityDic[entityId], true);
		}
		
		
		
		public function addToJuggler(id:String):void {
			if(!_spriteEntityDic[id].addedToJuggler) {
				Starling.juggler.add(_spriteEntityDic[id]);
				_spriteEntityDic[id].addedToJuggler = true;
			}
		}
		
		public function addShips():void {
			//my ship
			_myShip = new Sprite();
			addChild(_myShip);
			var image:Image = new Image(ResourceManager.getInstance().getTexture("ship"));
			image.rotation = 0;
			_myShip.addChild(image);
			_myShip.x = -365 / 2; _myShip.y = 700 - 365 / 2;
			
			//enemmy ship
			_enemyShip = new Sprite();
			addChild(_enemyShip);
			var image2:Image = new Image(ResourceManager.getInstance().getTexture("ship"));
			image2.pivotX = image2.width / 2; 
			image2.pivotY = image2.height / 2;
			image2.rotation = 180 * (Math.PI / 180);
			image2.x = 182.5;
			image2.y = 182.5;
			_enemyShip.addChild(image2);
			_enemyShip.x = 700 - 365 / 2; _enemyShip.y = -365 / 2;
			
		}
		
		public function enterShips():void {
			
			var tween1:Tween = new Tween(_myShip, 5, Transitions.EASE_OUT);
			tween1.animate("x", _myShip.x + 365 / 2);
			tween1.animate("y", _myShip.y - 365 / 2);
			Starling.juggler.add(tween1);
			
			var tween2:Tween = new Tween(_enemyShip, 5, Transitions.EASE_OUT);
			tween2.animate("x", _enemyShip.x - 365 / 2);
			tween2.animate("y", _enemyShip.y + 365 / 2);
			Starling.juggler.add(tween2);
			
		}
		
		
		
		//add animated bg
		public function addBackground():void {
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_backgroundImagesArray = new Array();
			
			for(var i:int = 0; i < 5; i++){
				var image:Image = new Image(ResourceManager.getInstance().getTexture("background_" + (i + 1)));
				image.pivotX = image.width / 2;
				image.pivotY = image.height / 2;
				image.rotation = 45 * Math.PI / 180;
				
				_backgroundImagesArray.push(image);
			}
			
			_nextBGImage = _prevBGImage + 1;
			
			_backgroundImagesArray[_prevBGImage].x = 800 / 2;
			_backgroundImagesArray[_prevBGImage].y = 700 / 2;
			_backgroundImagesArray[_nextBGImage].x = 800 / 2 + 750;
			_backgroundImagesArray[_nextBGImage].y = 700 / 2 + 750;
			_bgContainer.addChild(_backgroundImagesArray[_prevBGImage]);
			_bgContainer.addChild(_backgroundImagesArray[_nextBGImage]);
		}
		
		private function onEnterFrame(e:Event):void {
	
			if(_backgroundImagesArray[_nextBGImage].x <= 800 / 2){
				_bgContainer.removeChild(_backgroundImagesArray[_prevBGImage]);
				_prevBGImage = _prevBGImage == 4 ? 0 : _prevBGImage + 1;
				_nextBGImage = _prevBGImage == 4 ? 0 : _prevBGImage + 1;
				_backgroundImagesArray[_nextBGImage].x = 800 / 2 + 750;
				_backgroundImagesArray[_nextBGImage].y = 700 / 2 + 750;
				_bgContainer.addChild(_backgroundImagesArray[_nextBGImage]);
			}

			_backgroundImagesArray[_prevBGImage].x -= BGSPEED;
			_backgroundImagesArray[_prevBGImage].y -= BGSPEED;
			_backgroundImagesArray[_nextBGImage].x -= BGSPEED;
			_backgroundImagesArray[_nextBGImage].y -= BGSPEED;
			
			
			
			
		}
		
		public function getSpriteEntitiesDic():Dictionary {
			return _spriteEntityDic;
		}
		
		private function onTouch(e:TouchEvent):void {
			
			var mcc:MovieClipContainer = MovieClipContainer(e.currentTarget);
			
			var beganTouch:Touch = e.getTouch(DisplayObject(e.currentTarget), TouchPhase.BEGAN);
			var hoverTouch:Touch = e.getTouch(DisplayObject(e.currentTarget), TouchPhase.HOVER);
			
			if(MovieClipContainer(e.currentTarget).skinClass.animationsDic["hover"] == true && mcc.currentLabel != "selected"){
				if(hoverTouch) {
					
					if(_hoveredEntity == null || mcc.id != _hoveredEntity.id) {
						playAnimation(mcc.id, "hover");
						mcc.loop(false);
						_hoveredEntity = mcc;
						_manager.dispatchHandler(mcc.id, "hover");
					}
				}
				else {
					_hoveredEntity = null;
					_manager.dispatchHandler(mcc.id, "hoverEnded");
					mcc.stop();
				}
			}
			
			if(beganTouch) {
				
				if(mcc.skinClass.animationsDic["selected"] == true)
					playAnimation(mcc.id, "selected");
				
				_manager.dispatchHandler(mcc.id, "click");
				
			}
		}
		
		public static function getInstance():Renderer{
			if(!_instance)
				_instance = new Renderer();
			return _instance;
		}
	
	
	
	
	
	
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}