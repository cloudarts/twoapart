package  
{
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;
	/**
	 * ...
	 * @author ...
	 */
	public class EntityStone extends Entity
	{
		private var entityTexNames : Array = ["tile_breakable_01" , "tile_breakable_02", "tile_breakable_03", "tile_breakable_04"];
		
		public function EntityStone() 
		{
			entityImage = new Image( Game.textureAtlas.getTexture(entityTexNames[0]) );
			entityImage.smoothing = TextureSmoothing.NONE;
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