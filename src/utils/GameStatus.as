package utils
{
	public class GameStatus
	{
		public static const STOPPED:int = 0;
		public static const COUNTDOWN_STOPPED:int = 1;
		public static const PLAYING:int = 2;
		public static const COUNTDOWN_PLAYING:int = 3;
		
		public static var statusArray:Array = new Array();
		
		statusArray[0] = STOPPED;
		statusArray[1] = COUNTDOWN_STOPPED;
		statusArray[2] = PLAYING;
		statusArray[3] = COUNTDOWN_PLAYING;
		
		public static var textStatusArray:Array = new Array();
		
		textStatusArray[0] = "STOPPED";
		textStatusArray[1] = "COUNTDOWN_STOPPED";
		textStatusArray[2] = "PLAYING";
		textStatusArray[3] = "COUNTDOWN_PLAYING";
		
		public static function nextState(state:int):int {
			if(state == statusArray.length - 1)
				return statusArray[0];
			else
				return statusArray[state + 1];
		}
	}
	
	
}