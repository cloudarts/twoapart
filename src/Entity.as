package  {
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Entity extends Point {
		
		public const borderTop = Constants.TILE_SIDE_SIZE;
		public const borderLeft = Constants.TILE_TOP_SIZE;
		
		protected var entityImage : Image;
		
		protected var world : Matrix;
		protected var offsetX : Number = 0;
		protected var offsetY : Number = 0;
		protected var time : Number = 0;
		
		public function Entity() {
			world = new Matrix();
			world.identity();
		}
		
		public function update(delta:Number) : void {
			time += delta;
		}
		
		public function draw(targetTexture : RenderTexture) : void {
			world.createBox(1, 1, 0,
				this.x * Constants.TILE_TOP_SIZE + offsetX + borderLeft, 
				this.y * Constants.TILE_TOP_SIZE + offsetY + borderTop);
				
			targetTexture.draw(entityImage, world);
		}
		
	}

}