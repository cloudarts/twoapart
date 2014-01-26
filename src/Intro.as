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
		// in seconds
		private const DURATION_START_FADE_IN : Number = 5; 
		
		private var logo : Image;
		private var logoFire : Image;
		private var logoWater : Image;
		private var start : Image;
		private var centerPixelPosLogo : Point;
		private var centerPixelPosLogoFire : Point;
		private var centerPixelPosLogoWater : Point;
		private var centerPixelPosStart : Point;
		private var world : Matrix;
		private var alpha : Number = 0;
		
		public var isRunning : Boolean;
		
		private var animTime : Number;
		
		
		public function Intro() {
			
			isRunning = true;
			
			world = new Matrix();
			world.identity();
			
			logoWater = new Image( Game.textureAtlas.getTexture("Logo_water") );
			centerPixelPosLogoWater = new Point((Constants.SCREEN_WIDTH - logoWater.width)/2, (Constants.SCREEN_HEIGHT - logoWater.height)*1/6);
			
			logoFire = new Image( Game.textureAtlas.getTexture("Logo_fire") );
			centerPixelPosLogoFire = new Point((Constants.SCREEN_WIDTH - logoFire.width)/2, (Constants.SCREEN_HEIGHT - logoFire.height)*1/6);
			
			logo = new Image( Game.textureAtlas.getTexture("Logo") );
			centerPixelPosLogo = new Point((Constants.SCREEN_WIDTH - logo.width) / 2, (Constants.SCREEN_HEIGHT - logo.height) * 1 / 6);
			
			start = new Image( Game.textureAtlas.getTexture("start_button") );
			centerPixelPosStart = new Point((Constants.SCREEN_WIDTH - start.width)/2, (Constants.SCREEN_HEIGHT - start.height)*4/6);
			
			reset();
		}
		
		
		public function draw(targetTexture : RenderTexture) : void {
			world.createBox(1, 1, 0, centerPixelPosLogoWater.x, centerPixelPosLogoWater.y);
			targetTexture.draw(logoWater, world);
			
			world.createBox(1, 1, 0, centerPixelPosLogoFire.x, centerPixelPosLogoFire.y);
			targetTexture.draw(logoFire, world);
			
			world.createBox(1, 1, 0, centerPixelPosLogo.x, centerPixelPosLogo.y);			
			targetTexture.draw(logo, world);
			
			world.createBox(1, 1, 0, centerPixelPosStart.x, centerPixelPosStart.y);			
			targetTexture.draw(start, world, alpha);
			
		}
		
		public function update(delta : Number) : void {
			animTime += delta;
			
			var progress:Number = animTime / DURATION_START_FADE_IN;
			alpha = progress;
			
			alpha += DURATION_START_FADE_IN * delta;
			if (1 == alpha) {
				if ( KeyboardController.isPressed_Action(0) || KeyboardController.isPressed_Action(1)) {
					isRunning = false;
				}
			}
		}
		
		private function reset() : void {
			alpha = 0;
			animTime = 0;
		}
	}

}