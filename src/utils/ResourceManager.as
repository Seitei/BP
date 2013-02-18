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
		
		[Embed(source = "../assets/ship.png")]
		private static const Ship:Class;
		
		[Embed(source = "../assets/timon.png")]
		private static const Timon:Class;
		
		[Embed(source = "../assets/entities/good_old_cannon/good_old_cannon.png")]
		private static const GoodOldCannon:Class;
		
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
		
		[Embed(source = "../assets/bar.png")]
		private static const Bar:Class;
		
		[Embed(source = "../assets/body_bg.png")]
		private static const BodyBg:Class;
		
		[Embed(source = "../assets/action_bar_divisor.png")]
		private static const ActionBarDivisor:Class;
		
		[Embed(source = "../assets/visor_bg.png")]
		private static const VisorBg:Class;
		
		[Embed(source = "../assets/bullet_place_holder.png")]
		private static const BulletPlaceHolder:Class;
		
		[Embed(source = "../assets/entities/bullet/bullet.png")]
		private static const Bullet:Class;
		
		// XML //
		
		[Embed(source="../assets/unit.xml", mimeType="application/octet-stream")]
		public static const BasicUnitXML:Class;
		
		[Embed(source="../assets/tile.xml", mimeType="application/octet-stream")]
		public static const TileXML:Class;
		
		[Embed(source="../assets/entities/bullet/bullet.xml", mimeType="application/octet-stream")]
		public static const BulletXML:Class;
		
		[Embed(source="../assets/entities/good_old_cannon/good_old_cannon.xml", mimeType="application/octet-stream")]
		public static const GoodOldCannonXML:Class;
		
		////////////////////////////////////////////////////////////////////////////////////
		
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
			TextureAssets["sell"] = Sell;
			TextureAssets["upgrade"] = Upgrade;
			TextureAssets["tile"] = Tile;
			TextureAssets["ship"] = Ship;
			TextureAssets["timon"] = Timon;
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
			TextureAssets["cannon"] = Bullet;
			TextureAssets["placement_slot_up"] = PlacementSlotUp;
			TextureAssets["placement_slot_down"] = PlacementSlotDown;
			TextureAssets["placement_slot_hover"] = PlacementSlotHover;
			TextureAssets["planning_bg"] = PlanningBG;
			TextureAssets["arrow"] = Arrow;
			TextureAssets["waiting_for_players"] = WaitingForPlayers;
			TextureAssets["period"] = Period;
			TextureAssets["bar"] = Bar;
			TextureAssets["body_bg"] = BodyBg;
			TextureAssets["action_bar_divisor"] = ActionBarDivisor;
			TextureAssets["visor_bg"] = VisorBg;
			TextureAssets["bullet_place_holder"] = BulletPlaceHolder;
			TextureAssets["bullet"] = Bullet;
			TextureAssets["good_old_cannon"] = GoodOldCannon;
			
			// XMLS
			XMLAssets["unit"] = BasicUnitXML;
			XMLAssets["bullet"] = BulletXML;
			XMLAssets["tile"] = TileXML;
			XMLAssets["good_old_cannon"] = GoodOldCannonXML;
			
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
		
		public function getTexture(name:String, prefix:String = ""):Texture
		{
			if (TextureAssets[name] != undefined)
			{
				if(prefix == ""){
					if (_textures[name] == undefined)
					{
						var bitmap:Bitmap = new TextureAssets[name]();
						_textures[name] = Texture.fromBitmap(bitmap);
					}
					return _textures[name];
				} 
				else {
					if (_textures[name + "." + prefix] == undefined)
					{
						var bitmap2:Bitmap = new TextureAssets[name];
						var texture:Texture = _textures[name] = Texture.fromBitmap(bitmap2);
						var frames:Vector.<Texture> = new Vector.<Texture>();
						
						var xml:XML = XML(new XMLAssets[name]);
						var textureAtlas:TextureAtlas = new TextureAtlas(texture, xml);
						frames = textureAtlas.getTextures(prefix);
						_textures[name + "." + prefix] = frames[0];
					}
					return _textures[name + "." + prefix];
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