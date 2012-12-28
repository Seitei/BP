package buffs
{
	import interfaces.IBuff;

	public class GoldBuff implements IBuff
	{
		private var _buffType:String;
		private var _buffStats:int;
		private var _targetType:String;
		private var _targetRange:int;
		
		public function GoldBuff(buffType:String, buffStats:int, targetType:String, targetRange:int = 0)
		{
			_buffType = buffType;
			_buffStats = buffStats;
			_targetType = targetType;
			_targetRange = targetRange;
		}
		
	
		public function set buffStats(value:int):void
		{
			_buffStats = value; 
		}
		
		public function get buffStats():int
		{
			return _buffStats;
		}
		
		public function set buffType(value:String):void
		{
			_buffType = value;
		}
		
		public function get buffType():String
		{
			return _buffType;
		}
		
		public function set targetRange(value:int):void
		{
			_targetRange = value;
		}
		
		public function get targetRange():int
		{
			return _targetRange;
		}
		
		public function set targetType(value:String):void
		{
			_targetType = value;
		}
		
		public function get targetType():String
		{
			return _targetType;
		}
		
	}
}