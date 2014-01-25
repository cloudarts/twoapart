package  {
	
	
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Game extends Sprite {
		
		[Embed(source="../levels/level6.txt",mimeType="application/octet-stream")] public var LEVEL6:Class;
						
		private var currentLevel:Level;
		private var _currentGameTimeMillis:Number = 0;
		private var _timeLastStepMillis:Number = 0;
		
		public function Game() {
			var textField:TextField = new TextField(400, 300, "Welcome to Starling!");
			addChild(textField);	
			textField.color = 0xffffff;
			var txt:ByteArray = new LEVEL6() as ByteArray;
			currentLevel = new Level();
			currentLevel.initialize(txt.toString());
			
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
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