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
		private var _playerID : int;
		private var _stateID : int; 
		private var _directionID : int; 
		private var _animationID : int;
		
		private var speed : Point;
		private var acceleration : Point;
		
		private var texPlayerTag : Array = ["fire_", "water_"];
		private var texStateTag : Array = ["normal_", "walk_"]
		private var texDirectionTag : Array = ["front_left", "front_right", "back_left", "back_right"];
		private var texAnimation : Array = ["","_01", "_02"];
		
		private var entityTexName:String;
		
		public function EntityPlayer( playerID : int ) 
		{
			this.playerID = playerID;
			stateID = 0;
			directionID = 0;
			animationID = 0;
			
			updatePlayerTex();
			
			speed = new Point( 0 , 0 );
			acceleration = new Point( 0 , 0 );
		}
		
		private function updatePlayerTex():void 
		{
			entityTexName = texPlayerTag[playerID] + texStateTag[stateID] 
				+ texDirectionTag[directionID] + texAnimation[animationID];
			
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
			/*time += delta;
			offsetX = 5 * Math.sin(time);
			offsetY = 5 * Math.cos(offsetX * time);*/
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
		
		public function get directionID():int 
		{
			return _directionID;
		}
		
		public function set directionID(value:int):void 
		{
			_directionID = value;
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