package  {
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Entity {
		
		public const borderTop = Constants.TILE_SIDE_SIZE;
		public const borderLeft = Constants.TILE_TOP_SIZE * 2;
		
		protected var entityImage : Image;
		
		protected var world : Matrix;
		protected var offsetX : Number = 0;
		protected var offsetY : Number = 0;
		protected var time : Number = 0;
		
		protected var centerPixelPos : Point;
		protected var centerTilePos : Point;
		
		public function Entity() {
			world = new Matrix();
			world.identity();
			
			centerPixelPos = new Point(0, 0);
			centerTilePos = new Point(0, 0);
		}
		
		public function setTile(x : int, y : int) : void {
			centerTilePos = new Point(x, y);
			centerPixelPos.x = Constants.TILE_TOP_SIZE * centerTilePos.x;
			centerPixelPos.y = Constants.TILE_TOP_SIZE * centerTilePos.y;
		}
		
		public function setPixelPos(x : Number, y: Number) {
			centerPixelPos = new Point(x, y);
			centerTilePos.x = x / Constants.TILE_TOP_SIZE;
			centerTilePos.y = y / Constants.TILE_TOP_SIZE;
		}
		
		public function getTile() : Point {
			return centerTilePos;
		}
		
		
		public function getPixelPos() : Point {
			return centerPixelPos;
		}
		
		public function update(delta:Number) : void {
			time += delta;
		}
		
		public function draw(targetTexture : RenderTexture) : void {
			world.createBox(1, 1, 0,
				centerPixelPos.x + offsetX + borderLeft, 
				centerPixelPos.y + offsetY + borderTop);
				
			targetTexture.draw(entityImage, world);
		}
		
	}

}