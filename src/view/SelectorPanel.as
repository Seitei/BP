package view
{
	import Signals.BroadcastSignal;
	
	import actions.Action;
	
	import events.SelectorPanelEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.registerClassAlias;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import managers.GameManager;
	import managers.Manager;
	
	import model.ActionButtonVO;
	import model.EntityFactoryVO;
	import model.EntityVO;
	
	import org.osflash.signals.natives.INativeDispatcher;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.extensions.ClippedSprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.ResourceManager;
	
	public class SelectorPanel extends Sprite
	{
		private var _broadcastSignal:BroadcastSignal;
		private var _statusNetTxt:TextField;
		private var _state:String = "STOPPED";
		private var _actionButtonsVO:Vector.<ActionButtonVO>;
		private var _clickedEntity:EntityVO;
		private var _point:Point;
		private static const TO_THE_RIGHT:int = 1;
		private static const TO_THE_LEFT:int = -1;
		private static const TOP:int = -1;
		private static const BOT:int = 1;
		private var _timonSprite:ClippedSprite;
		//timon slots
		private var _slot1:Sprite;
		private var _slot2:Sprite;
		private var _slot3:Sprite;
		private var _slot4:Sprite;
		private var _slot5:Sprite;
		private var _slot6:Sprite;
		private var _masterSlotsArray:Array;
		private var _slotsArrayOne:Array;
		private var _slotsArrayTwo:Array;
		private var _rotationState:int;
		private var _actionButtonsVOArray:Array;
		
		public function SelectorPanel(actionButtonsVO:Vector.<ActionButtonVO>, position:Point)
		{
			_actionButtonsVO = actionButtonsVO;
			_rotationState = 0;
			_actionButtonsVOArray = new Array();
			
			//timon
			_timonSprite = new ClippedSprite();
			var image:Image = new Image(ResourceManager.getInstance().getTexture("timon"));
			_timonSprite.addChild(image); 
			_timonSprite.pivotX = _timonSprite.width / 2; _timonSprite.pivotY = _timonSprite.height / 2;  
			
			addChild(_timonSprite);
			
			_timonSprite.clipRect = new Rectangle(position.x - 100, position.y - 110, 200, 110);
			
			//timon slots
			_masterSlotsArray = new Array();
			_slotsArrayOne = new Array();
			_slotsArrayTwo = new Array();
			_masterSlotsArray = [_slotsArrayOne, _slotsArrayTwo];
			
			//place new action buttons
			placeNewActionButtons(_actionButtonsVO, TOP);
			
		}
		
		private function placeNewActionButtons(actionButtonsVO:Vector.<ActionButtonVO>, side:int):void {
			createSlotSprites(actionButtonsVO.length);
			placeTimonSlots(actionButtonsVO.length, side);
			placeActionButtons(actionButtonsVO);
		}
		
		private function createSlotSprites(quantity:int):void {
			for (var i:int = 0; i < quantity; i ++){
				var slot:Sprite = new Sprite();
				slot.x = _timonSprite.width / 2; slot.y = _timonSprite.height / 2;
				_masterSlotsArray[_rotationState].push(slot);
				_timonSprite.addChild(slot);
			}
		}
		
		private function placeTimonSlots(quantity:int, side:int):void {
			
			
			//position configuration
			var radius:int = _timonSprite.width / 2 - 25;
			
			switch (quantity) {
				//1 slot
				case 1:
					_masterSlotsArray[_rotationState][0].x += 0;
					_masterSlotsArray[_rotationState][0].y += radius * side;
					break;
				//2 slots
				case 2:
					_masterSlotsArray[_rotationState][0].x += radius * Math.cos(60 * (Math.PI / 180));
					_masterSlotsArray[_rotationState][0].y += radius * Math.sin(60 * (Math.PI / 180)) * side;
					_masterSlotsArray[_rotationState][1].x += radius * Math.cos(120 * (Math.PI / 180)) ;
					_masterSlotsArray[_rotationState][1].y += radius * Math.sin(120 * (Math.PI / 180)) * side;
					break;
				//3 slots
				case 3:
					_masterSlotsArray[_rotationState][0].x += radius * Math.cos(37 * (Math.PI / 180));
					_masterSlotsArray[_rotationState][0].y += radius * Math.sin(37 * (Math.PI / 180)) * side;
					_masterSlotsArray[_rotationState][1].x += radius * Math.cos(90 * (Math.PI / 180));
					_masterSlotsArray[_rotationState][1].y += radius * Math.sin(90 * (Math.PI / 180)) * side;
					_masterSlotsArray[_rotationState][2].x += radius * Math.cos(140 * (Math.PI / 180));
					_masterSlotsArray[_rotationState][2].y += radius * Math.sin(140 * (Math.PI / 180)) * side;
					break;
				//4 slots
				case 4:
					_masterSlotsArray[_rotationState][0].x += radius * Math.cos(20 * (Math.PI / 180));
					_masterSlotsArray[_rotationState][0].y += radius * Math.sin(20 * (Math.PI / 180)) * side;
					_masterSlotsArray[_rotationState][1].x += radius * Math.cos(63 * (Math.PI / 180));
					_masterSlotsArray[_rotationState][1].y += radius * Math.sin(63 * (Math.PI / 180)) * side;
					_masterSlotsArray[_rotationState][2].x += radius * Math.cos(113 * (Math.PI / 180));
					_masterSlotsArray[_rotationState][2].y += radius * Math.sin(113 * (Math.PI / 180)) * side;
					_masterSlotsArray[_rotationState][3].x += radius * Math.cos(160 * (Math.PI / 180));
					_masterSlotsArray[_rotationState][3].y += radius * Math.sin(160 * (Math.PI / 180)) * side;
					break;
				//TODO more than 4 slots required
			}
			
		}
		
		private function placeActionButtons(actionButtons:Vector.<ActionButtonVO>, depth:int = 0):void {
			
			var counter:int = 0;
			_actionButtonsVOArray.push(actionButtons);
			
			for each(var ab:ActionButtonVO in actionButtons) {
				var actionButton:ActionButton = new ActionButton(ResourceManager.getInstance().getTexture(ab.name), ab.actionType, ab.entityType, null, ab.actionButtons); 
				actionButton.addEventListener(TouchEvent.TOUCH, onTouch);
				actionButton.pivotX = actionButton.width / 2; actionButton.pivotY = actionButton.height / 2; 
				_masterSlotsArray[_rotationState][counter].addChild(actionButton);
				counter ++;
			}
		}
		
		private function resetSlots():void {
			for each(var slot:Sprite in _masterSlotsArray[_rotationState ^ 1]) {
				slot.removeChildren(0, -1, true);
			}
		}
		
		
		
		
		private function onTouch(e:TouchEvent):void {
			
			var touch:Touch = e.touches[0];

			if(touch.phase == "began") {
				//if the ActionButton has more ActionButtons inside, show them
				if(ActionButton(e.currentTarget).actionType == "container") {
					_rotationState = _rotationState ^ 1;
					placeNewActionButtons(ActionButton(e.currentTarget).actionButtons, BOT);
					rotateTimon(180, TO_THE_LEFT);			
				}
				else {
					dispatchEvent(new SelectorPanelEvent(SelectorPanelEvent.SELECTOR_PANEL_EVENT, ActionButton(e.currentTarget).actionType, ActionButton(e.currentTarget).entityType, true));
				}
				
				
			}
		}
		
		private function rotateTimon(angle:Number, direction:int):void {
			
			var ROTATION_TIME:Number = 0.5;
			
			var timonTween:Tween = new Tween(_timonSprite, ROTATION_TIME, Transitions.EASE_IN_OUT);
			timonTween.animate("rotation", angle * (Math.PI / 180) * direction);
			Starling.juggler.add(timonTween);
			timonTween.onComplete = onTweenComplete;
			
			//counter rotation of action buttons
			for each(var slot1:Sprite in _masterSlotsArray[0]) {
				var slotTween1:Tween = new Tween(slot1, ROTATION_TIME, Transitions.EASE_IN_OUT);
				slotTween1.animate("rotation", angle * (Math.PI / 180) * -direction);
				Starling.juggler.add(slotTween1); 
			}
			
			for each(var slot2:Sprite in _masterSlotsArray[1]) {
				var slotTween2:Tween = new Tween(slot2, ROTATION_TIME, Transitions.EASE_IN_OUT);
				slotTween2.animate("rotation", angle * (Math.PI / 180) * -direction);
				Starling.juggler.add(slotTween2); 
			}
		}
		
		private function onTweenComplete():void {
			resetSlots();
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}