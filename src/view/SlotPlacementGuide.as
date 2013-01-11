package view
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import starling.display.Sprite;
	
	import utils.ExtendedButton;
	import utils.ResourceManager;
	
	/** This class is used to create a reference when you place cannons, so you can visually determine what is your cannon going to hit **/
	
	public class SlotPlacementGuide extends Sprite
	{
		private var _rowsDic:Dictionary;
		private var _rowsDesc:Array;
		
		public function SlotPlacementGuide()
		{
			_rowsDic = new Dictionary();
			_rowsDesc = ["L5", "L4", "L3", "L2", "L1", "L0", 0, 1, 2, 3, 4, 5, 6, 7, 8, "R0", "R1", "R2", "R3", "R4", "R5"]; 
			
			//init array
			for(var xi:int = 0; xi < 21; xi++) {
				_rowsDic[_rowsDesc[xi]] = new Array();
				for(var xj:int = 0; xj < 11; xj++) {
					_rowsDic[_rowsDesc[xi]][xj] = 0;
				}
			}
			
			var tilesQuant:int = 1;
			
			for(var i:int = 0; i < 21; i++) {
				
				for(var j:int = 0; j < tilesQuant; j++) {
					
					var slot:TileButton = new TileButton(
						ResourceManager.getInstance().getTexture("placement_slot_up"),
						"",
						ResourceManager.getInstance().getTexture("placement_slot_down"),
						ResourceManager.getInstance().getTexture("placement_slot_hover")
					);
					
					
					slot.pivotX = slot.width / 2;
					slot.pivotY = slot.height / 2;
					
					slot.rotation = 45 * Math.PI / 180;

					
					if(i < 6){
						slot.x = (i * 64 - j * 32) + 30;
						slot.y = (j * 32) + 30;
					}
					
					if(i > 5 && i < 16){
						slot.x = (i - 6) * 32 - j * 32 + (6 * 64) - 2;
						slot.y = (i - 5) * 32 + (j * 32) + 30;
					}
					
					if(i > 15){
						slot.x = (700 - 32) - j * 32;
						slot.y = 700 - (4 * 64) + (i - 16) * 64 + j * 32 - 32;
							
					}
					
					addChild(slot);
					_rowsDic[_rowsDesc[i]][j] = slot;
					
				}
				
				if(i < 6) tilesQuant += 2;
				if(i > 5 && i < 16) tilesQuant = 11;
				if(i > 15) tilesQuant -= 2;
				
			}
		
		}

		public function getFirstTile(row:int):ExtendedButton {
			return _rowsDic[row][0];	
		}
		
		//here we tell what row we need to turn on, test purposes
		public function turnOnOrOffRow(row:int, bool:Boolean):void {
			
			for each(var slot:ExtendedButton in _rowsDic[row]) {
				slot.forceDownState(bool);
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}