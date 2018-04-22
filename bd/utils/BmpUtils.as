package bd.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BmpUtils
	{
		
		// These are just here to be able to have an always available Point/Rectangle object to work with.
		// That way we do not have to recreate it each time.
		// I chose to put these here as Flash isn't going to be updating objects in multiple threads so
		//   instead of each BlitAnimation having it's own set of points/rectangles.  They are meant to be
		//   volatile so never trust what data exists in them.
		
		// _point is meant to be changed.
		public static var _point:Point;
		
		// _zpoint is meant to always point to 0, 0.
		public static var _zpoint:Point;
		
		// _rect is meant to be changed.
		public static var _rect:Rectangle;
		
		// This will need to be called before the objects are used.
		// I could have done this singleton style but why bother with the overhead on every
		//   reference when it's an almost trivial initialization?
		public static function init():void
		{
			_point = new Point(0, 0);
			_zpoint = new Point(0, 0);
			_rect = new Rectangle(0, 0, 0, 0);
		}
		
		/**
		 *
		 * @param	sB:SourceBitmap, the bitmap source to copyPixels from.
		 * @param	fS:FrameSize, the height and width of the frame.
		 * @param	f:Frame, numeric value of the frame (counts from 0).
		 * @return	bmp: Bitmap, returned bitmap of the frame copied from the SourceBitmap.
		 */
		
		public static function drawFrame(sB:Bitmap, fS:int, f:int):Bitmap
		{
			var bmp:Bitmap = new Bitmap(new BitmapData(fS, fS, true));
			var bRect:Rectangle = new Rectangle(f % (sB.width / fS) * fS, int(f / (sB.width / fS)) * fS, fS, fS);
			var bPoint:Point = new Point(0, 0); //BlittingPoint
			
			bmp.bitmapData.copyPixels(sB.bitmapData, bRect, bPoint);
			
			return bmp;
		}
		
		
		/**
		 * 
		 * @param	tileSize: Size of tile ^2
		 * @param	tileArray: Source array of tiledata, binary data
		 * @param	tileSource: Source bitmap for copying pixels
		 * @return
		 */
		public static function drawBitmap(tileSize:int, tileArray:Array, tileSource:BitmapData):Bitmap
		{
			var b:Bitmap = new Bitmap(new BitmapData(tileSize * tileArray[0].length, tileSize * tileArray.length, true));
			var tR:Rectangle = new Rectangle();
			var tP:Point = new Point();
			for (var i:int = 0; i < tileArray.length; i++)
			{
				for (var e:int = 0; e < tileArray[0].length; e++)
				{
					tP.setTo(e * tileSize, i * tileSize);
					tR.setTo(tileArray[i][e] * tileSize, 0, tileSize, tileSize);
					b.bitmapData.copyPixels(tileSource, tR, tP);
				}
			}
			return b;
		}
		
		public static function basicTilemap(tileSize:int):Bitmap
		{
			var b:Bitmap = new Bitmap(new BitmapData(tileSize*2, tileSize));
			
			b.bitmapData.fillRect(new Rectangle(tileSize, 0, tileSize, tileSize), 0xFF000000);
			
			return b;
		}
	}
}