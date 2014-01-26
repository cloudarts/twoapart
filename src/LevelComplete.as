package  
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.RenderTexture;
	/**
	 * ...
	 * @author ...
	 */
	public class LevelComplete 
	{
		
		private const startLogoFire : Point = new Point(398, 304.5);
		private const startLogoWater : Point = new Point(798, 236.5);
		private const PHASE_0 : Number = 1.0; //reunite
		private const PHASE_1 : Number = 1.5; //glow
		private const PHASE_2 : Number = 2.5; //level complete button fades in
		private const ALPHA_OF_DARKNESS = 0.5;
		
		private var logoFire : Image;
		private var logoWater : Image;
		private var levelComplete : Image;
		private var actualPosLogoFire : Point;
		private var actualPosLogoWater : Point;
		private var PosLevelComplete : Point;
		private var world : Matrix;
		
		private var animTime : Number;
		private var targetPos : Point;
		private var darkness : Quad;
		private var glow : Image;
		private var glowPos : Point;
		private var alphaGlow : Number = 0.0;
		private var levelCompletePos:Point;
		
		private var alphaLevelComplete : Number = 0.0;
		private var game : Game; 
		
		public var isRunning : Boolean;
		
		public function LevelComplete(game : Game) 
		{
			this.game = game;
			isRunning = false;
			
			world = new Matrix();
			world.identity();
			
			darkness = new Quad(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT, 0x000000, true);
			darkness.alpha = ALPHA_OF_DARKNESS;
			
			logoWater = new Image( Game.textureAtlas.getTexture("Logo_water") );
			actualPosLogoWater = new Point(startLogoWater.x, startLogoWater.y);
			
			logoFire = new Image( Game.textureAtlas.getTexture("Logo_fire") );
			actualPosLogoFire = new Point(startLogoFire.x, startLogoFire.y);
			
			levelComplete = new Image( Game.textureAtlas.getTexture("level_complete") );
			levelCompletePos = new Point((Constants.SCREEN_WIDTH - levelComplete.width) / 2, (Constants.SCREEN_HEIGHT - levelComplete.height) / 2);
			
			glow = new Image( Game.textureAtlas.getTexture("glow") );
			glowPos = new Point((Constants.SCREEN_WIDTH - glow.width) / 2, (Constants.SCREEN_HEIGHT - glow.height) / 2);
			
			targetPos = new Point((Constants.SCREEN_WIDTH - logoWater.width) / 2, (Constants.SCREEN_HEIGHT - logoWater.height) / 2);
			
			reset();
		}
		
		public function reset(): void 
		{
			alphaLevelComplete = 0;
			alphaGlow = 0;
			animTime = 0;
			actualPosLogoWater = new Point(startLogoWater.x, startLogoWater.y);
			actualPosLogoFire = new Point(startLogoFire.x, startLogoFire.y);
		}
		
		public function draw(targetTexture : RenderTexture) : void {
			world.createBox(1, 1, 0, 0, 0);
			targetTexture.draw(darkness, world);
			
			world.createBox(1, 1, 0, glowPos.x, glowPos.y);
			targetTexture.draw(glow, world, alphaGlow);
			
			world.createBox(1, 1, 0, actualPosLogoWater.x, actualPosLogoWater.y);
			targetTexture.draw(logoWater, world);
			
			world.createBox(1, 1, 0, actualPosLogoFire.x, actualPosLogoFire.y);
			targetTexture.draw(logoFire, world);
			
			world.createBox(1, 1, 0, levelCompletePos.x, levelCompletePos.y);
			targetTexture.draw(levelComplete, world, alphaLevelComplete);
		}
		
		public function update(delta : Number) : void {
			animTime += delta;
			var isGlowing : Boolean = false;
			
			if (animTime < PHASE_0) {
				var progressSeparate : Number = animTime / PHASE_0;
		
				var diffWaterX:Number = targetPos.x - startLogoWater.x;
				var diffWaterY:Number = targetPos.y - startLogoWater.y;
				var diffFireX:Number = targetPos.x - startLogoFire.x;
				var diffFireY:Number = targetPos.y - startLogoFire.y;
				
				actualPosLogoFire.x = startLogoFire.x + (diffFireX * progressSeparate);
				actualPosLogoFire.y = startLogoFire.y + (diffFireY * progressSeparate);
				actualPosLogoWater.x = startLogoWater.x + (diffWaterX * progressSeparate);
				actualPosLogoWater.y = startLogoWater.y + (diffWaterY * progressSeparate);
			}  else if (!isGlowing && animTime < PHASE_1) {
				alphaGlow = 1.0;
				isGlowing = true;
			} else {
				var durationFadeIn : Number = (PHASE_2 - PHASE_1);
				var progress : Number = (animTime - PHASE_1) / durationFadeIn;
				alphaLevelComplete = progress;
				
				if ( KeyboardController.isPressed_Action(0) || KeyboardController.isPressed_Action(1)) {
					isRunning = false;
					game.startCurrentLevel();
				}
			}
		}		
	}
}