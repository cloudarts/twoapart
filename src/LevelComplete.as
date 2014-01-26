package  
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.display.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class LevelComplete 
	{
		private const targetPos : Point;
		private const startLogoFire : Point = new Point(398, 248.5);
		private const startLogoWater : Point = new Point(798, 316.5);
		
		private var logoFire : Image;
		private var logoWater : Image;
		private var levelComplete : Image;
		private var actualPosLogoFire : Point;
		private var actualPosLogoWater : Point;
		private var PosLevelComplete : Point;
		private var world : Matrix;
		private var alpha : Number = 0;
		private var animTime : Number;
		
		public var isRunning : Boolean;
		
		public function LevelComplete() 
		{
			isRunning = true;
			
			world = new Matrix();
			world.identity();
			
			logoWater = new Image( Game.textureAtlas.getTexture("Logo_water") );
			actualPosLogoWater = new Point(startLogoWater.x, startLogoWater.y);
			
			logoFire = new Image( Game.textureAtlas.getTexture("Logo_fire") );
			actualPosLogoFire = new Point(startLogoFire.x, startLogoFire.y);
			
			targetPos = new Point((Constants.SCREEN_WIDTH - logoWater.width) / 2, (Constants.SCREEN_HEIGHT - logoWater.height) / 2);
			
			reset();
		}
		
		private function reset():void 
		{
			alpha = 0;
			animTime = 0;
			actualPosLogoWater = new Point(startLogoWater.x, startLogoWater.y);
			actualPosLogoFire = new Point(startLogoFire.x, startLogoFire.y);
		}
		
		public function draw(targetTexture : RenderTexture) : void {
			
			world.createBox(1, 1, 0, actualPosLogoWater.x, actualPosLogoWater.y);
			targetTexture.draw(logoWater, world);
			
			world.createBox(1, 1, 0, actualPosLogoFire.x, actualPosLogoFire.y);
			targetTexture.draw(logoFire, world);
		}
		
		public function update(delta : Number) : void {
			animTime += delta;
			var durationSeparate : Number = (PHASE_1 - PHASE_0);
			var progressSeparate : Number = (animTime - PHASE_0) / durationSeparate;
	
			var diffWaterX:Number = targetPos.x - startLogoWater.x;
			var diffWaterY:Number = targetPos.y - startLogoWater.y;
			var diffFireX:Number = targetPos.x - startLogoFire.x;
			var diffFireY:Number = targetPos.y - startLogoFire.y;
			
			actualPosLogoFire.x = startLogoFire.x + (diffFireX * progressSeparate);
			actualPosLogoFire.y = startLogoFire.y + (diffFireY * progressSeparate);
			actualPosLogoWater.x = startLogoWater.x + (diffWaterX * progressSeparate);
			actualPosLogoWater.y = startLogoWater.y + (diffWaterY * progressSeparate);
		}
		
		public function startLevelCompleteAnimation () : void {
			
		}
		
	}

}