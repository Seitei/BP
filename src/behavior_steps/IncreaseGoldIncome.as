package behavior_steps
{
	import actions.Action;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import interfaces.IBehavior;
	
	import managers.GameManager;
	import managers.Manager;
	
	import model.EntityFactoryVO;
	import model.EntityVO;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	import utils.Movement;
	import utils.MovieClipContainer;

	public class IncreaseGoldIncome implements IBehavior
	{
		private var _entity:EntityVO;
		private var _timePassed:int;
		private var _req:String = "";
		private var _loopable:Boolean = false;
		private var _executeNow:Boolean = true;
		private var _when:String = "place";
		private var _goldIncomeBuff:int;
		
		public function IncreaseGoldIncome(...params){
			_goldIncomeBuff = params[0];
		}
		
		public function get when():String
		{
			return _when;
		}
		
		public function set when(value:String):void
		{
			_when = value;
		}
		
		public function get executeNow():Boolean
		{
			return _executeNow;
		}

		public function set executeNow(value:Boolean):void
		{
			_executeNow = value;
		}

		public function execute(entity:EntityVO, reqs:* = null):void {
			//we update the player gold income	
			Manager.getInstance().goldIncome += _goldIncomeBuff;	
		}
		
		public function get req():String
		{
			return _req;
		}
		
		public function set req(value:String):void
		{
			_req = value;
		}

		public function get loopable():Boolean
		{
			return _loopable;
		}
		
		public function set loopable(value:Boolean):void
		{
			_loopable = value;
		}
			
			
			
		
		
		
		
	}
}