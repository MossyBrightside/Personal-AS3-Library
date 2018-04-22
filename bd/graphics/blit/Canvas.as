package bd.graphics.blit
{
	import bd.utils.BmpUtils;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class Canvas extends Bitmap
	{
		private var _frameSize:Point;
		private var _background:BlitObject;
		
		private var _layer0:Vector.<BlitObject> = new Vector.<BlitObject>;
		private var _layer1:Vector.<BlitObject> = new Vector.<BlitObject>;
		private var _layer2:Vector.<BlitObject> = new Vector.<BlitObject>;
		
		public function Canvas(frameSize:Point, background:BlitObject):void
		{
			super(new BitmapData(frameSize.x, frameSize.y, true, 0xFF000000));
			_frameSize = frameSize;
			_background = background;
			addEventListener(Event.ENTER_FRAME, redrawHandler);
		}
		
		public function newBackground(newBackground:BlitObject):void
		{
			_background = newBackground;
		}
		
		public function clearLayer(depth:int):void
		{
			for (var i:int = 0; i < this["_layer" + depth].length; i++)
			{
				this["_layer" + depth] = new Vector.<BlitObject>
			}
		}
		
		public function addObject(objBitmap:BlitObject, depth:int):void
		{
			this["_layer" + depth].push(objBitmap);
		}
		
		private function redrawHandler(e:Event):void
		{
			var t:BlitObject;
			
			var bRect:Rectangle = new Rectangle(0, 0, _background.width, _background.height);
			var bPoint:Point = new Point(_background.x, _background.y);
			this.bitmapData.copyPixels(_background.display, bRect, bPoint);
			
			for (var i:int = 0; i < 3; i++)
			{
				for (var o:int = 0; o < this["_layer" + i].length; o++)
				{
					t = this["_layer" + i][o];
					
					bRect.setTo(0, 0, t.width, t.height);
					bPoint.setTo(t.x, t.y);
					this.bitmapData.copyPixels(t.display, bRect, bPoint, null, null, true);
				}
			}
		}
	}
}