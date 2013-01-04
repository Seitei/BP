package view
{
	import Signals.BroadcastSignal;
	import Signals.EntityClickedSignal;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import interfaces.IBuildeable;
	
	import managers.Manager;
	
	import model.EntityVO;
	
	import starling.animation.Juggler;
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
		
		private static var _instance:Renderer;
		private var _manager:Manager;
		private var _spriteEntityDic:Dictionary;
		private var _playerName:String;
		private var _stateChangeRelatedAnimationsDic:Dictionary;
		private var _hoveredEntity:MovieClipContainer;
		
		public function Renderer()
		{
			_spriteEntityDic = new Dictionary();
			_stateChangeRelatedAnimationsDic = new Dictionary();
			_manager= Manager.getInstance();
			_playerName = _manager.getPlayerName();
		}
		
		public function renderObject(entity:EntityVO):void {
			
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
			
			if(entity.rotation)
				mcc.rotation = entity.rotation; 
			
			addChild(mcc);
			
			mcc.pivotX = mcc.width/2; mcc.pivotY = mcc.height/2;
			_spriteEntityDic[entity.id] = mcc;
			
			if(entity.owner == _playerName) {
				mcc.addEventListener(TouchEvent.TOUCH, onTouch);
				mcc.useHandCursor = true;
			}
			
			if(entity.status == UnitStatus.BUILDING) {
				var frames2:Vector.<Texture> = ResourceManager.getInstance().getTextures("building");
				var mc3:MovieClip = new MovieClip(frames2, (IBuildeable(entity).constructionTime)/60);
				mcc.addMovieClip(mc3, "building", true, true);
				mcc.loop(false);
				_stateChangeRelatedAnimationsDic[entity.id] = entity.id;
			}
			
			mcc.setCurrentMovieClip(mcc.skinClass.originalMcc);
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
						mcc.loop(false);
						playAnimation(mcc.id, "hover");
						_hoveredEntity = mcc;trace("hoooovvveeer");
						_manager.dispatchHandler(mcc.id);
					}
				}
				else {
					mcc.stop();
				}
			}
			
			if(beganTouch) {
				
				if(mcc.skinClass.animationsDic["selected"] == true)
					playAnimation(mcc.id, "selected");
				
				_manager.dispatchHandler(mcc.id);
				
			}
		}
		
		public static function getInstance():Renderer{
			if(!_instance)
				_instance = new Renderer();
			return _instance;
		}
	
	
	
	
	
	
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}