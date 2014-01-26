package  
{
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;
	/**
	 * ...
	 * @author ...
	 */
	public class TileNarrowVertical extends Entity
	{
		private var tileTexName:String = "tile_schmal_vertikal";
		private var boundingBoxSmall:Rectangle;
		public function TileNarrowVertical() 
		{
			super();
			entityImage = new Image( Game.textureAtlas.getTexture(tileTexName) );
			entityImage.smoothing = TextureSmoothing.NONE;	
		}
		
		public function getSmallBB():Rectangle {
			return boundingBoxSmall;
		}
		
		override public function setTile(x:int, y:int):void {
			super.setTile(x,y);
			boundingBox = new Rectangle(centerPixelPos.x, centerPixelPos.y,
												Constants.TILE_TOP_SIZE, Constants.TILE_TOP_SIZE);
			boundingBoxSmall = new Rectangle(centerPixelPos.x, centerPixelPos.y, Constants.TILE_TOP_SIZE / 2, Constants.TILE_TOP_SIZE);
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{			
			offsetX = -Constants.TILE_SIDE_SIZE;
			offsetY = -Constants.TILE_SIDE_SIZE;
			super.draw(targetTexture);
		}
		
		override public function update(delta:Number):void 
		{
			super.update(delta);			
		}
		
	}
}