package  {
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Constants {
		
		public static const SCREEN_WIDTH:int = 1280;
		public static const SCREEN_HEIGHT:int = 720;
		/**
		 * Size of the upper face of the tile (x and y)
		 */
		public static const TILE_TOP_SIZE:int = 50;		
		
		public static const CHARACTER_SIZE:int = 48;
		/**
		 * Size of the side faces of the tile (x and y)
		 */
		public static const TILE_SIDE_SIZE:int = 10;
		public static const TICK_DURSTION:Number = 16;
		
		public static const INIT_CRUMBLE_TIME : Number = 0.1;
		
		public static const PLAYER_BBOX_NORMAL_W : Number = Constants.TILE_TOP_SIZE - 10;
		public static const PLAYER_BBOX_NORMAL_H : Number = Constants.TILE_TOP_SIZE - 30;
		public static const PLAYER_BBOX_PIVOT_X : Number = Constants.TILE_TOP_SIZE / 2;
		public static const PLAYER_BBOX_PIVOT_Y : Number = Constants.TILE_TOP_SIZE;
		
		
		public function Constants() {
			
		}
		
	}

}