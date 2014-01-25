package  
{
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;
	/**
	 * ...
	 * @author ...
	 */
	public class TileCrumble extends Entity
	{
		private var entityTexNames : Array = ["tile_breakable-floor_01" , "tile_breakable-floor_02", "tile_breakable-floor_03", "tile_breakable-floor_04"];
		
		public function TileCrumble() 
		{
			entityImage = new Image( Game.textureAtlas.getTexture(entityTexNames[0]) );
			entityImage.smoothing = TextureSmoothing.NONE;			
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			super.draw(targetTexture);
		}
		
		override public function update(delta:Number):void 
		{
			super.update(delta);
			
		}
	}

}