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
	public class EntityMine extends Entity
	{
		private var _epsilon : Number = 10;
		private var _waypoints:Array;
		private var _speed:Number = 400;
		private var currentWaypoint:int = 0;
		private var nextWaypoint:int = 1;
		private var _numOfWaypoints:int = 0;
		private var entityTexName : Array = ["tile_spikes_01", "tile_spikes_02"];
		private var texID : int = 0;
		private var changeTex : Number = 0;
		private var direction : Point;
		
		public function EntityMine( waypoints:Array = null )  
		{
			this._waypoints = waypoints;
			this._numOfWaypoints = waypoints.length;
			
			updateTexture();
			
			setTile(_waypoints[0].x, _waypoints[1].y);
			updateDirection();
		}
		
		private function updateTexture () {
			if (texID == 0 ) {
				texID = 1;
			} else {
				texID = 0;
			}
			
			entityImage = new Image( Game.textureAtlas.getTexture(entityTexName[texID]) );
			entityImage.smoothing = TextureSmoothing.NONE;
		}
		
		private function updateDirection():void {
			direction = new Point ( _waypoints[nextWaypoint].x - _waypoints[currentWaypoint].x,
				_waypoints[nextWaypoint].y - _waypoints[currentWaypoint].y);
			if(direction.x != 0)
				direction.x /= Math.abs(direction.x);
			if(direction.y != 0)
				direction.y /= Math.abs(direction.y);
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			offsetX = -Constants.TILE_SIDE_SIZE;
			offsetY = -Constants.TILE_SIDE_SIZE;
		
			super.draw(targetTexture);
		}
		
		override public function update(delta:Number):void 
		{
			super.update(delta);
			var dx:Number = direction.x * delta * _speed;
			var dy:Number = direction.y * delta * _speed;
			
			if (changeTex > 0.3) {
				updateTexture();
				changeTex = 0.0;
			}
			
			centerPixelPos.x += dx;
			centerPixelPos.y += dy;
			updateBoundingBox();
			
			var wp : Point = Entity.getPixelFromTile(_waypoints[nextWaypoint].x, _waypoints[nextWaypoint].y);
			
			if ((Math.abs( centerPixelPos.x - wp.x ) < _epsilon) && (Math.abs (centerPixelPos.y - wp.y ) < _epsilon)) {
				//Reached Waypoint
				this.currentWaypoint = (currentWaypoint + 1) % _numOfWaypoints;
				this.nextWaypoint = (nextWaypoint + 1) % _numOfWaypoints;
				
				updateDirection();
			}
			
			changeTex += delta;
		}
	}
}