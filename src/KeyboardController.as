package  
{
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.events.KeyboardEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class KeyboardController 
	{
	
		/**
		 * Keyboard controlls player 1 
		 */
		public static const P1_KEY_UP:uint 		= Keyboard.UP;
		public static const P1_KEY_DOWN:uint 	= Keyboard.DOWN;
		public static const P1_KEY_LEFT:uint 	= Keyboard.LEFT;
		public static const P1_KEY_RIGHT:uint 	= Keyboard.RIGHT;
		public static const P1_KEY_ACTION:uint 	= Keyboard.SPACE;
		
		/**
		 * Keyboard controlls player 2 
		 */
		public static const P2_KEY_UP:uint 		= Keyboard.W;
		public static const P2_KEY_DOWN:uint 	= Keyboard.S;
		public static const P2_KEY_LEFT:uint 	= Keyboard.A;
		public static const P2_KEY_RIGHT:uint 	= Keyboard.D;
		public static const P2_KEY_ACTION:uint 	= Keyboard.CONTROL;
		
		//Variable defines status of Player 1 keys
		private var _p1KeyUpPressed, _p1KeyDownPressed, _p1KeyLeftPressed, _p1KeyRightPressed, _p1KeyActionPressed:Boolean = false;
		
		//Variable defines status of Player 2 keys
		private var _p2KeyUpPressed, _p2KeyDownPressed, _p2KeyLeftPressed, _p2KeyRightPressed, _p2KeyActionPressed:Boolean = false;
		
		public function KeyboardController() 
		{
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		/**
		 *	Is called if a keyboard key is pressed down 
		 * 	Sets the boolean on true if a used key is pressed
		 */
		public function onKeyDown(event:KeyboardEvent) : void {
			
			switch(event.keyCode) {
				case P1_KEY_UP:
					_p1KeyUpPressed = true;
					break;
				case P1_KEY_DOWN:
					_p1KeyDownPressed = true;
					break;
				case P1_KEY_LEFT:
					_p1KeyLeftPressed = true;
					break;
				case P1_KEY_RIGHT:
					_p1KeyRightPressed = true;
					break;
				case P1_KEY_ACTION:
					_p1KeyActionPressed = true;
					break;
				case P2_KEY_UP:
					_p2KeyUpPressed = true;
					break;
				case P2_KEY_DOWN:
					_p2KeyDownPressed = true;
					break;
				case P2_KEY_LEFT:
					_p2KeyLeftPressed = true;
					break;
				case P2_KEY_RIGHT:
					_p2KeyRightPressed = true;
					break;
				case P2_KEY_ACTION:
					_p2KeyActionPressed = true;
					break;
				default:
					trace("Unused Key");
					break;
			}
			
			
		}
		
		/**
		 *	Is called if a keyboard key is released 
		 * 	Sets the boolean on false if a used key is released
		 */
		public function onKeyUp(event:KeyboardEvent): void {
			
			switch(event.keyCode) {
				case P1_KEY_UP:
					_p1KeyUpPressed = false;
					break;
				case P1_KEY_DOWN:
					_p1KeyDownPressed = false;
					break;
				case P1_KEY_LEFT:
					_p1KeyLeftPressed = false;
					break;
				case P1_KEY_RIGHT:
					_p1KeyRightPressed = false;
					break;
				case P1_KEY_ACTION:
					_p1KeyActionPressed = false;
					break;
				case P2_KEY_UP:
					_p2KeyUpPressed = false;
					break;
				case P2_KEY_DOWN:
					_p2KeyDownPressed = false;
					break;
				case P2_KEY_LEFT:
					_p2KeyLeftPressed = false;
					break;
				case P2_KEY_RIGHT:
					_p2KeyRightPressed = false;
					break;
				case P2_KEY_ACTION:
					_p2KeyActionPressed = false;
					break;
				default:
					trace("Unused Key");
					break;
			}
		}
		
		
		public function isPressed_p1Up() : Boolean {
			return _p1KeyUpPressed;
		}
		
		public function isPressed_p1Down() : Boolean {
			return _p1KeyDownPressed;
		}
		
		public function isPressed_p1Left() : Boolean {
			return _p1KeyLeftPressed;
		}
		
		public function isPressed_p1Right() : Boolean {
			return _p1KeyRightPressed;
		}
		
		public function isPressed_p1Action() : Boolean {
			return _p1KeyActionPressed;
		}
		
		public function isPressed_p2Up() : Boolean {
			return _p2KeyUpPressed;
		}
		
		public function isPressed_p2Down() : Boolean {
			return _p2KeyDownPressed;
		}
		
		public function isPressed_p2Left() : Boolean {
			return _p2KeyLeftPressed;
		}
		
		public function isPressed_p2Right() : Boolean {
			return _p2KeyRightPressed;
		}
		
		public function isPressed_p2Action() : Boolean {
			return _p2KeyActionPressed;
		}
	}

}