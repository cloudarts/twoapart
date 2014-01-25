package  
{
	import flash.geom.Matrix;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	/**
	 * ...
	 * @author ...
	 */
	public class FloorTile extends Entity 
	{		
		private var floorTexNames : Array = ["tile_01" , "tile_02", "tile_03", "tile_04"];
		
		private var floorImage : Image;
		
		private var world : Matrix;
		
		public function FloorTile() 
		{
			super();
			
			var texIndex : int = Math.random() * floorTexNames.length;		
			
			floorImage = new Image( Game.textureAtlas.getTexture(floorTexNames[texIndex]) );
			floorImage.smoothing = TextureSmoothing.NONE;
			
			world = new Matrix();
			world.identity();
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			super.draw(targetTexture);
			
			world.createBox(1, 1, 0, this.x * Constants.TILE_TOP_SIZE, this.y * Constants.TILE_TOP_SIZE);
			//TODO set correct matrix
			targetTexture.draw(floorImage, world);
		}
		
		override public function update(delta:Number):void 
		{
			super.update(delta);
			
		}
		
	}

}