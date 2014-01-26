package  {
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Quad;
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
		protected var boundingBox : Rectangle;
		
		protected var centerPixelPos : Point;
		protected var centerTilePos : Point;
		
		protected var offsetScalingX : Number = 0;
		
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
			boundingBox = new Rectangle(centerPixelPos.x, centerPixelPos.y,
												Constants.TILE_TOP_SIZE, Constants.TILE_TOP_SIZE);
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
			world.tx = centerPixelPos.x + offsetX + borderLeft + offsetScalingX;
			world.ty = centerPixelPos.y + offsetY + borderTop;
			
			targetTexture.draw(entityImage, world);
		}
		
		public function drawDebug(targetTexture:RenderTexture, color:uint = 0xff0000)
		{
			var quad:Quad = new Quad(1, 1, 0xff0000);
			var matScale:Matrix = new Matrix();
			var matTrans:Matrix = new Matrix();
			matTrans.translate(boundingBox.x + borderLeft, boundingBox.y + borderTop);
			matScale.scale(boundingBox.width, boundingBox.height);
			matScale.concat(matTrans);
			targetTexture.draw(quad, matScale, 0.4 );
		}
		
		public static function compareValues(a:Entity, b:Entity):int
        {
            if (a == null && b == null)
                return 0;
     
            if (a == null)
              return 1;
     
            if (b == null)
               return -1;
     
            if (a.getPixelPos().y < b.getPixelPos().y)
                return -1;
     
            if (a.getPixelPos().y > b.getPixelPos().y)
                return 1;
     
			if (a.getPixelPos().x < b.getPixelPos().x)
                return -1;
     
            if (a.getPixelPos().x > b.getPixelPos().x)
                return 1;	
				
            return 0;
        }
		
	}

}