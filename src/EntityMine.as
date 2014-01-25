package  
{
	import starling.textures.RenderTexture;
	/**
	 * ...
	 * @author ...
	 */
	public class EntityMine extends Entity
	{
		var _waypoints:Array;
		
		public function EntityMine( waypoints:Array = null )  
		{
			this._waypoints = waypoints;
		}
		
		override public function draw(targetTexture:RenderTexture):void 
		{
			/*super.draw(targetTexture);*/
		}
		
		override public function update(delta:Number):void 
		{
/*			super.update(delta);*/
		}
		
	}

}