/*
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2007
 * http://www.richardlord.net/blog/finite-state-machines-for-ai-in-actionscript
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
 
package net.richardlord.fsm
{
	import flash.utils.Dictionary;

	public class StateMachine
	{
		private var states : Dictionary;
		
		private var _currentState : State;
		private var _previousState : State;
		private var _nextState : State;

		public function StateMachine()
		{
			states = new Dictionary();
			_currentState = null;
			_previousState = null;
			_nextState = null;
		}
		
		public function primeStates( ...instances ) : void
		{
			for each( var state : State in instances )
			{
				var type : Class = Object( state ).constructor as Class;
				if( type )
				{
					states[type] = state;
				}
			}
		}
		
		public function removeStates( ...instances ) : void
		{
			for each( var state : State in instances )
			{
				var type : Class = Object( state ).constructor as Class;
				if( type && states[type] == state )
				{
					delete states[type];
				}
			}
		}
		
		private function getStateForClass( type : Class ) : State
		{
			return type in states ? states[type] : states[type] = new type();
		}
		
		public function get previousState() : State
		{
			return _previousState;
		}
		public function get currentState() : State
		{
			return _currentState;
		}
		public function get nextState() : State
		{
			return _nextState;
		}
		
		public function setNextState( type : Class ) : void
		{
			_nextState = getStateForClass( type );
		}

		public function update( time : Number ) : void
		{
			if ( _currentState )
			{
				_currentState.update( time );
			}
		}
		
		public function changeState( type : Class ) : void
		{
			_changeState( getStateForClass( type ) );
		}

		public function changeStateInstance( state : State ) : void
		{
			primeStates( state );
			_changeState( state );
		}

		private function _changeState( state : State ) : void
		{
			if( _currentState )
			{
				_currentState.exit();
			}
			_previousState = _currentState;
			_currentState = state;
			if( _currentState )
			{
				_currentState.enter();
			}
		}
		
		public function goToPreviousState() : void
		{
			if( _previousState )
			{
				_changeState( _previousState );
			}
		}

		public function goToNextState() : void
		{
			if( _nextState )
			{
				_changeState( _nextState );
			}
		}
	}
}
