package  {
	import flash.geom.Point;
	import flash.geom.Rectangle;
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
		public const TILE_STATIC_NARROW_VERTICAL_STRING:String = "N";
		public const TILE_STATIC_NARROW_HORIZONTAL_STRING:String = "Z";
		
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
		
		public const ERROR_MSG_WRONG_COUNT:String = "ERROR: Wrong count of tokens";
		
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

			entities = entities.sort(Entity.compareValues);
			
			//Draw our level :)
			for (var i:int = 0; i < tiles.length; i++) {
				tiles[i].draw(renderTexture);
			}
			
			for (var j:int = 0; j < entities.length; j++) 
			{
				entities[j].draw(renderTexture);
			}
			for (var i:int = 0; i < entities.length; i++)
			{
				if (entities[i] instanceof TileWall)
					entities[i].drawDebug(renderTexture);
			}
		}
		
		public function update( delta : Number) : void {
			//Update tiles
			for (var i:int = 0; i < tiles.length; i++) {
				tiles[i].update(delta);
			}
			//Update entities
			for (var i:int = 0; i < entities.length; i++) {
				entities[i].update(delta);
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
			
			var a:int = 0;

		}
		
		//Parse the lines of textfile
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
						
						case TILE_STATIC_NARROW_VERTICAL_STRING:
							entity = new TileNarrowVertical();
							break;
							
						case TILE_STATIC_NARROW_HORIZONTAL_STRING:
							entity = new TileNarrowHorizontal();
							break;
							
						default:
							trace("Token unrecognized");
							break;
					}
					if (entity != null) {
						entity.setTile(j, i - 3);
						if (entity instanceof TileWall || entity instanceof TileNarrowHorizontal || entity instanceof TileNarrowVertical) {
							entities.push(entity);
							var wall : Entity = new TileFloor();
							wall.setTile(j, i - 3);
							tiles.push(wall);
						} else {
							tiles.push(entity);
						}
					}
				}
			}
			for (var i:int = height + 4; i < lines.length; i++ ) {
				var line:String = lines[i];
				var tokens:Array = line.split(this.TOKEN_SEPARATOR);
				var entity:Entity = null; 
				
				switch(tokens[0]) {
					case ENTITY_P1:
					case ENTITY_P2:
						if(tokens.length == 3){
							entity = new EntityPlayer();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}
						break;
					case ENTITY_JITTERY:
						if (tokens.length == 3) {
							entity = new EntityJittery();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}
						break;
					case ENTITY_SELF_CONFIDENT:
						if (tokens.length == 3) {
							entity = new EntitySelfConfident();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_ANGRY:
						if (tokens.length == 3) {
							entity = new EntityAngry();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_HAPPY:
						if (tokens.length == 3) {
							entity = new EntityHappy();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_CALM:
						if (tokens.length == 3) {
							entity = new EntityCalm();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_STONE:
						if (tokens.length == 3) {
							entity = new EntityStone();
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					case ENTITY_MINE:
						if (tokens.length > 4 && (tokens.length % 2 == 1)) {
							var waypoints:Array = new Array();
							
							for ( var coord:int = 1; coord < tokens.length; coord += 2 ) {
								var waypoint:Point = new Point(Number(tokens[coord]), Number(tokens[coord + 1]));
								waypoints.push(waypoint);
							}
							
							entity = new EntityMine(waypoints);
														
						} else {
							trace(ERROR_MSG_WRONG_COUNT);
						}						
						break;
					default:
						trace("Token unrecognized");
						break;
				}
					
				if(entity != null){
					entity.setTile(tokens[1], tokens[2]);
					entities.push(entity);
				}
			}
		}

		public static function checkForCollision(e1 : Rectangle,  e2 : Rectangle) : Boolean{	
			return e1.intersects(e2);
			
		}
		
	}
}

