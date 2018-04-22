package bd.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class KeyInput
	{
		
		public static var keys:Object = new Object();
		public static var spaceControl:Boolean = false;
	
		private static var _stage:Stage;
		private static var _wasdKeys:Boolean = false;
		private static var _arrowKeys:Boolean = false;
		private static var _space:Boolean = false;
		
		public static function initialize(stage:Stage, parent:DisplayObject):void
		{
			_stage = stage;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, _keyUp);
		}
		
		public static function addSpace():void
		{
			_space = true;
		}
		
		public static function addWASD():void
		{
			_wasdKeys = true;
			keys.W = false;
			keys.A = false;
			keys.S = false;
			keys.D = false;
			
			if (_arrowKeys)
				_arrowKeys = false;
		}
		
		public static function addArrows():void
		{
			_arrowKeys = true;
			keys.UP = false;
			keys.DOWN = false;
			keys.LEFT = false;
			keys.RIGHT = false;
			
			if (_wasdKeys)
				_wasdKeys = false;
		}
		
		public static function destroy():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, _keyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, _keyUp);
			keys = new Object();
			_stage = null;
			_space = false;
			_wasdKeys = false;
			_arrowKeys = false;
			spaceControl = false;
		}
		
		private static function _keyDown(e:KeyboardEvent):void
		{
			keys[e.keyCode.toString()] = true;
			
			if (_space == true)
			{
				switch (e.keyCode)
				{
				case 32:
					keys.SPACE = true;
					break;
				}
			}
			
			if (_wasdKeys == true)
			{
				switch (e.keyCode)
				{
				case 87: //W
					keys.W = true;
					break;
				case 65: //A
					keys.A = true;
					break;
				case 83: //S
					keys.S = true;
					break;
				case 68: //D
					keys.D = true;
					break;
				}
			}
			if (_arrowKeys == true)
			{
				switch (e.keyCode)
				{
				case 37: 
					keys.LEFT = true;
					break;
				case 38: 
					keys.UP = true;
					break;
				case 39: 
					keys.RIGHT = true;
					break;
				case 40: 
					keys.DOWN = true;
					break;
				}
			}
		}
		
		private static function _keyUp(e:KeyboardEvent):void
		{
			keys[e.keyCode.toString()] = false;
			
			if (_space == true)
			{
				switch (e.keyCode)
				{
				case 32: 
					spaceControl = false;
					keys.SPACE = false;
					break;
				}
			}
			
			if (_wasdKeys == true)
			{
				switch (e.keyCode)
				{
				case 87: 
					keys.W = false;
					break;
				case 65: 
					keys.A = false;
					break;
				case 83: 
					keys.S = false;
					break;
				case 68: 
					keys.D = false;
					break;
				}
			}
			if (_arrowKeys == true)
			{
				switch (e.keyCode)
				{
				case 37: 
					keys.LEFT = false;
					break;
				case 38: 
					keys.UP = false;
					break;
				case 39: 
					keys.RIGHT = false;
					break;
				case 40: 
					keys.DOWN = false;
					break;
				}
			}
		}
	
	}
}