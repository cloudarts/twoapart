package  {
	import flash.geom.Point;
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
		
		/**
		 * parse level definition file into tile array and script variables
		 */
		public function initialize(levelStr:String) : void {
			tiles = new Vector.<Entity>();
			entities = new Vector.<Entity>();
			
			var lines:Array = levelStr.split(/\n/);
			var i:int = 0; 
			
		}
		
	}

}