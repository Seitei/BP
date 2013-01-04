package view
{
	import flash.geom.Point;
	
	import starling.display.Sprite;
	
	import utils.ExtendedButton;
	import utils.ResourceManager;
	
	/** This class is used to create a reference when you place cannons, so you can visually determine what is your cannon going to hit **/
	
	public class SlotPlacementGuide extends Sprite
	{
		private var _rowsArray:Array;
		
		public function SlotPlacementGuide()
		{
			_rowsArray = new Array();
			
			//init array
			for(var xi:int = 0; xi < 11; xi++) {
				_rowsArray[xi] = new Array();
				for(var xj:int = 0; xj < 9; xj++) {
					_rowsArray[xi][xj] = 0;
				}
			}
			
			for(var i:int = 0; i < 11; i++) {
				
				for(var j:int = 0; j < 9; j++) {
					
					
					var slot:ExtendedButton = new ExtendedButton(
						ResourceManager.getInstance().getTexture("placement_slot_up"),
						"",
						ResourceManager.getInstance().getTexture("placement_slot_down"),
						ResourceManager.getInstance().getTexture("placement_slot_hover")
					);
					
					slot.x = (j * (30 + 2))  + 380 - (i * 32);
					slot.y = (j * (30 + 2))  + i * 32 + 35;
						
					slot.rotation = 45 * Math.PI / 180;
					addChild(slot);
					
					_rowsArray[j][i] = slot;
					
				}
			}
		
		}

		
		//here we tell what row we need to turn on
		public function turnOnOrOffRow(row:int, bool:Boolean):void {
			for each(var slot:ExtendedButton in _rowsArray[row]) {
				slot.forceDownState(bool);
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}