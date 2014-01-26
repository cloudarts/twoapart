package  
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;
	/**
	 * ...
	 * @author ...
	 */
	public class EntityPlayer extends Entity
	{	
		private const STATE_NORMAL : int 	= 0;
		private const STATE_WALK : int 		= 1;
		
		private var _playerID : int;
		private var _stateID : int; 
		private var _directionID : int;
		private var _direction : Point;
		private var _animationID : int;
		
		private var speed : Point;
		private var acceleration : Point;
		private var maxSpeed : Number  = 100 ;
		private var increaseAccl : Number = 500;
		private var friction : Number = 0.9;
		
		private var animationUpdate : Number = 0;
		
		private var texPlayerTag : Array = ["fire_", "water_"];
		private var texStateTag : Array = ["normal_", "walk_"]
		private var texDirectionTag : Array = ["front_left", "back_left"];
		private var texAnimation : Array = ["","_01", "_02"];
		
		private var entityTexName:String;
		
		public function EntityPlayer( playerID : int ) 
		{
			this._playerID = playerID;
			_stateID = 0;
			_directionID = 0;
			_direction = new Point( - 1, 1);
			_animationID = 0;
			
			updatePlayerTex();
			
			speed = new Point( 0 , 0 ); // <-- Eule
			acceleration = new Point( 0 , 0 );
		}
		
		private function updatePlayerTex():void 
		{
			entityTexName = "" + texPlayerTag[_playerID] + texStateTag[_stateID] 
				+ texDirectionTag[_directionID] + texAnimation[_animationID];
			var i:int = 0;
			entityImage = new Image( Game.textureAtlas.getTexture(entityTexName) );
			entityImage.smoothing = TextureSmoothing.NONE;
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			super.draw(targetTexture);
		}
		
		override public function update(delta:Number):void 
		{
			super.update(delta);
			
			handleMovement(delta);
			handleState();
			handleDirection();
			handleAnimation(delta);
			/*time += delta;
			offsetX = 5 * Math.sin(time);
			offsetY = 5 * Math.cos(offsetX * time);*/
		}
		
		private function handleState() : void {
			if (speed.x < -1.5 || speed.x > 1.5 || speed.y < -1.5 || speed.y > 1.5) {
				_stateID = STATE_WALK;
			} else {
				_stateID = STATE_NORMAL;
			}
		}
		
		private function handleDirection() : void {
			
			this.world.scale( _direction.x , _direction.y );
			//updatePlayerTex();
		}
		
		private function handleAnimation(delta) : void {
			animationUpdate += delta;
			
			if(animationUpdate > 0.4){
				switch ( _stateID ) {
					case STATE_NORMAL:
						_animationID = 0;
						break;
					case STATE_WALK:
						if ( _animationID == 2 ) {
							_animationID = 1;
						} else {
							_animationID = 2;
						}						
						break;
					default:
						break;
				}
				updatePlayerTex();
				animationUpdate = 0;
			}				
		}
		
		private function handleMovement(delta : Number) : void {
			var down : int = 0;
			var up : int = 0;
			var left : int = 0;
			var right : int = 0;
			
			if ( KeyboardController.isPressed_Down(playerID) ) 
				down = 1;
			if ( KeyboardController.isPressed_Left(playerID) )
				left = 1;
			if ( KeyboardController.isPressed_Right(playerID) )
				right = 1;
			if ( KeyboardController.isPressed_Up(playerID) )
				up = 1;
				
			acceleration.x = (right - left) * increaseAccl;
			acceleration.y = (down - up) * increaseAccl;
			
			if ( right == 1 ) {
				_direction.x = 1;
			} else {
				_direction.x = -1;
			}
			
			if ( down == 1) {
				_direction.y = 1;
				_directionID = 0;
			} else {
				_direction.y = -1;
				_directionID = 1;
			}
			
			//trace("AXEL" + acceleration);
			
			speed.x += delta * acceleration.x;
			speed.y += delta * acceleration.y;
			
			speed.x *= friction;
			speed.y *= friction;
			
			speed.x = Math.min( speed.x, maxSpeed);
			speed.y = Math.min( speed.y, maxSpeed);
			speed.x = Math.max( speed.x, -1 * maxSpeed);
			speed.y = Math.max( speed.y, -1 * maxSpeed);
			
			
			//trace("Speed" + speed);
			
			centerPixelPos.x += speed.x * delta;
			centerPixelPos.y += speed.y * delta;
			
			//trace("PixelPos" + centerPixelPos);
		}
		
		public function get playerID():int 
		{
			return _playerID;
		}
		
		public function set playerID(value:int):void 
		{
			_playerID = value;
			updatePlayerTex();
		}
		
		public function get stateID():int 
		{
			return _stateID;
		}
		
		public function set stateID(value:int):void 
		{
			_stateID = value;
			updatePlayerTex();
		}
		
		public function get directionID() : int 
		{
			return _directionID;
		}
		
		public function set directionID( value : int ) : void 
		{
			_directionID = value;
			updatePlayerTex();
		}
		
		public function get direction() : Point 
		{
			return _direction;
		}
		
		public function set direction( value : Point ) : void 
		{
			_direction = value;
			updatePlayerTex();
		}
		
		public function get animationID():int 
		{
			return _animationID;
		}
		
		public function set animationID(value:int):void 
		{
			_animationID = value;
			updatePlayerTex();
		}
	}
}