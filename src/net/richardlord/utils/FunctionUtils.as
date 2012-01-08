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
	 * Methods to addapt function objects to a different parameter set
	 */
	public class FunctionUtils
	{
		public static const PARAM_1:ParamObject = new ParamObject( 0 );
		public static const PARAM_2:ParamObject = new ParamObject( 1 );
		public static const PARAM_3:ParamObject = new ParamObject( 2 );
		public static const PARAM_4:ParamObject = new ParamObject( 3 );
		public static const PARAM_5:ParamObject = new ParamObject( 4 );
		public static const PARAM_6:ParamObject = new ParamObject( 5 );
		public static const PARAM_7:ParamObject = new ParamObject( 6 );
		public static const PARAM_8:ParamObject = new ParamObject( 7 );
		public static const PARAM_9:ParamObject = new ParamObject( 8 );
		public static const PARAM_10:ParamObject = new ParamObject( 9 );

		/**
		 * Adapt a function. The function and parameters are wrapped as a new function, which
		 * is returned. Parameters passed to the new function are used to replace the constants
		 * PARAM_1 ... PARAM_10 if they are in parameters list passed to this method.
		 * 
		 * @param method The function or method closure to wrap.
		 * @param parameters The parameters to pass to the wrapped function when the returned
		 * function is called. If any of the constants PARAM_! to PARAM_10 are in this list,
		 * then those will be replaced by the corresponding argument when the returned function
		 * is called.
		 * @return A function that wraps the function passed in. When calling it, pass it the 
		 * values to replace PARAM_1, PARAM_2 etc if they are used in the parameters list.
		 */
		public static function adaptFunction( method:Function, ...parameters ):Function
		{
			return function( ...params ):*
			{
				var p:Array = parameters.slice( );
				for( var i:int = 0; i < p.length ; ++i )
				{
					if( p[i] is ParamObject )
					{
						p[i] = params[ p[i].pos ];
					}
				}
				return method.apply( NaN, p );
			};
		}

		/**
		 * Adapt a member function. The method and parameters are wrapped as a new function, which
		 * is returned. Parameters passed to the new function are used to specify the object whose
		 * method is to be called abd to replace the constants PARAM_1 ... PARAM_10 if they are 
		 * in parameters list passed to this method.
		 * 
		 * @param methodName The name of the method to wrap.
		 * @param parameters The parameters to pass to the wrapped function when the returned
		 * function is called. If any of the constants PARAM_! to PARAM_10 are in this list,
		 * then those will be replaced by the corresponding argument when the returned function
		 * is called.
		 * @return A function that wraps the method passed in. When calling it, pass it the object 
		 * and the values to replace PARAM_1, PARAM_2 etc if they are used in the parameters list.
		 */
		public static function memberFunction( methodName:String, ...parameters ):Function
		{
			return function( item:*, ...params ):*
			{
				var p:Array = parameters.slice( );
				for( var i:int = 0; i < p.length ; ++i )
				{
					if( p[i] is ParamObject )
					{
						p[i] = params[ p[i].pos - 1 ];
					}
				}
				return item[ methodName ].apply( item, p );
			};
		}
	}
}

class ParamObject 
{
	public var pos:int;

	public function ParamObject( p:int )
	{
		pos = p;
	}
}
