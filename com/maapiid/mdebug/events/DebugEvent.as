package com.maapiid.mdebug.events 
{
	 
	import flash.events.Event;
	
	
	public class DebugEvent extends Event
	{
		
		private var _type:String;
		
		public static const CHANGE : String = "onDebugChange";
		
		
		
		
		/**
		 * Constructor of CiufciaEvent.
		 */
		public function DebugEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			_type = type;
		}
		
		
		
		/// Returns a string that contains all the properties of the DebugEvent object.
		public override function toString () : String
		{
			return '[DebugEvent type="' + _type + '" bubbles="false" cancelable="false"]' ;
		}
		
		
		
		///Creates a copy of the <code>DebugEvent</code> object and sets the value of each parameter to match the original.
		public override function clone():Event 
		{
			return new DebugEvent(_type, bubbles, cancelable);
		}
	}
}