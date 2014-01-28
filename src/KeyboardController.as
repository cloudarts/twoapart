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
		 * Defines the Keyboard Key to Restart a Level
		 */
		public static const KEY_RESET: uint 	= Keyboard.BACKSPACE;
		
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
		
		//Variable defines status of Backspace
		private static var _KeyResetPressed: Boolean = false;
		
		//Variable defines status of Player 1 keys
		private static var _p1KeyUpPressed : Boolean 		= false;
		private static var _p1KeyDownPressed : Boolean 		= false;
		private static var _p1KeyLeftPressed : Boolean 		= false;
		private static var _p1KeyRightPressed : Boolean 	= false;
		private static var _p1KeyActionPressed : Boolean 	= false;
		
		//Variable defines status of Player 2 keys
		private static var _p2KeyUpPressed : Boolean 		= false;
		private static var _p2KeyDownPressed : Boolean 		= false;
		private static var _p2KeyLeftPressed : Boolean		= false;
		private static var _p2KeyRightPressed : Boolean 	= false;
		private static var _p2KeyActionPressed : Boolean 	= false;
		
		public function KeyboardController() 
		{
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public static function initalize() : void {
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		/**
		 *	Is called if a keyboard key is pressed down 
		 * 	Sets the boolean on true if a used key is pressed
		 */
		public static function onKeyDown(event:KeyboardEvent) : void {
			
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
				case KEY_RESET:
					_KeyResetPressed = true;
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
		public static function onKeyUp(event:KeyboardEvent): void {
			
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
				case KEY_RESET:
					_KeyResetPressed = false;
					break;
				default:
					trace("Unused Key");
					break;
			}
		}
		
		public static function isPressed_Reset() : Boolean {
			return _KeyResetPressed;
		}
		
		public static function isPressed_Up(playerID : int) : Boolean {
			if( playerID == 1 )
				return _p1KeyUpPressed;
			
			return _p2KeyUpPressed;
		}
		
		public static function isPressed_Down(playerID : int) : Boolean {
			if( playerID == 1 )
				return _p1KeyDownPressed;
				
			return _p2KeyDownPressed;
		}
		
		public static function isPressed_Left(playerID : int) : Boolean {
			if( playerID == 1 )
				return _p1KeyLeftPressed;
				
			return _p2KeyLeftPressed;
		}
		
		public static function isPressed_Right(playerID : int) : Boolean {
			if( playerID == 1 )
				return _p1KeyRightPressed;
			
			return _p2KeyRightPressed;
		}
		
		public static function isPressed_Action(playerID : int) : Boolean {
			if( playerID == 1 )
				return _p1KeyActionPressed;
				
			return _p2KeyActionPressed;
		}
		
	}

}