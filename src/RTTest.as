package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	import starling.utils.Color;
	
	import utils.ResourceManager;
	
	public class RTTest extends Sprite 
	{
		private var _rt:RenderTexture;
		private var _quad:Quad;
		private var _rtImage:Image;
		private var _quadsArray:Array;
		private var _prevX:Number;
		private var _prevY:Number;
		
		public function RTTest()
		{
			
			var quadBg:Quad = new Quad(700, 700, 0x1d1d1d);
			addChild(quadBg);
			
			_quadsArray = new Array();
			
			for(var i:int = 0; i < 10; i++){
				var quad:Quad = new Quad(5, 5);
				quad.alpha = 0.9 - i * 0.1;
				_quadsArray.push(quad);
			}
			
			_rt = new RenderTexture(700, 700);
			_rtImage = new Image(_rt);
			
			addChild(_rtImage);
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function onTouch(e:TouchEvent):void {
			var touch:Touch = e.touches[0];
			
			if(touch.phase == TouchPhase.MOVED){
				
				_quadsArray[0].x = touch.globalX;
				_quadsArray[0].y = touch.globalY;
				_rt.draw(_quadsArray[0]);
				
				createFadeEffect(touch.globalX, touch.globalY);
				
			}
		}
	
		private function createFadeEffect(x:Number, y:Number):void {
			
			var eraseQuad:Quad = new Quad(5, 5);
			eraseQuad.blendMode = BlendMode.ERASE; 
			var dx:Number = x - _prevX;
			var dy:Number = y - _prevY;
			
			var rot:Number = - Math.atan2(dx, dy);
			eraseQuad.rotation = rot;
			eraseQuad.scaleY = Math.sqrt(dx*dx+dy*dy)/4;
			eraseQuad.x = ( x + _prevX )/2;
			eraseQuad.y = ( y + _prevY )/2;
			
			var timer:Timer = new Timer(20, 10);
			timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
				
				_rt.draw(eraseQuad);
				_quadsArray[e.currentTarget.currentCount - 1].x = ( x + _prevX )/2;
				_quadsArray[e.currentTarget.currentCount - 1].y = ( y + _prevY )/2;
				_quadsArray[e.currentTarget.currentCount - 1].rotation = rot;
				_quadsArray[e.currentTarget.currentCount - 1].scaleY = Math.sqrt(dx*dx+dy*dy)/4; 
				
				_rt.draw(_quadsArray[e.currentTarget.currentCount - 1]);
			}
			
			);
			
			
			timer.start();
		
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}