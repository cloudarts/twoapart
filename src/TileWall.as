package  
{
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TileWall extends Entity
	{
		private var tileTexNames : Array = ["tile_01" , "tile_02", "tile_03", "tile_04"];
		
		public function TileWall() 
		{
			super();
			
			var texIndex : int = Math.random() * tileTexNames.length;		
			
			entityImage = new Image( Game.textureAtlas.getTexture(tileTexNames[texIndex]) );
			entityImage.smoothing = TextureSmoothing.NONE;
		}
		
		override public function setTile(x:int, y:int):void {
			super.setTile(x,y);
			boundingBox = new Rectangle(centerPixelPos.x, centerPixelPos.y,
												Constants.TILE_TOP_SIZE, Constants.TILE_TOP_SIZE);
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