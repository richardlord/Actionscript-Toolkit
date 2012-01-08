/*
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2007
 * http://www.richardlord.net/
 * 
 * Licence Agreement (The MIT License)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package net.richardlord.collisions 
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;		

	public class HitTest 
	{
		public static function hitTestRect( r1:Rectangle, r2:Rectangle ):Boolean
		{
			return r1.top < r2.bottom && r1.bottom > r2.top
				&& r1.left < r2.right && r1.right > r2.left;
		}
		
		public static function hitTestObject( d1:DisplayObject, d2:DisplayObject ):Boolean
		{
			if( !d1.hitTestObject( d2 ) )
			{
				return false;
			}
			var bounds:Rectangle = d1.getRect( d1 );
			var bmd:BitmapData = new BitmapData( bounds.width, bounds.height, false, 0 );
			
			var matrix:Matrix = d1.transform.matrix.clone();
			matrix.translate( -bounds.left, -bounds.top );
			bmd.draw( d1, matrix, new ColorTransform( 0, 0, 0, 0, 255, 0, 0, 255 ) );
			
			matrix = d2.transform.matrix.clone();
			matrix.translate( -bounds.left, -bounds.top );
			bmd.draw( d2, matrix, new ColorTransform( 0, 0, 0, 0, 0, 0, 255, 255 ), BlendMode.ADD );
			
			var rect:Rectangle = bmd.getColorBoundsRect( 0xFFFFFF, 0xFF00FF );
			return rect.width > 0;
		}
	}
}
