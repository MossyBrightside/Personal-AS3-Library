package bd.utils
{
	import bd.graphics.blit.BlitObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	public class CollisionUtils
	{
		private static var _collisionData:Array; //CollisionData
		private static var _tileSize:int;
		private static var _objectPoint:Point; //ObjectPosition
		
		public static function Initialize(collisionData:Array, tileSize:int):void
		{
			_collisionData = collisionData;
			_tileSize = tileSize;
		}
		
		private static function getObjectCorners(playerObject:DisplayObject):Array
		{aa
			var c:Array = new Array([[], []], [[], []]);
			c[0][0] = new Point(playerObject.x, playerObject.y); //TOP LEFT
			c[0][1] = new Point(playerObject.x + playerObject.width, playerObject.y); //TOP RIGHT
			c[1][0] = new Point(playerObject.x, playerObject.y + playerObject.height); //BOTTOM LEFT
			c[1][1] = new Point(playerObject.x + playerObject.width, playerObject.y + playerObject.height); //BOTTOM RIGHT
			return c;
		}
		
		public static function circleCollision(objOne:DisplayObject, objTwo:DisplayObject):Boolean
		{
			
			var collisionStatus:Boolean = false;
			var distance:Number = 0;
			var tolerance:Number = 0;
			
			tolerance = objTwo.width / 2 + objOne.width / 2;
			distance = Math.sqrt((objTwo.x - objOne.x) ^ 2 + (objTwo.y - objTwo.y) ^ 2);
			
			if (tolerance <= distance)
				collisionStatus = true;
			
			return collisionStatus
		}
		
		/**
		 *
		 * @param	playerObject
		 * @param	objectChange:Change
		 * @param	axis:Axis
		 * @return
		 */
		public static function checkCollision(playerObject:DisplayObject, objectChange:int, axis:String):Boolean
		{
			var collisionReturn:Boolean = false;
			var objectCorners:Array = getObjectCorners(playerObject);
			var t:Point = new Point(0, 0);
			var v:int = 0;
			var b:int = (objectChange > 0) ? 1 : -1;	//DIRECTION CONTROL VARIABLE
			var b2:int = (objectChange > 0) ? 1 : 0;	//DIRECTION CONTROL VARIABLE
			if (axis == "x")
			{
				for (var e:int = 0; e < 2; e++)
				{
					t.x = (Math.floor(objectCorners[e][b2].x / _tileSize));
					t.y = (Math.floor(objectCorners[e][b2].y / _tileSize));
					if (b == 1)
						if (t.x + b > _tileSize / 2)
							v = 1;
						else
							v = _collisionData[t.y][t.x + b];
					else if (b == -1)
						if (t.x + b < 0)
							v = 1;
						else
						{
							v = _collisionData[t.y][t.x + b];
						}
					
					if (v == 1)
					{
						t.x = (t.x + b2) * _tileSize;
						t.y = (t.y) * _tileSize;
						
						if (b == 1)
						{
							if (objectCorners[e][b2].x + objectChange >= t.x)
							{
								playerObject.x += t.x - objectCorners[e][1].x - .5;
								collisionReturn = true;
								break;
							}
						}
						else if (b == -1)
						{
							if (objectCorners[e][b2].x + objectChange <= t.x)
							{
								playerObject.x -= objectCorners[e][0].x - t.x;
								collisionReturn = true;
								break;
							}
						}
					}
				}
			}
			else if (axis == "y")
			{
				for (var u:int = 0; u < 2; u++)
				{
					t.x = (Math.floor(objectCorners[b2][u].x / _tileSize));
					t.y = (Math.floor(objectCorners[b2][u].y / _tileSize));
					
					if (b == 1)
						if (t.x + b > _tileSize / 2)
							v = 1;
						else
							v = _collisionData[t.y][t.x + b];
					else if (b == -1)
						if (t.x + b < 0)
							v = 1;
						else
						{
							v = _collisionData[t.y][t.x + b];
						}
					
						
						if (b == 1)
							if (t.y + b > _tileSize / 2)
								v = 1;
							else
								v = 1;
						else if ( b == -1)
							if (t.y + b < 0)
								v = 1;
							else
								v = _collisionData[t.y + b][t.x];
						
					if (b == 1)
						if (t.y + b > _tileSize / 2)
							v = 1;
						else
						{
							if (t.y + b >= _collisionData.length)
								v = _collisionData[t.y][t.x]
							else
								v = _collisionData[t.y + b][t.x];
						}
					else if (b == -1)
						if (t.y + b < 0)
							v = 1;
						else
						{
							v = _collisionData[t.y + b][t.x];
						}
					
					if (v == 1)
					{
						t.x = (t.x) * _tileSize;
						t.y = (t.y + b2) * _tileSize;
						
						if (b == 1)
						{
							if (objectCorners[b2][u].y + objectChange >= t.y)
							{
								playerObject.y += t.y - objectCorners[b2][u].y - .5;
								collisionReturn = true;
								break;
							}
						}
						else if (b == -1)
						{
							if (objectCorners[b2][u].y + objectChange <= t.y)
							{
								playerObject.y -= objectCorners[b2][u].y - t.y;
								collisionReturn = true;
								break;
							}
						}
					}
				}
			}
			return collisionReturn;
		}
	}
}