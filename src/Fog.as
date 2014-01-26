package  {
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Fog {
		/**
		 * change the resolution of the fog texture in respect to screen size
		 */
		private const FOG_SCALING:Number = 1.0 / 2.0;
		
		
		private var _fogTexture:RenderTexture;
		private var _fogImage:Image;
		private var _viewCircleTexture:Texture;
		private var _viewCircleImage:Image;
		private var _blackQuad:Quad;
		
		private var _pos1:Point = new Point();
		private var _pos2:Point = new Point();
		
		// to draw the whole fog image to the screen texture
		private var _renderMat:Matrix;
		
		// to draw the two view circles to the fog texture		
		private var _viewCircleTransMat:Matrix;
		
		public function Fog() {
			_fogTexture = new RenderTexture(Constants.SCREEN_WIDTH * FOG_SCALING, Constants.SCREEN_HEIGHT * FOG_SCALING, true);
			_fogImage = new Image(_fogTexture);
			_viewCircleTexture = Game.textureAtlas.getTexture("vision_alpha_mask");
			_viewCircleImage = new Image(_viewCircleTexture);
			_viewCircleImage.blendMode = BlendMode.ERASE;
			_blackQuad = new Quad(_fogTexture.width, _fogTexture.height, 0x000000, true);
			
			// texture may be smaller than screen for performance reasons. 
			// when drawing, it has to be scaled up to screen size
			_renderMat = new Matrix();
			_renderMat.scale(1.0 / FOG_SCALING, 1.0 / FOG_SCALING);
			
			_viewCircleTransMat = new Matrix();
		}
		
		/**
		 * can be called very often, as it does not redraw anything, but saves only values for next draw
		 * @param	p1
		 * @param	p2
		 */
		public function setVisibleAreas(p1:Point, p2:Point) : void {
			_pos1.x = p1.x;
			_pos1.y = p1.y;
			_pos2.x = p2.x;
			_pos2.y = p2.y;
		}
		
		public function draw(targetTexture:RenderTexture) : void {
			// refresh fog texture
			refreshFog();
			
			// render to target
			targetTexture.draw(_fogImage, _renderMat);
		}
		
		private function refreshFog():void {
			
			_fogTexture.draw(_blackQuad);
			
			_viewCircleTransMat.identity();			
			
			var x:Number = (_pos1.x - _viewCircleImage.width/2) * FOG_SCALING;
			var y:Number = (_pos1.y - _viewCircleImage.height) * FOG_SCALING;
			x -= 45;
			_viewCircleTransMat.translate(x, y);
			_fogTexture.draw(_viewCircleImage, _viewCircleTransMat);
			
			_viewCircleTransMat.identity();
			
			x = (_pos2.x - _viewCircleImage.width/2) * FOG_SCALING;
			y = (_pos2.y - _viewCircleImage.height) * FOG_SCALING;
			x -= 45;
			_viewCircleTransMat.translate(x, y);
			_fogTexture.draw(_viewCircleImage, _viewCircleTransMat);		
			
		}
	}

}