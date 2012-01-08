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

package net.richardlord.utils
{

	/**
	 * The Maths class contains a coupleof useful methods for use in maths functions.
	 */
	public class MathUtils 
	{
		private static const RADTODEG:Number = 180 / Math.PI;
		private static const DEGTORAD:Number = Math.PI / 180;

		/**
		 * Converts an angle from radians to degrees
		 * 
		 * @param radians The angle in radians
		 * @return The angle in degrees
		 */
		public static function asDegrees( radians:Number ):Number
		{
			return radians * RADTODEG;
		}

		/**
		 * Converts an angle from degrees to radians
		 * 
		 * @param radians The angle in degrees
		 * @return The angle in radians
		 */
		public static function asRadians( degrees:Number ):Number
		{
			return degrees * DEGTORAD;
		}
		
		/**
		 * Returns a random integer between two values.
		 * 
		 * @param min The lowest value to return.
		 * @param max The highest value to return.
		 * 
		 * @return A random integer between min and max inclusive.
		 */
		public static function randomInt( min:int, max:int ):int
		{
			return min + int( Math.random() * ( max - min + 1 ) );
		}
		
		/**
		 * Returns a random number between two values.
		 * 
		 * @param min The lowest value to return.
		 * @param max The highest value to return.
		 * 
		 * @return A random number between min and max inclusive.
		 */
		public static function randomNumber( min:Number, max:Number ):Number
		{
			return min + Math.random() * ( max - min );
		}
	}
}
