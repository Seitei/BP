package utils
{
	import flash.geom.Point;

	public class Movement
	{
		private var _instance:Movement;
		public function Movement()
		{
		}	
		/**
		 * Moves an object from its current position to a given point and stops.
		 * @param	obj 	The Object to be moved.
		 * @param	target 	The target Point where the object should stop.
		 * @param	speed 	How fast should the object travel per frame.
		 * @param	objRot	Do you want to rotate the object to face the direction of travel?
		 */
			
		public static function moveToPoint(obj:Object, target:Point, speed:Number = 1, objRot:Boolean = false):Boolean
		{
			// get the difference between obj and target points.
			var diff:Point = target.subtract(new Point(obj.x, obj.y)); 
			var dist:Number = diff.length;
			
			if (dist <= speed)  // if we will go past when we move just put it in place.
			{
				obj.x = target.x;
				obj.y = target.y;
				return false;
			}
			else // If we are not there yet. Keep moving.
			{ 
				diff.normalize(1);
				obj.x += diff.x * speed;
				obj.y += diff.y * speed;
				
				if (objRot) // If we want to rotate with our movement direction.
				{ 
					obj.rotation = Math.atan2(diff.y, diff.x) + 90 * (Math.PI / 180);
				}
				return true;
			}
		}
			
		public static function moveInDirection(obj:Object, angle:int, speed:Number):void {
				
			obj.x += Math.cos(angle * (Math.PI / 180)) * speed;
			obj.y += Math.sin(angle * (Math.PI / 180)) * speed;
					
			
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}