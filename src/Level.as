package  {
	import flash.geom.Point;
	import starling.textures.RenderTexture;
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Level {
		
		public const TILE_STATIC_FLOOR_STRING:String = "-";
		public const TILE_STATIC_WALL_STRING:String = "#";
		public const TILE_STATIC_HOLE_STRING:String = "_";
		public const TILE_STATIC_CRUMBLE_STRING:String = "C";
		
		public const ENTITY_P1:String = "p1";
		public const ENTITY_P2:String = "p2";
		
		public const ENTITY_JITTERY:String = "jittery";
		public const ENTITY_SELF_CONFIDENT:String = "self-confident";
		public const ENTITY_ANGRY:String = "angry";
		public const ENTITY_HAPPY:String = "happy";
		public const ENTITY_CALM:String = "calm";
		
		public const ENTITY_STONE:String = "stone";
		public const ENTITY_MINE:String = "mine";
		
		public const LINE_SEPARATOR:String = "\r\n";
		public const TOKEN_SEPARATOR:String = ",";
		
		public var width:int 	= -1;
		public var height:int 	= -1;
		
		
		/**
		 * one-dimensional tile array
		 */ 
		public var tiles:Vector.<Entity> = null;
		
		/**
		 * one-dimensional entities array
		 */ 
		public var entities:Vector.<Entity> = null;
		
		
		public function Level() {
		
		}
		
		public function draw(renderTexture : RenderTexture) : void {
			//Draw our level :)
			for (var i:int = 0; i < tiles.length; i++) {
				tiles[i].draw(renderTexture);
			}
		}
		
		public function update( delta : Number) : void {
			//Update tiles
			for (var i:int = 0; i < tiles.length; i++) {
				tiles[i].update(delta);
			}			
		}
		
		/**
		 * parse level definition file into tile array and script variables
		 */
		public function initialize(levelStr:String) : void {
			tiles = new Vector.<Entity>();
			entities = new Vector.<Entity>();
			
			var lines:Array = levelStr.split(this.LINE_SEPARATOR); 
			parse(lines);

		}
		
		private function parse(lines:Array) : void {
			this.width = Number(lines[0]);
			this.height = Number(lines[1]);
			
			for (var i:int = 3; i < height + 3; i++ ) {
				var line:String = lines[i];
				for (var j:int = 0; j < line.length; j++ ) {
					var entity:Entity = null; 
					switch(line.charAt(j)) {
						case TILE_STATIC_FLOOR_STRING:
							entity = new TileFloor();
							break;
						
						case TILE_STATIC_CRUMBLE_STRING:
							entity = new TileCrumble();
							break;
						
						case TILE_STATIC_WALL_STRING:
							entity = new TileWall();
							break;
						
						case TILE_STATIC_HOLE_STRING:
							entity = new TileHole();
							break;
						
						default:
							trace("Token unrecognized");
							break;
					}
					if(entity != null){
						tiles.push(entity);
					}
				}
			}
			for (var i:int = height + 4; i < lines.length; i++ ) {
				var line:String = lines[i];
				var tokens:Array = line.split(this.TOKEN_SEPARATOR);
				for (var j:int = 0; j < tokens.length; j++ ) {
					var entity:Entity = null; 
					switch(tokens[0]) {
						case ENTITY_P1:
						case ENTITY_P2:
							entity = new EntityPlayer();
							break;
						case ENTITY_JITTERY:
							entity = new EntityJittery();
							break;
						case ENTITY_SELF_CONFIDENT:
							entity = new EntitySelfConfident();
							break;
						case ENTITY_ANGRY:
							entity = new EntityAngry();
							break;
						case ENTITY_HAPPY:
							entity = new EntityHappy();
							break;
						case ENTITY_CALM:
							entity = new EntityCalm();
							break;
						case ENTITY_STONE:
							entity = new EntityStone();
							break;
						case ENTITY_MINE:
							entity = new EntityMine();
							break;
						default:
							trace("Token unrecognized");
							break;
					}
					
					if(entity != null){
						entities.push(entity);
					}
				}
			}
		}
	}

}