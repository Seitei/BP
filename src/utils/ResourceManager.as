package utils
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class ResourceManager
	{
		private static var _instance:ResourceManager;
		
		[Embed(source = "../assets/background.png")]
		private static const Background:Class;
		
		[Embed(source = "../assets/action_bar_bg.png")]
		private static const ActionBarBg:Class;
		
		[Embed(source = "../assets/main_selector_improvements.png")]
		private static const MainSelectorImprovements:Class;
		
		[Embed(source = "../assets/main_selector_units.png")]
		private static const MainSelectorUnits:Class;
		
		[Embed(source = "../assets/main_selector_towers.png")]
		private static const MainSelectorTowers:Class;
		
		[Embed(source = "../assets/sell.png")]
		private static const Sell:Class;
		
		[Embed(source = "../assets/set_rallypoint.png")]
		private static const SetRallypoint:Class;
		
		[Embed(source = "../assets/upgrade.png")]
		private static const Upgrade:Class;
				
		[Embed(source = "../assets/unit.png")]
		private static const Unit:Class;
		
		[Embed(source = "../assets/building_unit.png")]
		private static const buildingUnit:Class;
		
		[Embed(source = "../assets/building_improvement_gold.png")]
		private static const buildingImprovementGold:Class;
		
		[Embed(source = "../assets/building_tower.png")]
		private static const buildingTower:Class;
		
		[Embed(source = "../assets/building_tower_upgrade_damage_1.png")]
		private static const buildingTowerUpgradeDamage1:Class;
		
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

		[Embed(source = "../assets/upgrade_damage_1.png")]
		private static const UpgradeDamage1:Class;
		
		[Embed(source = "../assets/upgrade_armor_1.png")]
		private static const UpgradeArmor1:Class;
		
		[Embed(source = "../assets/spawner1_down_btn.png")]
		private static const Spawner1DownBtn:Class;
		
		[Embed(source = "../assets/spawner1_hover_btn.png")]
		private static const Spawner1HoverBtn:Class;
		
		[Embed(source = "../assets/spawner1_up_btn.png")]
		private static const Spawner1UpBtn:Class;
		
		[Embed(source = "../assets/spawner1_mouse_btn.png")]
		private static const Spawner1MouseBtn:Class;
		
		[Embed(source = "../assets/spawner1.png")]
		private static const Spawner1:Class;
		
		[Embed(source = "../assets/ready_up_btn.png")]
		private static const ReadyUpBtn:Class;
		
		[Embed(source = "../assets/cannon_bullet.png")]
		private static const CannonBullet:Class;

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
			TextureAssets["background"] = Background;
			TextureAssets["action_bar_bg"] = ActionBarBg;
			TextureAssets["set_rallypoint"] = SetRallypoint;
			TextureAssets["unit"] = Unit;
			TextureAssets["building_unit"] = buildingUnit;
			TextureAssets["building_improvement_gold"] = buildingImprovementGold;
			TextureAssets["building_tower"] = buildingTower;
			TextureAssets["building_tower_upgrade_damage_1"] = buildingTowerUpgradeDamage1;
			TextureAssets["main_selector_improvements"] = MainSelectorImprovements;
			TextureAssets["main_selector_units"] = MainSelectorUnits;
			TextureAssets["main_selector_towers"] = MainSelectorTowers;
			TextureAssets["sell"] = Sell;
			TextureAssets["upgrade"] = Upgrade;
			TextureAssets["tile"] = Tile;
			TextureAssets["bg_menu_bar"] = BgMenuBar;
			TextureAssets["ship"] = Ship;
			TextureAssets["timon"] = Timon;
			TextureAssets["building"] = Building;
			TextureAssets["upgrade_damage_1"] = UpgradeDamage1;
			TextureAssets["upgrade_armor_1"] = UpgradeArmor1;
			TextureAssets["spawner1_up_btn"] = Spawner1UpBtn;
			TextureAssets["spawner1_hover_btn"] = Spawner1HoverBtn;
			TextureAssets["spawner1_down_btn"] = Spawner1DownBtn;
			TextureAssets["spawner1_mouse_btn"] = Spawner1MouseBtn;
			TextureAssets["ready_up_btn"] = ReadyUpBtn;
			TextureAssets["spawner1"] = Spawner1;
			TextureAssets["cannon_bullet"] = CannonBullet;
			
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