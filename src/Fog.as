package  {
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Fog {
		
		private const FOG_SCALING:Number = 1.0 / 2.0;
		
		private const VIEW_CIRCLE_SCALE:Number = 1.0;
		
		private var _fogTexture:RenderTexture;
		private var _fogImage:Image;
		private var _viewCircleTexture:Texture;
		private var _viewCircleImage:Image;
		
		private var _pos1:Point = null;
		private var _pos2:Point = null;
		
		// to draw the whole fog image to the screen texture
		private var _renderMat:Matrix;
		
		// to draw the two view circles to the fog texture
		private var _viewCircleMat:Matrix;
		
		private var _viewCircleScaleMat:Matrix;
		private var _viewCircleTransMat:Matrix;
		
		public function Fog() {
			_fogTexture = new RenderTexture(Constants.SCREEN_WIDTH * FOG_SCALING, Constants.SCREEN_HEIGHT * FOG_SCALING, false);
			_fogImage = new Image(_fogTexture);
			_viewCircleTexture = Game.textureAtlas.getTexture("vision_alpha_mask");
			_viewCircleImage = new Image(_viewCircleTexture);
			_viewCircleImage.blendMode = BlendMode.ERASE;
			
			// texture may be smaller than screen for performance reasons. 
			// when drawing, it has to be scaled up to screen size
			_renderMat = new Matrix();
			_renderMat.scale(1.0 / FOG_SCALING, 1.0 / FOG_SCALING);
			
			_viewCircleMat = new Matrix();
			_viewCircleScaleMat = new Matrix();
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
			_fogTexture.clear(0x000000, 1);
			
			_viewCircleMat.identity();
			_viewCircleScaleMat.identity();
			_viewCircleTransMat.identity();
			
			_viewCircleScaleMat.scale(VIEW_CIRCLE_SCALE * FOG_SCALING, VIEW_CIRCLE_SCALE * FOG_SCALING);
			
			var x:Number = (_pos1.x - _viewCircleTexture.width) * FOG_SCALING;
			var y:Number = (_pos1.y - _viewCircleTexture.height) * FOG_SCALING;
			_viewCircleTransMat.translate(x, y);
			_viewCircleMat.concat(_viewCircleScaleMat);
			_viewCircleMat.concat(_viewCircleTransMat);
			_fogTexture.draw(_viewCircleImage, _viewCircleMat);
			
			x = (_pos2.x - _viewCircleTexture.width) * FOG_SCALING;
			y = (_pos2.y - _viewCircleTexture.height) * FOG_SCALING;
			_viewCircleTransMat.translate(x, y);
			_viewCircleMat.concat(_viewCircleScaleMat);
			_viewCircleMat.concat(_viewCircleTransMat);
			_fogTexture.draw(_viewCircleImage, _viewCircleMat);			
		}
	}

}