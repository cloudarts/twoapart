package  
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;
	/**
	 * ...
	 * @author ...
	 */
	public class Intro 
	{
		private var logo : Image;
		private var logoFire : Image;
		private var logoWater : Image;
		private var centerPixelPosLogo : Point;
		private var centerPixelPosLogoFire : Point;
		private var centerPixelPosLogoWater : Point;
		private var world : Matrix;
		
		
		public function Intro() {
			
			world = new Matrix();
			world.identity();
			
			logoWater = new Image( Game.textureAtlas.getTexture("Logo_water") );
			centerPixelPosLogoWater = new Point((Constants.SCREEN_WIDTH - logoWater.width)/2, (Constants.SCREEN_HEIGHT - logoWater.height)*1/6);
			
			logoFire = new Image( Game.textureAtlas.getTexture("Logo_fire") );
			centerPixelPosLogoFire = new Point((Constants.SCREEN_WIDTH - logoFire.width)/2, (Constants.SCREEN_HEIGHT - logoFire.height)*1/6);
			
			logo = new Image( Game.textureAtlas.getTexture("Logo") );
			centerPixelPosLogo = new Point((Constants.SCREEN_WIDTH - logo.width)/2, (Constants.SCREEN_HEIGHT - logo.height)*1/6);
			
		}
		
		
		public function draw(targetTexture : RenderTexture) : void {
			world.createBox(1, 1, 0, centerPixelPosLogoWater.x, centerPixelPosLogoWater.y);
			targetTexture.draw(logoWater, world);
			
			world.createBox(1, 1, 0, centerPixelPosLogoFire.x, centerPixelPosLogoFire.y);
			targetTexture.draw(logoFire, world);
			
			world.createBox(1, 1, 0, centerPixelPosLogo.x, centerPixelPosLogo.y);			
			targetTexture.draw(logo, world);
		}
	}

}