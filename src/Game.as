package  {
	
	
	import starling.display.Image;
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
		
		// Embed the Atlas XML
		[Embed(source="../assets/atlas.xml", mimeType="application/octet-stream")]
		public static const AtlasXml:Class;
		// Embed the Atlas Texture:
		[Embed(source="../assets/atlas.png")]
		public static const AtlasTexture:Class;
		
		public static var textureAtlas:TextureAtlas;
		
		private var renderTexture : RenderTexture;
		private var renderImage : Image;
		
		private var currentLevel:Level;
		
		public function Game() {
			var textField:TextField = new TextField(400, 300, "Welcome to Starling!");
			addChild(textField);	
			textField.color = 0xffffff;
			
			// create texture atlas
			var texture : Texture = Texture.fromBitmap(new AtlasTexture());
			var xml:XML = XML(new AtlasXml());
			textureAtlas = new TextureAtlas(texture, xml);
			
			//Init render Texture and Image
			renderTexture = new RenderTexture(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
			renderImage = new Image(renderTexture);
			//... and add it to our game :)
			this.addChild(renderImage);
			
			//TODO !
			currentLevel = new Level();
			
			this.addEventListener(EnterFrameEvent, onEnterFrame);
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void {
			update();
			draw();	
		}
		
		private function update() : void {
			if ( _waitingForRestart ) {
				return;
			}
			
			var nowMillis:Number = new Date().getTime();
			var millisSinceLastFrame:Number = nowMillis - _timeLastStepMillis;
			var millisToGoThisFrame:Number = millisSinceLastFrame;
			
			while ( millisToGoThisFrame > 0 ) {
				if ( _waitingForRestart ) {
					break;
				}
				var deltaMillis:Number = Math.min(Constants.DURATION_PER_STEP_IN_MILLIS, millisToGoThisFrame);
				var delta:Number = deltaMillis / 1000.0;
				
				// update game logic
				
				
				_currentGameTimeMillis += deltaMillis;
				millisToGoThisFrame -= deltaMillis;
			}
			
			_timeLastStepMillis = nowMillis;
		}
		
		public function draw() : void {
			// draw stuff
		}
		
		
		
	}

}