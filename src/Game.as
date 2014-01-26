package  {
	
	
	import starling.display.Image;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.text.TextField;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Game extends Sprite {
		
		[Embed(source = "../levels/level6.txt", mimeType = "application/octet-stream")] public var LEVEL6:Class;
		[Embed(source = "../levels/level5.txt", mimeType = "application/octet-stream")] public var LEVEL5:Class;
		[Embed(source = "../levels/level4.txt", mimeType = "application/octet-stream")] public var LEVEL4:Class;
		[Embed(source = "../levels/level3.txt", mimeType = "application/octet-stream")] public var LEVEL3:Class;
		[Embed(source = "../levels/level2.txt", mimeType = "application/octet-stream")] public var LEVEL2:Class;
		[Embed(source = "../levels/level1.txt", mimeType = "application/octet-stream")] public var LEVEL1:Class;

		// Embed the Atlas XML
		[Embed(source="../assets/atlas.xml", mimeType="application/octet-stream")] public static const AtlasXml:Class;
		// Embed the Atlas Texture:
		[Embed(source="../assets/atlas.png")] public static const AtlasTexture:Class;
		
		public static var textureAtlas:TextureAtlas;
		
		private var renderTexture : RenderTexture;
		private var renderImage : Image;
		
		private var bgImage : Image;
		
		private var currentLevel:Level;
		private var _currentGameTimeMillis:Number = 0;
		private var _timeLastStepMillis:Number = 0;
		
		private var intro : Intro;
		private var levelComplete : LevelComplete;
		
		public static var _fog:Fog;
		
		private var levels : Vector.<ByteArray>  = new Vector.<ByteArray>;
		private var currentLevelID : int = 0;
		
		private var restartIsPressed : Boolean = false;
		
		public function Game() {
			
			levels.push(new LEVEL1() as ByteArray, new LEVEL2() as ByteArray, new LEVEL3() as ByteArray,
				new LEVEL4() as ByteArray, new LEVEL5() as ByteArray, new LEVEL6() as ByteArray);
			
			// create texture atlas
			var texture : Texture = Texture.fromBitmap(new AtlasTexture());
			var xml:XML = XML(new AtlasXml());
			textureAtlas = new TextureAtlas(texture, xml);
			
			//Init render Texture and Image
			renderTexture = new RenderTexture(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT, true);
			renderImage = new Image(renderTexture);
			//... and add it to our game :)
			this.addChild(renderImage);
			//and BG Image
			bgImage = new Image( Game.textureAtlas.getTexture("background_stars"));

			//Init KeyboardController
			KeyboardController.initalize();
			
			// init FOG
			_fog = new Fog();

			
			//Init intro
			intro = new Intro();
				
			//Init Level
			currentLevel = new Level(this);
			currentLevel.initialize(levels[currentLevelID].toString());
			
			// Init level complete animation
			levelComplete = new LevelComplete(this);
			
			_timeLastStepMillis = new Date().getTime();
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		public function startNextLevel() : void {
			currentLevelID++;
			levelComplete.reset();
			levelComplete.isRunning = true;
			//startCurrentLevel();
			
		}
		
		public function startCurrentLevel() : void {
			currentLevel = new Level(this);
			currentLevel.initialize(levels[currentLevelID].toString());
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void {
			update();
			draw();	
		}
				
		private function update() : void {
					
			var nowMillis:Number = new Date().getTime();
			var millisSinceLastFrame:Number = nowMillis - _timeLastStepMillis;
			var millisToGoThisFrame:Number = millisSinceLastFrame;
			
			
			while ( millisToGoThisFrame > 0 ) {
				
				var deltaMillis:Number = Math.min(Constants.TICK_DURSTION, millisToGoThisFrame);
				var delta:Number = deltaMillis / 1000.0;
				
				if (intro.isRunning) {
					intro.update(delta);
				} else if (!levelComplete.isRunning) {
					// update game logic
					currentLevel.update(delta);

					if( currentLevel.p1 && currentLevel.p2 ) {
						_fog.setVisibleAreas( currentLevel.p1.getPivotPoint(), currentLevel.p2.getPivotPoint() );
					}

				} else {
					levelComplete.update(delta);

				}
				
				_currentGameTimeMillis += deltaMillis;
				millisToGoThisFrame -= deltaMillis;
			}
			
			_timeLastStepMillis = nowMillis;
			
			//If reset key is pressed restart current level
			if (KeyboardController.isPressed_Reset() && !restartIsPressed) {
				restartIsPressed = true;
			}
			
			if (!KeyboardController.isPressed_Reset() && restartIsPressed) {
				restartIsPressed = false;
				startCurrentLevel();
			}
			
		}
		
		public function draw() : void {
			renderTexture.drawBundled(function() : void {
				renderTexture.draw(bgImage);
				if (intro.isRunning) {
					intro.draw(renderTexture);
				} else {
					currentLevel.draw(renderTexture);

					if (levelComplete.isRunning) {
						levelComplete.draw(renderTexture);
					}
				}
			});
			
			if (!intro.isRunning && !levelComplete.isRunning) {
				_fog.draw(renderTexture);
				currentLevel.drawHUD(renderTexture);
			}
		}
	}
}