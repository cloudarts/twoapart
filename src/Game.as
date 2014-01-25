package  {
	
	
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Game extends Sprite {
						
		private var currentLevel:Level;
		
		public function Game() {
			var textField:TextField = new TextField(400, 300, "Welcome to Starling!");
			addChild(textField);	
			textField.color = 0xffffff;
			
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