package  {
	import flash.geom.Point;
	import starling.textures.RenderTexture;
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Level {
		
		
		
		public const TILE_STATIC_FLOOR:int 		= 0;
		public const TILE_STATIC_WALL:int		= 1;
		public const TILE_STATIC_HOLE:int		= 2;
		public const TILE_STATIC_CRUMBLE:int	= 3;
		
		
		
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
			
			var lines:Array = levelStr.split(/\n/);
			var i:int = 0; 
						
			//TODO DEBUG
			for (var x : int = 0; x < 20; x++) {
				for (var y:int = 0; y < 12; y++) {
					var tile : FloorTile = new FloorTile();
					tile.x = x;
					tile.y = y;
					
					tiles.push(tile);
				}
			}
		}
		
	}

}