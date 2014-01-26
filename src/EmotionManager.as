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
	public class EmotionManager 
	{
		private var stack:Array = new Array();
		private var activeEmotions:Array = [Constants.EMOTION_NONE, Constants.EMOTION_NONE];
		private var playerGUIs: Vector.<Image>;
		private var waiting:Vector.<int> = new Vector.<int>();
		private var emoticons:Vector.<Image> = new Vector.<Image>();
		private var texEmotionNames:Array = ["emotions_flower","emotions_pillow", "emotions_energy-drink",
						 "emotions_schokolade","emotions_hantel","emotions_bubble"];
		private var texGUIStr:Array = ["hud_rot", "hud_white"];
		private var texGUIImg:Array = new Array();
		private var matStartCenter:Matrix = new Matrix();
		private var matStartP1:Matrix = new Matrix();
		private var matStartP2:Matrix = new Matrix();
		private var matStartWaitP1:Matrix = new Matrix();
		private var matStartWaitP2:Matrix = new Matrix();
		private var matDeltaP1:Matrix	= new Matrix();
		private var matDeltaP2:Matrix	= new Matrix();
		
		public function EmotionManager() 
		{
			matStartCenter.identity();
			matStartCenter.tx = Constants.SCREEN_WIDTH / 2;
			matStartCenter.ty = Constants.SCREEN_HEIGHT - Constants.GUI_OFFSET_H;
			
			matDeltaP1.identity();
			matDeltaP2.identity();
			matDeltaP1.translate(Constants.TILE_TOP_SIZE * 1.5, 0);
			matDeltaP2.translate(-Constants.TILE_TOP_SIZE * 1.5, 0);
			
			matStartP1.identity();
			matStartP2.identity();
			matStartP1.translate( -0.49 * Constants.SCREEN_WIDTH, 0);
			matStartP2.translate( 0.20 * Constants.SCREEN_WIDTH, 0);
			
			matStartWaitP1.identity();
			matStartWaitP2.identity();
			matStartWaitP1.translate(Constants.TILE_TOP_SIZE, Constants.TILE_TOP_SIZE + Constants.TILE_SIDE_SIZE);
			matStartWaitP2.translate(150 + Constants.TILE_TOP_SIZE, Constants.TILE_TOP_SIZE + Constants.TILE_SIDE_SIZE);
			
			
			for (var i:int = 0; i < texEmotionNames.length; i++) {		
				
				var emoImage:Image = new Image( Game.textureAtlas.getTexture(texEmotionNames[i]) );
				emoImage.smoothing = TextureSmoothing.NONE;
				emoticons.push(emoImage);
			}
			for (var i:int = 0; i < texGUIStr.length; i++) {
				var emoImage:Image = new Image( Game.textureAtlas.getTexture(texGUIStr[i]) );
				emoImage.smoothing = TextureSmoothing.NONE;
				texGUIImg.push(emoImage);
			
			}
	
			waiting.push(Constants.EMOTION_ANGRY, Constants.EMOTION_CALM, Constants.EMOTION_SAD);
		}
		
		
		
		public function draw(renderTexture:RenderTexture):void 
		{
			var matP1 : Matrix = matStartCenter.clone();
			var matP2 : Matrix = matStartCenter.clone();
			
			matP1.concat(matStartP1)
			matP2.concat(matStartP2)
			renderTexture.draw(texGUIImg[0], matP1);
			renderTexture.draw(texGUIImg[1], matP2);
			
			matP1.concat(matStartWaitP1);
			matP2.concat(matStartWaitP2);
			for (var i : int; i < waiting.length; i++) {
				renderTexture.draw(emoticons[waiting[i]], matP1);
				renderTexture.draw(emoticons[waiting[i]], matP2);
				matP1.concat(matDeltaP1);
				matP2.concat(matDeltaP2);
			}
		}
		
		public function update(delta:int):void 
		{
			
		}
		
		public function push(emotion:int):void {
			stack.push(emotion);
		}
		
	}

}