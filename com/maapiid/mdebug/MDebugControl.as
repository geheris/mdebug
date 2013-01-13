package com.maapiid.mdebug
{
	/**
	 * MDebug is visual debug for flash sites. Presents user logs, and presents capabilities information.
	 * This is simply way to show our traces for example in www browser, and debug behaviours of your code.
	 * 
	 * @project MDebug
	 * @author Arkadiusz Opozda
	 * @version 1.1.2
	 * @copy Maapiid.com
	 * @link http://mdebug.maapiid.com
	 * 
	 * @TODO  better OOP, windws tools,
	 */
	
	 
	import com.maapiid.mdebug.console.Console;
	import com.maapiid.mdebug.data.DebugLineType;
	import com.maapiid.mdebug.data.DebugModel;
	import com.maapiid.mdebug.data.Default;
	import com.maapiid.mdebug.data.Group;
	import com.maapiid.mdebug.data.Items;
	import com.maapiid.mdebug.data.Strings;
	import com.maapiid.mdebug.events.DebugEvent;
	import com.maapiid.mdebug.util.SystemUtils;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	
	
	public class MDebugControl extends EventDispatcher
	{
		
		private var _model:DebugModel = DebugModel.getInstance();
		
		/** @private console view  */
		private var _consoleObject:Console; // <----- widok glowny , w tym widoku sa podwidoki... ale one dostpeu do controlera nie maja, a jak juz musza to przez model, ale nie powinny musiec
	
		/** @private console parent dispay object  */
		private var _consoleContainer:DisplayObjectContainer;
		
		
		
		
		//________________________________________________________________________________________________________________________________________________________________________
		
		/**
		 * Constructor create new Console object. Set poroperties and create default data in model. Run dynamicaly items, and change values in timer event.
		 * 
		 * @param	parent (DisplayObjectContainer) - we must send display object for container to visual parts of debug.
		 */
		public function MDebugControl(parent:DisplayObjectContainer, autoShow:Boolean = true)
		{
			_model.controler = this;
			
			Default.create();
			
			if (!_consoleObject)
			{
				_model.enabled = autoShow;
				
				_consoleContainer = parent;
				_consoleObject = new Console(_consoleContainer);
				
				
			}
			
			if (!autoShow)
				_consoleObject.minmax();
			
			/* system items values */
			debugInfo();
		}
		
		
		
		
		/* OPERATIONS */
		//===================================================================================================================================================================
		/**
		 * Function add interactive text line with object to expand on screen. Call method from screen class of console object. The console view and subview in console, are one view for controller. 
		 * Controller mannaging them by adres mainView.view.view... etc.
		 * 
		 * @param	tag (String) - name of object of trace (we always set "this" as first argument in Debug class.
		 * @param	name (String) - custom name/id of attached object.
		 * @param	object (Object) - object to attach
		 */
		public function addInteractiveLine(tag:*, name:String, object:Object):void
		{
			_consoleObject.screen.addInteractiveText(tag, name, object);
		}
		
		
		
		
		/**
		 * Function add text line on screen. Call method from screen class of console object. The console view and subview in console, are one view for controller. 
		 * Controller mannaging them by adres mainView.view.view... etc.
		 * 
		 * @param	tag (String) - name of object of trace (we always set "this" as first argument in Debug class.
		 * @param	str (String) - string send to display
		 * 
		 * @see ciufcia.modules.debug.Debug
		 */
		public function addLine(tag:*, str:String):void
		{
			var merge:String = tag + ': ' + str;
			
			_consoleObject.screen.addText(merge);
			
			setType(DebugLineType.DEFAULT);
		}
		
		
		
		
		/**
		 * Function add new type to types object. Delete items is not possible. Type of line change line color if wee set line type by function setType()
		 * 
		 * @param	newType (String) - key name of new type
		 * @param	color (uint) - kolor of new type
		 */
		public function addType(newType:String, color:uint):void
		{
			addItem(newType, color, Group.LINE_TYPES);
		}
		
		
		
		
		/**
		 * Function set type for next debug line. If we set type, the line will be in this type color.
		 * If type not exists, function inform us about that, and use default.
		 * 
		 * @param	type (String) - key name of type
		 */
		public function setType(type:String):void
		{
			var typeExists:Boolean = false;
			
			for (var name:String in _model.groups[Group.LINE_TYPES]) 
			{
				
				if(name == type)
					typeExists = true;	
			}
			
			
			if (typeExists) 
				_model.currentLineType = type 
			else
				trace(this, "Type " + type + " not exists. Please add new type");
				
			
		}
		
		
		
		
		/**
		 * function add item to model group. The new type automaticaly added to filters array, becouse only types exists in array will be turn on, and displayed on console.
		 * 
		 * @todo test create category diferent then exists. 
		 * 
		 * @param	name (String) - name of item
		 * @param	value (*) - value of item
		 * @param	category (String) - group name of item
		 */
		public function addItem(name:String, value:*, category:String):void
		{
			_model.groups[category][name] = value;
			// TODO: tu przy kategorii ktora nie istniee wyrzuca plac ze nie ma name, tzn ze nie znalazlo, trzeba osbluzyc
			_model.filters.push(name);
		}
		
		
		
		
		/**
		 * function change value of item.
		 * 
		 * @param	name (String) - name of change item
		 * @param	value (*) - new value of item
		 */
		public function changeItem(name:String, value:*):void
		{
			_model.changeItem(name, value);
		}
		
		
		
		//TODO: set minimalSize
		//=============================================================================================================================================================
		
		/* GETTERS AND SETTERS */
		/**
		 * setter function forcing debug. If we want see debug line, when debugger is disabled, we shoudl set forceDebug on true, then we will see forcing line.
		 * @param  value(Boolean) = true or false forcing
		 */
		public function set forceDebug(value:Boolean):void
		{
			_model.forceDebug = value;
		}
		
		
		
		/**
		 * setter function mannaging outpud displays. When we dont want debug in trace window, we set this setter on false. 
		 * @param value (Boolean) - true or false trace
		 */
		public function set showTrace(value:Boolean):void
		{
			_model.showTrace = value;
		}
		
		
		/**
		 * Function setter disabled or enabled all debug system (visual and working)
		 * @param value (Boolean) - true or false turnnig off all debug
		 */
		public function set enabled(value:Boolean):void
		{
			_model.enabled = value;
			
			value
			? _consoleObject.on()
			: _consoleObject.off();
		}
		
		
		/**
		 * Function set max lines in visual console. You can scroll that count of lines
		 * @param value (int) - count of line in text field
		 */
		public function set maxLines(value:int):void
		{
			_model.maxLines = value;
		}
		
		
		//===================================================================================================================================================================
		
		
		
		/*  VISUAL CHANGES */
		//...................................................................................................................................................................
		/**
		 * function create timer, and set default value of items, like system and resolution
		 */
		private function debugInfo():void
		{
			var _timer:Timer = new Timer( 1000 / _consoleObject.stage.frameRate );
			_timer.addEventListener(TimerEvent.TIMER, timerInterval);
			_timer.start();
			
			_consoleObject.stage.mouseChildren = true;
			_consoleObject.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMMove);
			
			_model.changeItem(Items.ITEM_OS , Capabilities.os);
			_model.changeItem(Items.ITEM_RESOLUTION,  String(Capabilities.screenResolutionX + Strings.X + Capabilities.screenResolutionY));
		}
		
		
		
		/**
		 * onmousemove handler. call change items funcion and send mouse position
		 * @param	e - mouseevent
		 */
		private function onMMove(e:MouseEvent):void 
		{
			_model.changeItem(Items.ITEM_MOUSEPOSITION , String(Strings.X + _consoleObject.stage.mouseX  + ' ' + Strings.Y + _consoleObject.stage.mouseY));
			
		}
		
		
		
		/**
		 * Function is event of timer and set fps and memory value. framerate count per second.
		 * 
		 * @param	e (TimerEvent) - event object
		 */
		private function timerInterval(e:TimerEvent):void 
		{
			_model.changeItem(Items.ITEM_FPS, SystemUtils.fpsCounter(_consoleObject.stage.frameRate));
			_model.changeItem(Items.ITEM_MEMORY, SystemUtils.checkMemoryUsage() );
		}
		//...................................................................................................................................................................
	}
	
}

