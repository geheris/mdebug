package com.maapiid.mdebug.console 
{
	/**
	 * Visualisation of debeug.
	 */
	
	 
	import com.maapiid.mdebug.console.display.Background;
	import com.maapiid.mdebug.console.display.Header;
	import com.maapiid.mdebug.console.display.windows.Filters;
	import com.maapiid.mdebug.console.display.windows.Info;
	import com.maapiid.mdebug.console.display.windows.Screen;
	import com.maapiid.mdebug.console.display.windows.Settings;
	import com.maapiid.mdebug.data.DebugModel;
	import com.maapiid.mdebug.data.Items;
	import com.maapiid.mdebug.events.DebugEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class Console extends Sprite
	{
		private var _model:DebugModel = DebugModel.getInstance();
		
		
		private var _bg:Background = new Background();
		private var _header:Header = new Header();
		private var _infoW:Info = new Info();
		private var _settingsW:Settings = new Settings();
		private var _filtersW:Filters = new Filters();
		
		public var screen:Screen = new Screen();
		
		
		private var _show:Boolean = true;
		
		/**
		 * Constructor of Console object.
		 * 
		 * @param	parentDisplayObject (DisplayObjectContainer) - container for visual debug.
		 */
		public function Console(parentDisplayObject:DisplayObjectContainer) 
		{
			
			addEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removeStage);
			
			parentDisplayObject.addChildAt(this, parentDisplayObject.numChildren);
		}
		
		
		/**
		 * adding to stage handler. There is call start method.
		 * @param	e - Event
		 */
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, onResize);
			
			_model.addEventListener(DebugEvent.CHANGE, onDebugChange);
			
			start();
			onResize();
		}
		
		
		
		/**
		 * remove from stage event handler
		 * @param	e - Event
		 */
		private function removeStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeStage);
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		
		private function onDebugChange(e:DebugEvent):void 
		{
			changeWindowPosition();
		}
		
		
		
		private function onResize(e:Event = null):void 
		{
			changeWindowPosition();
			_model.changeItem(Items.ITEM_STAGESIZE, String(stage.stageWidth + 'x' + stage.stageHeight) );
		}
		
		private function changeWindowPosition():void
		{
			stage.stageWidth <= 660 ? _infoW.x = 660 - _infoW.width - 5 : _infoW.x = stage.stageWidth - 5 - _infoW.width;
			_infoW.y = 25;
			
			stage.stageWidth <= 660 ? _settingsW.x = 660 - _settingsW.width - 5 : _settingsW.x = stage.stageWidth - 5 - _settingsW.width;
			_settingsW.y = _infoW.y + _infoW.height + 1;
			
			stage.stageWidth <= 660 ? _filtersW.x = 660 - _filtersW.width - 5 : _filtersW.x = stage.stageWidth - 5 - _filtersW.width;
			_filtersW.y = _settingsW.y + _settingsW.height + 1;
		}
		
		
		
		/**
		 * start function adding display objects to display list, and listen header click actions.
		 */
		private function start():void
		{	
			mouseEnabled = false;
			mouseChildren = false;
			
			addChild(_bg);
			addChild(screen);
			addChild(_infoW);
			addChild(_settingsW);
			addChild(_filtersW);
			
			parent.addChild(_header);
			
			
			//add child settings, info, filters
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
			
			_header.addEventListener(Header.MIN_MAX, clickHandler);
			_header.addEventListener(Header.MOUSE_ACTIVE, mouseActiveHandler);
		}
		
		
		/**
		 * Stage click listener. Disable all expanders when you click somewhere on stage.
		 * @param	e - click event
		 */
		private function onStageClick(e:MouseEvent):void 
		{
			for (var name:String in _model.expanders) 
			{
				//_model.expanders[name].parent.removeChild(_model.expanders[name]);
				//delete _model.expanders[name];
			}
		}
		
		
		
		/**
		 * Function off visual console. All elements of visual console.
		 */
		public function off():void
		{
			_bg.visible = false;
			screen.visible = false;
			_header.visible = false;
			_infoW.visible = false;
			_settingsW.visible = false;
			_filtersW.visible = false;
		}
		
		
		/**
		 * Function on visual console. All elements of visual console.
		 */
		public function on():void
		{
			if (_show)
			{
				_bg.visible = true;
				screen.visible = true;
				_header.visible = true;
				_infoW.visible = true;
				_settingsW.visible = true;
				_filtersW.visible = true;
			}
			
		}
		
		
		/**
		 * Function minimalize and maxymalize visual debug
		 */
		public function minmax():void
		{
			_show = !_show;
			_bg.visible = _show;
			screen.visible = _show;
			_settingsW.visible = _show;
			_filtersW.visible = _show;
			_infoW.visible = _show;	
		}
		
		
		/* EVENTS */
		
		/**
		 * Header events handler. Listen of click in header to minimalize or maximalize console
		 * @param	e (Event) - event
		 */
		private function clickHandler(e:Event):void 
		{
			minmax();
		}
		
		
		private function mouseActiveHandler(e:Event):void 
		{
			mouseChildren = !mouseChildren;
		}
		
	}

}