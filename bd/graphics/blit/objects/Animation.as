package bd.graphics.blit.objects
{
	import bd.graphics.blit.BlitObject;
	import bd.utils.BmpUtils;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class Animation extends BlitObject
	{
		private var _frames:Vector.<int>;
		
		private var _sourceBitmap:Bitmap;
		private var _frameSize:int;
		private var _handlers:Boolean;
		private var _inProgress:Boolean;
		
		private var _currentFrame:int;
		private var _deadFrame:int;
		
		private var _delay:int;
		
		private var _frameCount:int;
		private var _frameProgress:int;
		private var _frameTick:int;
		
		private var _repeatCount:int;
		private var _repeatProgress:int;
		
		private var _fps:int;
		
		public function Animation(sourceBitmap:Bitmap, frameSize:int, deadFrame:int)
		{
			_sourceBitmap = sourceBitmap;
			_frameSize = frameSize;
			_deadFrame = deadFrame;
			_currentFrame = _deadFrame;
			
			super(new BitmapData(_frameSize, _frameSize, true, 0x00000000));
			
			this.drawFrame();
			_inProgress = false;
			_handlers = false;
		}
		
		public function start(frames:Vector.<int>, deadFrame:int, timer:Number, count:int, fps:int):void
		{
			_frames = frames;
			_deadFrame = deadFrame;
			_frameCount = _frames.length + 1;
			_fps = fps;
			
			_repeatCount = count;
			_frameProgress = 0;
			_frameTick = 0;
			
			trace("Starting animation");
			
			if (!_handlers)
			{
				_handlers = true;
				 addEventListener(Event.ENTER_FRAME, animationEnterframe);
			}
			
			_delay = (_fps / _frameCount) * timer;
			_repeatCount = count;
			_inProgress = true;
			_currentFrame = _deadFrame;
			
			this.drawFrame();
		}
		
		private function drawFrame():void
		{
			BmpUtils._rect.setTo(_currentFrame % (_sourceBitmap.width / _frameSize) * _frameSize, int(_currentFrame / (_sourceBitmap.width / _frameSize)) * _frameSize, _frameSize, _frameSize);
			this.display.copyPixels(_sourceBitmap.bitmapData, BmpUtils._rect, BmpUtils._zpoint);
			trace("Drawing (" + _currentFrame + ")");
		}
		
		private function animationEnterframe(e:Event):void
		{
			trace("Enter Frame");
			if (_inProgress)
			{
				_frameProgress++;
				if (_frameProgress >= _delay)
				{
					updateAnimation();
					_frameProgress = 0;
				}
			}
		}
		
		private function updateAnimation():void
		{
			if (_frameTick < _frames.length)
				_currentFrame = _frames[_frameTick];
			else if (_frameTick == _frames.length && _frameTick != _frameCount)
				_currentFrame = _deadFrame;
			else
				finishAnimation();
			
			this.drawFrame();
			_frameTick++;
		}
		
		private function finishAnimation():void
		{
			_repeatProgress += 1;
			if (_repeatProgress < _repeatCount || _repeatCount == 0)
			{
				
				_frameProgress = 0;
				_frameTick = 2;
				_currentFrame = _frames[1];
			}
			else
				stop();
		}
		
		public function stop():void
		{
			if (_inProgress)
			{
				_inProgress = false;
				removeEventListener(Event.ENTER_FRAME, animationEnterframe);
				trace("Animation Completed");
			}
		}
	}
}