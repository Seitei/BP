package view
{
	import events.ButtonClickedEvent;
	import events.ButtonTriggeredEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	
	import model.ActionButtonVO;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.ExtendedButton;
	import utils.ResourceManager;
	
	public class ActionBar extends Sprite
	{
		
		private var _resetButton:Button;
		private var _myReadyButton:Button;
		private var _gold:int;
		private var _goldIncome:int;
		private var _myHp:int;
		private var _enemyHp:int;
		private var _goldTxt:TextField;
		private var _goldIncomeTxt:TextField;
		private var _plusSeparatorTxt:TextField;
		private var _myHpTxt:TextField;
		private var _enemyHpTxt:TextField;
		private var _time:int;
		private var _timeTxt:TextField;
		private var _turnCountdownTxt:TextField;
		private var _hesReady:Boolean;
		private var _buttonsVector:Vector.<ExtendedButton>;
		
		//entities arrays
		private var _cannonsArray:Array;
		private var _bulletsArray:Array;
		private var _buffsArray:Array;
		private var _shipsArray:Array;
		
		//entities containers
		private var _cannonsContainer:Sprite;
		private var _bulletsContainer:Sprite;
		private var _buffsContainer:Sprite;
		private var _shipsContainer:Sprite;
		
		//content array
		private var _contentArray:Array;
		private var _contentContainersArray:Array;
		
		public function setContent(cannonsArray:Array = null, bulletsArray:Array = null, buffsArray:Array = null, shipsArray:Array = null):void {
			
			_cannonsArray = cannonsArray;
			_bulletsArray = bulletsArray;
			_buffsArray = buffsArray;
			_shipsArray = shipsArray;
			
			if(_cannonsArray != null) { _contentArray.push(_cannonsArray); _cannonsContainer = new Sprite(); _contentContainersArray.push(_cannonsContainer); }
			if(_bulletsArray != null) { _contentArray.push(_bulletsArray); _bulletsContainer = new Sprite(); _contentContainersArray.push(_bulletsContainer); }
			if(_buffsArray != null)   { _contentArray.push(_buffsArray);   _buffsContainer = new Sprite();   _contentContainersArray.push(_buffsContainer);   }
			if(_shipsArray != null)   { _contentArray.push(_shipsArray);   _shipsContainer = new Sprite();   _contentContainersArray.push(_shipsContainer);   }
			
			initContent();
		}
		
		public function get enemyHp():int
		{
			return _enemyHp;
		}

		public function set enemyHp(value:int):void
		{
			_enemyHp = value;
			_enemyHpTxt.text = String(value);
		}

		public function set goldIncome(value:int):void
		{
			_goldIncome = value;
			_goldIncomeTxt.text = String(_goldIncome);
		}

		public function set time(value:int):void
		{
			_time = value;
		}

		public function set gold(value:int):void {
			_gold = value;
			_goldTxt.text = String(_gold);
		}
		
		public function set myHp(value:int):void {
			_myHp = value;
			_myHpTxt.text = String(value);
		}
		
		public function ActionBar() {
			//background
			var texture:Texture;
			texture = ResourceManager.getInstance().getTexture("action_bar_bg");
			var image:Image = new Image(texture);
			addChild(image);
			
			//we store here the buttons, to have acess later when we disable/enable them.
			_buttonsVector = new Vector.<ExtendedButton>;
			
			_contentArray = new Array();
			_contentContainersArray = new Array();
			
			initGold();
			initGoldIncome();
			initMyHp();
			initEnemyHp();
			initPlusSeparator();
			initTurnCountdown();
			initReadyButton();
		}
		
		private function initContent():void {
			
			//cannons
			var globalCounter:int = 0;
			var localCounter:int = 0;
			
			var xpos:int;
			var ypos:int;
			
			var newEntityGroup:Boolean;
			var newEntityCounter:int = 0;
			
			var globalYpos:int;
			
			for each(var entitiesArray:Array in _contentArray){
				
				newEntityGroup = true;	
				localCounter = 0;
				ypos = 0;
				
				//place divisor bar
				var divisorBarImage:Image = new Image(ResourceManager.getInstance().getTexture("action_bar_divisor"));
				_contentContainersArray[newEntityCounter].addChild(divisorBarImage);
				_contentContainersArray[newEntityCounter].y = 81 + globalYpos * 48 + newEntityCounter * 13;
				_contentContainersArray[newEntityCounter].x = 3;
				
				addChild(_contentContainersArray[newEntityCounter]);
				
				for each(var entity:String in entitiesArray){
					var entityBtn:ActionButton = new ActionButton(
						ResourceManager.getInstance().getTexture(entity + "_up_btn"), 
						"addEntity", 
						entity,
						null,
						null,
						"",
						ResourceManager.getInstance().getTexture(entity + "_down_btn"), 
						ResourceManager.getInstance().getTexture(entity + "_hover_btn"),
						ResourceManager.getInstance().getTexture(entity + "_mouse_btn")
					);
					
					
					_buttonsVector.push(entityBtn);
					
					xpos = localCounter % 2 == 0 ? 0 : newEntityGroup == true ? 0 : 48;
					ypos = 13 + Math.floor(localCounter / 2) * 48;
					 
					if(localCounter % 2 == 0) globalYpos ++;
					
					entityBtn.x = xpos;
					entityBtn.y = ypos;
					
					_contentContainersArray[newEntityCounter].addChild(entityBtn);
					entityBtn.addEventListener(ButtonTriggeredEvent.BUTTON_TRIGGERED_EVENT, onEntityButtonTouched);
					
					globalCounter ++;
					localCounter ++;
					newEntityGroup = false;
							
					
				}
				
				newEntityCounter ++;
				
			}
			
			
		}
		
		private function initReadyButton():void {
			var readyButton:ActionButton = new ActionButton(
				ResourceManager.getInstance().getTexture("ready_up_btn"), 
				"ready", 
				"",
				null,
				null,
				"",
				ResourceManager.getInstance().getTexture("ready_down_btn"), 
				ResourceManager.getInstance().getTexture("ready_hover_btn")
			);
			
			readyButton.x = 3;
			readyButton.y = 429;
			addChild(readyButton);
			readyButton.addEventListener(ButtonTriggeredEvent.BUTTON_TRIGGERED_EVENT, onReadyButtonTouched);
			
			_buttonsVector.push(readyButton);
		}
		
		//if its not your turn, the buttons are disabled
		public function enableButtons(bool:Boolean):void {
			for each(var button:ExtendedButton in _buttonsVector){
				button.enabled = bool;
			}
		}
		
		
		private function onReadyButtonTouched(e:ButtonTriggeredEvent):void {
			var ab:ActionButton = ActionButton(e.currentTarget);
			dispatchEvent(new Event("ReadyEvent", true)); 
		}
		
		
		private function onEntityButtonTouched(e:ButtonTriggeredEvent):void {
			
			var ab:ActionButton = ActionButton(e.currentTarget);
			dispatchEvent(new ButtonClickedEvent(ButtonClickedEvent.BUTTON_CLICKED_EVENT, e.clickedPosition, ab.actionType, ab.entityType, ab.mouseCursorTexture ,true)); 
			
		}
		
		
		public function updateUITurnCountdown(count:int):void {
			_turnCountdownTxt.text = String(count);	
		}
		
		public function hideTurnCountdown():void {
			_turnCountdownTxt.text = "";
		}
		
		
		private function initTurnCountdown():void {
			_turnCountdownTxt = new TextField(150, 50, "3", "ObelixPro", 16, 0, false);
			_turnCountdownTxt.x = 3;
			_turnCountdownTxt.y = 200;
			_turnCountdownTxt.color = 0x00ADEE;
			_turnCountdownTxt.text = "";
			_turnCountdownTxt.width = 100;
			addChild(_turnCountdownTxt);
		}
		
		private function initGold():void {
			_goldTxt = new TextField(50, 30, "3", "ObelixPro", 16, 0, false);
			_goldTxt.x = 15;
			_goldTxt.y = 0;
			_goldTxt.color = 0xF9E70E;
			_goldTxt.text = String(_gold);
			addChild(_goldTxt);
		}
		
		private function initGoldIncome():void {
			_goldIncomeTxt = new TextField(50, 30, "", "ObelixPro", 16, 0, false);
			_goldIncomeTxt.x = 50;
			_goldIncomeTxt.color = 0x44D63C;
			_goldIncomeTxt.y = 0;
			_goldIncomeTxt.text = String(_goldIncome);
			addChild(_goldIncomeTxt);
		}

		private function initPlusSeparator():void {
			_plusSeparatorTxt = new TextField(20, 30, "+", "ObelixPro", 14, 0, false);
			_plusSeparatorTxt.x = 50;
			_plusSeparatorTxt.color = 0xFFFFFF;
			_plusSeparatorTxt.y = 0;
			addChild(_plusSeparatorTxt);
		}
		
		private function initMyHp():void {
			_myHpTxt = new TextField(50, 30, "", "ObelixPro", 16, 0, false);
			_myHpTxt.x = 43;
			_myHpTxt.color = 0xE20613;
			_myHpTxt.y = 26;
			_myHpTxt.text = String(_myHp);
			addChild(_myHpTxt);
		}
		
		private function initEnemyHp():void {
			_enemyHpTxt = new TextField(50, 30, "400", "ObelixPro", 16, 0, false);
			_enemyHpTxt.x = 43;
			_enemyHpTxt.color = 0xE20613;
			_enemyHpTxt.y = 52;
			_enemyHpTxt.text = String(_enemyHp);
			addChild(_enemyHpTxt);
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}