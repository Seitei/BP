package utils
{
	public class GameStatus
	{
		public static const INIT:int = 0;
		public static const STOPPED:int = 1;
		public static const COUNTDOWN_STOPPED:int = 2;
		public static const PLAYING:int = 3;
		public static const COUNTDOWN_PLAYING:int = 4;
		
		public static var textStatusArray:Array = new Array();
		public static var statusArray:Array = new Array();
		
		statusArray[0] = INIT;
		statusArray[1] = STOPPED;
		statusArray[2] = COUNTDOWN_STOPPED;
		statusArray[3] = PLAYING;
		statusArray[4] = COUNTDOWN_PLAYING;
		
		textStatusArray[0] = "INIT";
		textStatusArray[1] = "STOPPED";
		textStatusArray[2] = "COUNTDOWN_STOPPED";
		textStatusArray[3] = "PLAYING";
		textStatusArray[4] = "COUNTDOWN_PLAYING";
		
		public static function nextState(state:int):int {
			if(state == statusArray.length - 1)
				return statusArray[1];
			else
				return statusArray[state + 1];
		}
	}
	
	
}