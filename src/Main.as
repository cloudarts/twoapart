package {
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	/**
	 * ...
	 * @author W. A. Jurczyk
	 */
	public class Main extends Sprite {
		
		private var _starling:Starling;
		
		public function Main():void {
			var viewPort:Rectangle = RectangleUtil.fit(
                new Rectangle(0, 0, 1280, 800), 
                new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
                ScaleMode.SHOW_ALL);
				
			_starling = new Starling(Game, stage, viewPort);
            _starling.stage.stageWidth  = 1280; 
            _starling.stage.stageHeight = 800;
            _starling.simulateMultitouch  = false;
            _starling.enableErrorChecking = Capabilities.isDebugger;
			Starling.current.showStats = false;
            
            _starling.start();
            
            
		}
		
	}
	
}