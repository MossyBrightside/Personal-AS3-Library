package bd.graphics.blit
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class BlitObject extends EventDispatcher
	{
		public var x:int = 0;
		public var y:int = 0;
		public var height:int = 0;
		public var width:int = 0;
		public var display:BitmapData;
		
		public function BlitObject(display:BitmapData)
		{
			this.display = display;
			setVars();
		}
		
		private function setVars():void
		{
			height = display.width;
			width = display.width;
		}
		
		private function update():void
		{
			
		}
	}
}