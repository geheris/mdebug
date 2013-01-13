package com.maapiid.mdebug.data 
{
	import com.maapiid.mdebug.MDebugControl;
	import com.maapiid.mdebug.events.DebugEvent;
	import flash.events.EventDispatcher;

	
	public class DebugModel extends EventDispatcher
	{
		private static var _instance : DebugModel;
		
		//________________________________________________________________________________________________________________________________________________________________________
		public function DebugModel(enforcer : SingletonEnforcer)
		{
			if(enforcer == null)
				throw new Error("Class instance has to be accessed using static 'getInstance' method!");
			
			if(_instance != null)
				throw new Error("Cannot create multiple instances of class");
			
		}
		
		public static function getInstance() : DebugModel
		{
			if(_instance == null)
				_instance = new DebugModel(new SingletonEnforcer());
			
			return _instance;
		}
		
		//________________________________________________________________________________________________________________________________________________________________________
		
		/**
		 * Reference of controler. For example used in Debug.as
		 * 
		 * @see ciufcia.modules.debug.Debug
		 */
		public var controler:MDebugControl;
		
		/** enabled debug. If is false, that not display from debug */
		public var enabled:Boolean = true;
		
		/** force one debug. After Debug.echo var is turn false */
		public var forceDebug:Boolean;
		
		/** if tru showing traces of debug (debug in output window) */
		public var showTrace:Boolean = true;
		
		/** max lines in text fild (scrolling) */
		public var maxLines:int = 100;
		
		
		
		//dynamiczne tworzenie grup....! trzeba!
		private var _groups:Object = {};
		
		
		/** @private types vars */
		private var _currentLineType:String ;
		private var _filters:Array = [];
		
		
		
		private var _fontSize:int = 10;
		/*private var _fontColoer:int = 0xffffff;*/
		private var _bgAlpha:Number = 0.7;
		private var _debugInterval:int;
		
		
		public var minWidth:int = 200;
		public var minHeight:int = 100;
		public var bgColor:uint = 0x000000;
		public var marginLeft:int = 5;
		public var marginRight:int = 5;
		public var marginTop:int = 20;
		public var marginBottom:int = 5;
		
		public var objects:Object = { };
		public var expanders:Object = { };
		
		
		
		//________________________________________________________________________________________________________________________________________________________________________
		
		
		/**
		 * function change value of item and dispatch change event.
		 * 
		 * @param	name (String) - name of change item
		 * @param	value (*) - new value of item
		 */
		public function changeItem(name:String, value:*):void
		{
			var key:String;
			
			for (var groupName:String in _groups) 
			{
				for (key in _groups[groupName]) 
				{
					if(key == name) _groups[groupName][key] = value;
				}
			}
			
			dispatchEvent(new DebugEvent(DebugEvent.CHANGE));
		}
		
		
		
		//----------------------------------------------------------------------------------------------------------------------------------------
		/**
		 * Function getter get all groups object with all set category of items.
		 */
		public function get groups():Object
		{
			return _groups;
		}
		
		
		
		
		
		/**
		 * function getter get value of background alpha of visual console
		 */
		public function get bgAlpha():Number
		{
			return _bgAlpha;
		}
		
		/**
		 * function setter set value of background alpha of visual console. Function dispatch debug event.
		 */
		public function set bgAlpha(value:Number):void
		{
			_bgAlpha = value;
			
			dispatchEvent(new DebugEvent(DebugEvent.CHANGE));
		}
		
		
		
		/**
		 * function getter get font size of console screen text
		 */
		public function get fontSize():int
		{
			return _fontSize;
		}
		
		/**
		 * function setter set font size of text in console screen. Function dispatch debug event.
		 */
		public function set fontSize(value:int):void
		{
			_fontSize = value;
			
			dispatchEvent(new DebugEvent(DebugEvent.CHANGE));
		}
		
		
		
		/**
		 * function getter get all filters array. Console show line, only that in this array
		 */
		public function get filters():Array
		{
			return _filters;
		}
		
		/**
		 * function setter set filters.  Function dispatch debug event.
		 */
		public function set filters(value:Array):void
		{
			_filters = value;
			
			dispatchEvent(new DebugEvent(DebugEvent.CHANGE));
		}
		
		
		
		/**
		 * function getter get actual type of line.
		 */
		public function get currentLineType():String
		{
			return _currentLineType;
		}
		
		/**
		 * functionsetter set actual type of line. 
		 */
		public function set currentLineType(value:String):void
		{
			_currentLineType = value;	
		}
	}
}

internal class SingletonEnforcer {}