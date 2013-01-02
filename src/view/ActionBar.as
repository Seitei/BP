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
		private var _hp:int;
		private var _goldTxt:TextField;
		private var _goldIncomeTxt:TextField;
		private var _plusSeparatorTxt:TextField;
		private var _hpTxt:TextField;
		private var _time:int;
		private var _timeTxt:TextField;
		private var _turnCountdownTxt:TextField;
		private var _hesReady:Boolean;
		private var _buttonsVector:Vector.<ExtendedButton>;
		
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
		
		public function set hp(value:int):void {
			_hp = value;
			_hpTxt.text = String(value);
		}
		
		public function ActionBar() {
			//background
			var texture:Texture;
			texture = ResourceManager.getInstance().getTexture("action_bar_bg");
			var image:Image = new Image(texture);
			addChild(image);
			
			//we store here the buttons, to have acess later when we disable/enable them.
			_buttonsVector = new Vector.<ExtendedButton>;
			
			initGold();
			initGoldIncome();
			initHp();
			initPlusSeparator();
			initTurnCountdown();
			initReadyButton();
			
			//entities
			
			initCannonButton();
			
			//enableButtons(false);
		}
		
		private function initCannonButton():void {
			
			var spawner1Btn:ActionButton = new ActionButton(
				ResourceManager.getInstance().getTexture("spawner1_up_btn"), 
				"addEntity", 
				"spawner1",
				null,
				null,
				"",
				ResourceManager.getInstance().getTexture("spawner1_down_btn"), 
				ResourceManager.getInstance().getTexture("spawner1_hover_btn"),
				ResourceManager.getInstance().getTexture("spawner1_mouse_btn")
			);
			
			spawner1Btn.x = 3;
			spawner1Btn.y = 81;
			addChild(spawner1Btn);
			spawner1Btn.addEventListener(ButtonTriggeredEvent.BUTTON_TRIGGERED_EVENT, onEntityButtonTouched);

			_buttonsVector.push(spawner1Btn);
		}
	
		/*public function updateReadyButton(state:String):void {
			_hesReady = true;
			_myReadyButton.upState = ResourceManager.getInstance().getTexture("button_ready_" + state);
		}*/
		
		private function initReadyButton():void {
			var readyButton:ActionButton = new ActionButton(
				ResourceManager.getInstance().getTexture("ready_up_btn"), 
				"ready", 
				"",
				null,
				null,
				"",
				ResourceManager.getInstance().getTexture("ready_up_btn"), 
				ResourceManager.getInstance().getTexture("ready_up_btn"),
				ResourceManager.getInstance().getTexture("ready_up_btn")
			);
			
			readyButton.x = 3;
			readyButton.y = 129;
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
			_turnCountdownTxt.x = 630;
			_turnCountdownTxt.color = 0x00ADEE;
			_turnCountdownTxt.y = -12;
			_turnCountdownTxt.text = "";
			_turnCountdownTxt.width = 100;
			addChild(_turnCountdownTxt);
		}
		
		private function initGold():void {
			_goldTxt = new TextField(150, 50, "3", "ObelixPro", 16, 0, false);
			_goldTxt.x = 160;
			_goldTxt.color = 0xF9E70E;
			_goldTxt.y = -12;
			_goldTxt.text = String(_gold);
			_goldTxt.width = 100;
			addChild(_goldTxt);
		}
		
		private function initPlusSeparator():void {
			_plusSeparatorTxt = new TextField(150, 50, "3", "ObelixPro", 14, 0, false);
			_plusSeparatorTxt.x = 180;
			_plusSeparatorTxt.color = 0xFFFFFF;
			_plusSeparatorTxt.y = -12;
			_plusSeparatorTxt.text = "+";
			_plusSeparatorTxt.width = 100;
			addChild(_plusSeparatorTxt);
		}
		
		private function initGoldIncome():void {
			_goldIncomeTxt = new TextField(150, 50, "3", "ObelixPro", 16, 0, false);
			_goldIncomeTxt.x = 200;
			_goldIncomeTxt.color = 0x44D63C;
			_goldIncomeTxt.y = -12;
			_goldIncomeTxt.text = String(_goldIncome);
			_goldIncomeTxt.width = 100;
			addChild(_goldIncomeTxt);
		}
		
		private function initHp():void {
			_hpTxt = new TextField(150, 50, "3", "ObelixPro", 16, 0, false);
			_hpTxt.x = 50;
			_hpTxt.color = 0xE20613;
			_hpTxt.y = -12;
			_hpTxt.text = "";
			_hpTxt.width = 100;
			addChild(_hpTxt);
		}
		
		public function resetReadyButtons():void {
			_hesReady = false;
			_myReadyButton.upState = ResourceManager.getInstance().getTexture("button_ready_0_0");
			_myReadyButton.touchable = true;
		}
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}