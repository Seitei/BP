package utils
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class ResourceManager
	{
		private static var _instance:ResourceManager;
		
		[Embed(source = "../assets/background_1.png")]
		private static const Background1:Class;
		
		[Embed(source = "../assets/background_2.png")]
		private static const Background2:Class;
		
		[Embed(source = "../assets/background_3.png")]
		private static const Background3:Class;
		
		[Embed(source = "../assets/background_4.png")]
		private static const Background4:Class;
		
		[Embed(source = "../assets/background_5.png")]
		private static const Background5:Class;
		
		[Embed(source = "../assets/action_bar_bg.png")]
		private static const ActionBarBg:Class;
		
		[Embed(source = "../assets/main_selector_towers.png")]
		private static const MainSelectorTowers:Class;
		
		[Embed(source = "../assets/sell.png")]
		private static const Sell:Class;
		
		[Embed(source = "../assets/set_rallypoint.png")]
		private static const SetRallypoint:Class;
		
		[Embed(source = "../assets/rallypoint.png")]
		private static const Rallypoint:Class;
		
		[Embed(source = "../assets/upgrade.png")]
		private static const Upgrade:Class;
				
		[Embed(source = "../assets/building_improvement_gold.png")]
		private static const buildingImprovementGold:Class;
		
		[Embed(source = "../assets/building_improvement_gold_up_btn.png")]
		private static const buildingImprovementGoldUpBtn:Class;
		
		[Embed(source = "../assets/building_improvement_gold_hover_btn.png")]
		private static const buildingImprovementGoldHoverBtn:Class;
		
		[Embed(source = "../assets/building_improvement_gold_down_btn.png")]
		private static const buildingImprovementGoldDownBtn:Class;
		
		[Embed(source = "../assets/building_improvement_gold_mouse_btn.png")]
		private static const buildingImprovementGoldMouseBtn:Class;
		
		[Embed(source = "../assets/tile.png")]
		private static const Tile:Class;
		
		[Embed(source = "../assets/bg_menu_bar.png")]
		private static const BgMenuBar:Class;

		[Embed(source = "../assets/ship.png")]
		private static const Ship:Class;
		
		[Embed(source = "../assets/timon.png")]
		private static const Timon:Class;
		
		[Embed(source = "../assets/building.png")]
		private static const Building:Class;

		[Embed(source = "../assets/spawner1_down_btn.png")]
		private static const Spawner1DownBtn:Class;
		
		[Embed(source = "../assets/spawner1_hover_btn.png")]
		private static const Spawner1HoverBtn:Class;
		
		[Embed(source = "../assets/spawner1_up_btn.png")]
		private static const Spawner1UpBtn:Class;
		
		[Embed(source = "../assets/spawner1_mouse_btn.png")]
		private static const Spawner1MouseBtn:Class;
		
		[Embed(source = "../assets/spawner2_down_btn.png")]
		private static const Spawner2DownBtn:Class;
		
		[Embed(source = "../assets/spawner2_hover_btn.png")]
		private static const Spawner2HoverBtn:Class;
		
		[Embed(source = "../assets/spawner2_up_btn.png")]
		private static const Spawner2UpBtn:Class;
		
		[Embed(source = "../assets/spawner2_mouse_btn.png")]
		private static const Spawner2MouseBtn:Class;
		
		[Embed(source = "../assets/spawner1.png")]
		private static const Spawner1:Class;
		
		[Embed(source = "../assets/spawner2.png")]
		private static const Spawner2:Class;
		
		[Embed(source = "../assets/ready_up_btn.png")]
		private static const ReadyUpBtn:Class;
		
		[Embed(source = "../assets/ready_down_btn.png")]
		private static const ReadyDownBtn:Class;
		
		[Embed(source = "../assets/ready_hover_btn.png")]
		private static const ReadyHoverBtn:Class;
		
		[Embed(source = "../assets/play_up_btn.png")]
		private static const PlayUpBtn:Class;
		
		[Embed(source = "../assets/play_down_btn.png")]
		private static const PlayDownBtn:Class;
		
		[Embed(source = "../assets/play_hover_btn.png")]
		private static const PlayHoverBtn:Class;
		
		[Embed(source = "../assets/cannon_bullet.png")]
		private static const CannonBullet:Class;
		
		[Embed(source = "../assets/placement_slot_up.png")]
		private static const PlacementSlotUp:Class;
		
		[Embed(source = "../assets/placement_slot_down.png")]
		private static const PlacementSlotDown:Class;
		
		[Embed(source = "../assets/placement_slot_hover.png")]
		private static const PlacementSlotHover:Class;
		
		[Embed(source = "../assets/planning_bg.png")]
		private static const PlanningBG:Class;
		
		[Embed(source = "../assets/arrow.png")]
		private static const Arrow:Class;
		
		[Embed(source = "../assets/period.png")]
		private static const Period:Class;
		
		[Embed(source = "../assets/waiting_for_players.png")]
		private static const WaitingForPlayers:Class;

		// XML //
		
		[Embed(source="../assets/unit.xml", mimeType="application/octet-stream")]
		public static const BasicUnitXML:Class;
		
		[Embed(source="../assets/tile.xml", mimeType="application/octet-stream")]
		public static const TileXML:Class;
		
		[Embed(source="../assets/building.xml", mimeType="application/octet-stream")]
		public static const BuildingXML:Class;
		
		[Embed(source="../assets/cannon_bullet.xml", mimeType="application/octet-stream")]
		public static const CannonBulletXML:Class;
		
		private var TextureAssets:Dictionary = new Dictionary();
		private var XMLAssets:Dictionary = new Dictionary();
		private var _textures:Dictionary = new Dictionary();
		private var _xmls:Dictionary = new Dictionary();
		
		public function ResourceManager()
		{
			TextureAssets["background_1"] = Background1;
			TextureAssets["background_2"] = Background2;
			TextureAssets["background_3"] = Background3;
			TextureAssets["background_4"] = Background4;
			TextureAssets["background_5"] = Background5;
			TextureAssets["action_bar_bg"] = ActionBarBg;
			TextureAssets["set_rallypoint"] = SetRallypoint;
			TextureAssets["rallypoint"] = Rallypoint;
			TextureAssets["main_selector_towers"] = MainSelectorTowers;
			TextureAssets["sell"] = Sell;
			TextureAssets["upgrade"] = Upgrade;
			TextureAssets["tile"] = Tile;
			TextureAssets["bg_menu_bar"] = BgMenuBar;
			TextureAssets["ship"] = Ship;
			TextureAssets["timon"] = Timon;
			TextureAssets["building"] = Building;
			TextureAssets["spawner1_up_btn"] = Spawner1UpBtn;
			TextureAssets["spawner1_hover_btn"] = Spawner1HoverBtn;
			TextureAssets["spawner1_down_btn"] = Spawner1DownBtn;
			TextureAssets["spawner1_mouse_btn"] = Spawner1MouseBtn;
			TextureAssets["spawner2_up_btn"] = Spawner2UpBtn;
			TextureAssets["spawner2_hover_btn"] = Spawner2HoverBtn;
			TextureAssets["spawner2_down_btn"] = Spawner2DownBtn;
			TextureAssets["spawner2_mouse_btn"] = Spawner2MouseBtn;
			TextureAssets["building_improvement_gold"] = buildingImprovementGold;
			TextureAssets["building_improvement_gold_up_btn"] = buildingImprovementGoldUpBtn;
			TextureAssets["building_improvement_gold_hover_btn"] = buildingImprovementGoldHoverBtn;
			TextureAssets["building_improvement_gold_down_btn"] = buildingImprovementGoldDownBtn;
			TextureAssets["building_improvement_gold_mouse_btn"] = buildingImprovementGoldMouseBtn;
			TextureAssets["ready_up_btn"] = ReadyUpBtn;
			TextureAssets["ready_down_btn"] = ReadyDownBtn;
			TextureAssets["ready_hover_btn"] = ReadyHoverBtn;
			TextureAssets["play_up_btn"] = PlayUpBtn;
			TextureAssets["play_down_btn"] = PlayDownBtn;
			TextureAssets["play_hover_btn"] = PlayHoverBtn;
			TextureAssets["spawner1"] = Spawner1;
			TextureAssets["spawner2"] = Spawner2;
			TextureAssets["cannon_bullet"] = CannonBullet;
			TextureAssets["placement_slot_up"] = PlacementSlotUp;
			TextureAssets["placement_slot_down"] = PlacementSlotDown;
			TextureAssets["placement_slot_hover"] = PlacementSlotHover;
			TextureAssets["planning_bg"] = PlanningBG;
			TextureAssets["arrow"] = Arrow;
			TextureAssets["waiting_for_players"] = WaitingForPlayers;
			TextureAssets["period"] = Period;
			
			// XMLS
			XMLAssets["unit"] = BasicUnitXML;
			XMLAssets["cannon_bullet"] = CannonBulletXML;
			XMLAssets["tile"] = TileXML;
			XMLAssets["building"] = BuildingXML;
			
		}
		
		public function getTextures(name:String, prefix:String = "", animate:Boolean = true):Vector.<Texture> {
			
			if (TextureAssets[name] != undefined)
			{
				if (_textures[name + "." + prefix] == undefined)
				{
					var bitmap:Bitmap = new TextureAssets[name];
					var texture:Texture = _textures[name] = Texture.fromBitmap(bitmap);
					var frames:Vector.<Texture> = new Vector.<Texture>();
					
					var xml:XML = XML(new XMLAssets[name]);
					var textureAtlas:TextureAtlas = new TextureAtlas(texture, xml);
					frames = textureAtlas.getTextures(prefix);
					_textures[name + "." + prefix] = frames;
					
				}
			}
			else
				throw new Error("Resource not defined!");
			
			return _textures[name + "." + prefix];
		}
		
		public function getTexture(name:String):Texture
		{
			if (TextureAssets[name] != undefined)
			{
				if (_textures[name] == undefined)
				{
					var bitmap:Bitmap = new TextureAssets[name]();
					_textures[name] = Texture.fromBitmap(bitmap);
				}
				return _textures[name];
			} 
			else throw new Error("Resource not defined.");
		}
		
		public static function getInstance():ResourceManager {
			if (!_instance)
				_instance = new ResourceManager();
			return _instance
		}
	}
	
	
	
	
	
	
	
	
	
	
}