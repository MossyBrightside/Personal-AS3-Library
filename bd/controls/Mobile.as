package bd.controls
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import flash.geom.Point;
	
	import flash.sensors.Accelerometer;
	import flash.events.AccelerometerEvent;
	
	import flash.events.TouchEvent;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Mobile
	{
		private static var _stage:Stage;
		private static var _acc:Accelerometer = new Accelerometer();
		private static var _dpad:MovieClip;
		private static var _touchMode:Boolean = true;
		private static var _tiltMode:Boolean = false;
		public static var dir:Point;
		
		private static var _traceText:TextField;
		
		public static function initialize(s:Stage, r:int):void
		{
			_stage = s;
			_acc.addEventListener(AccelerometerEvent.UPDATE, accelerometerDpad);
			_acc.setRequestedUpdateInterval(50);
			addDpad(r);
			addTrace();
		}
		
		private static function addDpad(r:int):void
		{
			_dpad = new DpadGraphic();
			
			_dpad.width = r;
			_dpad.height = r;
			_dpad.x = 250;
			_dpad.y = 350;
			dir = new Point(0, 0);
			_stage.addChild(_dpad);
			_dpad.addEventListener(TouchEvent.TOUCH_MOVE, touchDpad);
		}
		
		private static function addTrace():void
		{
			var tf:TextFormat = new TextFormat(null, 35, 0xFFFFFF);
			_traceText = new TextField();
			_traceText.text = "Debugger";
			_traceText.borderColor = 0xFFFFFF;
			_traceText.border = true;
			_traceText.x = 5;
			_traceText.y = 5;
			_traceText.height = 150;
			_traceText.width = 150;
			_traceText.defaultTextFormat = tf;
			_stage.addChild(_traceText);
		}
		
		private static function changeTrace(t:String):void
		{
			_traceText.text = t;
		}
		
		private static function touchDpad(e:TouchEvent):void
		{
			if (_touchMode == true)
			{
				var r:Number = Math.atan2(e.localX, e.localY);
				var d:Number = r * 180 / Math.PI;
				_dpad.ret.rotation = -d;
				
				_dpad.ret.x = int(0 + e.localX);
				_dpad.ret.y = int(0 + e.localY);
				
				//changeTrace("(" + e.localX.toString() + "," + e.localY.toString() + ")");
				changeTrace(d.toString());
			}
		}
		
		private static function accelerometerDpad(e:AccelerometerEvent):void
		{
			if (_tiltMode == true)
			{
				var r:Number = Math.atan2(e.accelerationX * 40, e.accelerationY * 40);
				var d:Number = r * 180 / Math.PI;
				_dpad.ret.rotation = d;
				
				_dpad.ret.x = int(0 - e.accelerationX * 40);
				_dpad.ret.y = int(0 + e.accelerationY * 40);
				
				if (int(0 - e.accelerationX * 40) >= 7)
					dir.x = 1;
				else if (int(0 - e.accelerationX * 40) <= -7)
					dir.x = -1;
				else
					dir.x = 0;
				
				if (int(0 - e.accelerationY * 40) >= 7)
					dir.y = 1;
				else if (int(0 - e.accelerationY * 40) <= -7)
					dir.y = -1;
				else
					dir.y = 0;
				
				changeTrace("X:" + int(0 - e.accelerationX * 40).toString() + "\nY:" + int(0 + e.accelerationY * 40).toString() + "\nDir" + "(" + dir.x.toString() + "," + dir.y.toString() + ")");
			}
		
		}
	
	}
}