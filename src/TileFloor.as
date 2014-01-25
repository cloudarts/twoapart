package  
{
	import flash.geom.Matrix;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;
	/**
	 * ...
	 * @author ...
	 */
	public class TileFloor extends Entity
	{
		private var tileTexNames : Array = ["tile_01" , "tile_02", "tile_03", "tile_04"];
		private var tileImage : Image
		
		private var world : Matrix;
		
		public function TileFloor() 
		{
			super();
			
			var texIndex : int = Math.random() * tileTexNames.length;		
			
			tileImage = new Image( Game.textureAtlas.getTexture(tileTexNames[texIndex]) );
			tileImage.smoothing = TextureSmoothing.NONE;
			
			world = new Matrix();
			world.identity();
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			super.draw(targetTexture);
			
			world.createBox(1, 1, 0, this.x * Constants.TILE_TOP_SIZE, this.y * Constants.TILE_TOP_SIZE);
			targetTexture.draw(tileImage, world);
		}
		
		override public function update(delta:Number):void 
		{
			super.update(delta);
			
		}
	}
}