package  
{
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author ...
	 */
	public class FloorTile extends Entity 
	{		
		private var floorTexNames : Array = ["tile_01" , "tile_02", "tile_03", "tile_04"];
		
		private var floorImage : Image;
		
		public function FloorTile() 
		{
			super();
			
			var texIndex : int = Math.random() * floorTexNames.length;		
			floorImage = new Image( Game.textureAtlas.getTexture(floorTexNames[texIndex]) );
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			super.draw(targetTexture);
			
			//TODO set correct matrix
			targetTexture.draw(floorImage);
		}
		
		override public function update(delta:Number):void 
		{
			super.update(delta);
			
		}
		
	}

}