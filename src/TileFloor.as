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
		private var entityTexNames : Array = ["tile_01" , "tile_02", "tile_03", "tile_04"];
		
		public function TileFloor() 
		{
			super();
			
			var texIndex : int = Math.random() * entityTexNames.length;		
			
			entityImage = new Image( Game.textureAtlas.getTexture(entityTexNames[texIndex]) );
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