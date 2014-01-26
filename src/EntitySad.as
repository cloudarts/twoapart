package  
{
	import flash.geom.Matrix;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * ...
	 * @author 
	 */
	public class EntitySad extends Entity 
	{
		private var entityTexName : String = "emotions_flower";
		
		public function EntitySad() 
		{
			super();
		
			
			entityImage = new Image( Game.textureAtlas.getTexture(entityTexName) );
			entityImage.smoothing = TextureSmoothing.NONE;
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			super.draw(targetTexture);
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