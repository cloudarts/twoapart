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
	public class EntityJittery extends Entity
	{
		private var entityTexName : String = "emotions_energy-drink";
		private var entityImage : Image;
		
		private var world : Matrix;
		private var offsetX : Number = 0;
		private var offsetY : Number = 0;
		private var time : Number = 0;
		
		public function EntityJittery() 
		{
			entityImage = new Image( Game.textureAtlas.getTexture(entityTexName) );
			entityImage.smoothing = TextureSmoothing.NONE;
			
			world = new Matrix();
			world.identity();
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			super.draw(targetTexture);
			
			world.createBox(1, 1, 0,
				this.x * Constants.TILE_TOP_SIZE + offsetX, 
				this.y * Constants.TILE_TOP_SIZE + offsetY);
				
			targetTexture.draw(entityImage, world);
		}
		
		override public function update(delta:Number):void 
		{
			super.update(delta);
/*			time += delta;
			offsetX = 5 * Math.sin(time);
			offsetY = 5 * Math.cos(offsetX * time);*/
		}		
	}
}