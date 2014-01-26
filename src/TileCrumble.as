package  
{
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.TextureSmoothing;
	/**
	 * ...
	 * @author ...
	 */
	public class TileCrumble extends Entity
	{
		private var entityTexNames : Array = ["tile_breakable-floor_01" , "tile_breakable-floor_02", "tile_breakable-floor_03", "tile_breakable-floor_04"];
		private var crumbleTime : Number = Constants.INIT_CRUMBLE_TIME;
		private var isCrumbling : Boolean = false;
		private var crumbleState : int;
		
		public function TileCrumble() 
		{
			crumbleState = 0;
			updateCrumbleTex();
		}
		
		private function updateCrumbleTex():void 
		{			
			entityImage = new Image( Game.textureAtlas.getTexture(entityTexNames[crumbleState]) );
			entityImage.smoothing = TextureSmoothing.NONE;
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			super.draw(targetTexture);
		}
		
		override public function update(delta:Number):void 
		{
			super.update(delta);
			if (isCrumbling) {
				crumbleTime -= delta;
				if (crumbleTime <= 0) {
					crumbleState++;
					if (crumbleState < entityTexNames.length) {
						updateCrumbleTex();
					} else {
						//TODO Handle crumble finish tile
						isCrumbling = false;
						level.changeGrumbleToHole(this.centerTilePos);
					}
					crumbleTime = Constants.INIT_CRUMBLE_TIME;
				}
			}
		}
		
		public function startCrumble():void 
		{
			isCrumbling = true;
		}
	}

}