package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import starling.core.Starling;
	[SWF(width="800", height="700", frameRate="120", backgroundColor="#1d1d1d")]
	public class Startup extends Sprite
	{
		private var mStarling:Starling;
		public function Startup()
		{
			// stats class for fps
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// create our Starling instance
			mStarling = new Starling(Main, stage);
			// set anti-aliasing (higher the better quality but slower performance)
			mStarling.antiAliasing = 1;
			// start it!
			mStarling.start();
		}
	}
}