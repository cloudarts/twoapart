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
		private var activeEmotions:Array = [Constants.EMOTION_NONE, Constants.EMOTION_NONE];
		private var playerGUIs: Vector.<Image>;
		private var waiting:Vector.<int> = new Vector.<int>();
		private var emoticons:Vector.<Image> = new Vector.<Image>();
		private var texEmotionNames:Array = ["emotions_flower", "emotions_pillow", "emotions_schokolade", 
			"emotions_hantel", "emotions_bubble", "emotions_energy-drink"];
		private var texGUIStr:Array = ["hud_color_p1", "hud_color_p2"];
		private var texGUIImg:Array = new Array();
		private var matStartCenter:Matrix = new Matrix();
		private var matStartP1:Matrix = new Matrix();
		private var matStartP2:Matrix = new Matrix();
		private var matStartWaitP1:Matrix = new Matrix();
		private var matStartWaitP2:Matrix = new Matrix();
		private var matDeltaP1:Matrix	= new Matrix();
		private var matDeltaP2:Matrix	= new Matrix();
		
		private var _players:Array = new Array(2);
		private var _p1ActionDown : Boolean = false;
		private var _p2ActionDown : Boolean = false;
		
		private var timers_Emotion : Array = [- 1.0 , -1.0];
		
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
			matStartWaitP2.translate(125 + Constants.TILE_TOP_SIZE, Constants.TILE_TOP_SIZE + Constants.TILE_SIDE_SIZE);
			
			
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
		}
		
		
		
		public function draw(renderTexture:RenderTexture):void 
		{
			var matP1 : Matrix = matStartCenter.clone();
			var matP2 : Matrix = matStartCenter.clone();
			
			matP1.concat(matStartP1)
			matP2.concat(matStartP2)
			renderTexture.draw(texGUIImg[0], matP1);
			renderTexture.draw(texGUIImg[1], matP2);
			
			if (activeEmotions[0] != Constants.EMOTION_NONE) {
				var tempMat : Matrix = matP1.clone();
				tempMat.translate(Constants.TILE_SIDE_SIZE, Constants.TILE_SIDE_SIZE);
				renderTexture.draw(emoticons[activeEmotions[0] - 1], tempMat);
			}

			if (activeEmotions[1] != Constants.EMOTION_NONE) {
				var tempMat : Matrix = matP2.clone();
				tempMat.translate( Constants.TILE_SIDE_SIZE*21, Constants.TILE_SIDE_SIZE); //correct the position of active emotion
				renderTexture.draw(emoticons[activeEmotions[1] - 1], tempMat);
			}
			
			matP1.concat(matStartWaitP1);
			matP2.concat(matStartWaitP2);
			for (var i : int = 0; i < waiting.length; i++) {
				renderTexture.draw(emoticons[waiting[i] - 1], matP1);
				renderTexture.draw(emoticons[waiting[i] - 1], matP2);
				matP1.concat(matDeltaP1);
				matP2.concat(matDeltaP2);
			}
		}
		
		public function setPlayer( player:EntityPlayer, playerID:int) : void {
			_players[playerID] = player;
		}
		
		public function handleAction(playerID:int) : void {
			trace("Handle action player: " + playerID);
			
			if ( waiting.length == 0 ) {
				return;
			} 
			 
			var emotion:int = waiting.pop();
			(_players[playerID] as EntityPlayer).useEmotion(emotion);
			activeEmotions[playerID] = emotion;
			timers_Emotion[playerID] = Constants.EMOTION_DURATION;
			
		}
		
		public function update(delta:Number):void 
		{
			if ( _p1ActionDown && !KeyboardController.isPressed_Action(0) ) {
				_p1ActionDown = false;
				handleAction(0);
			} else if ( !_p1ActionDown && KeyboardController.isPressed_Action(0) ) {
				_p1ActionDown = true;
			}
			
			if ( _p2ActionDown && !KeyboardController.isPressed_Action(1) ) {
				_p2ActionDown = false;
				handleAction(1);
			} else if ( !_p2ActionDown && KeyboardController.isPressed_Action(1) ) {
				_p2ActionDown = true;
			}
			
			if (timers_Emotion[0] > 0.0 ) {
				timers_Emotion[0] -= delta;
				if ( timers_Emotion[0] <= 0.0) {
					activeEmotions[0] = Constants.EMOTION_NONE;
					(_players[0] as EntityPlayer).useEmotion(Constants.EMOTION_NONE);
				}
			} 
			
			if (timers_Emotion[1] > 0.0 ) {
				timers_Emotion[1] -= delta;
				if ( timers_Emotion[1] <= 0.0) {
					activeEmotions[1] = Constants.EMOTION_NONE;
					(_players[1] as EntityPlayer).useEmotion(Constants.EMOTION_NONE);
				}
			} 
				
		}
		
		public function isCalm() : Boolean{
			return (((_players[0] as EntityPlayer).getEmotion() == Constants.EMOTION_CALM) || (( _players[1] as EntityPlayer).getEmotion() == Constants.EMOTION_CALM ));
		}
		
		public function push(emotion:int):void {
			waiting.push(emotion);
		}
		
	}

}