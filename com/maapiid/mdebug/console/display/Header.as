package com.maapiid.mdebug.console.display 
{
	
	 
	import com.maapiid.mdebug.data.DebugModel;
	import com.maapiid.mdebug.data.Strings;
	import com.maapiid.mdebug.util.SimpleTextField;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	public class Header extends /*headerItem */Sprite
	{
		private var _model:DebugModel = DebugModel.getInstance();
		
		/** minimalize event string */
		public static const MIN_MAX:String = 'onMinMax';
		
		/** mouse active event on console */
		public static const MOUSE_ACTIVE:String = 'onMouseActive';
		
		private var bgOfbutTitle:Sprite;
		private var bgOfbutMouse:Sprite;
		
		
		/**
		 * constructor of console header
		 */
		public function Header() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removeStage);
		}
		
		
		/**
		 * remove from stage event of header
		 * @param	e - event
		 */
		private function removeStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeStage);
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		
		
		/**
		 * add to stage event. function start displaing and resize of elements.
		 * @param	e - event
		 */
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			stage.addEventListener(Event.RESIZE, onResize);
			
			start();
			onResize();
			
			
		}
		
		
		/**
		 * on resize event function
		 * @param	e - event. default = null.
		 */
		private function onResize(e:Event = null):void 
		{
			
			bgOfbutTitle.y = 0;
			
			
			stage.stageWidth <= _model.minWidth ? bgOfbutTitle.x = _model.marginLeft : bgOfbutTitle.x = (stage.stageWidth - bgOfbutTitle.width) / 2;
			
			stage.stageWidth <= _model.minWidth ? bgOfbutMouse.x = bgOfbutTitle.x + bgOfbutTitle.width + 5 : bgOfbutMouse.x = bgOfbutTitle.x + bgOfbutTitle.width + 5;
			
		}
		
		
		/**
		 * start function set mousechildrem and crating visual elements.
		 */
		private function start():void
		{
			mouseChildren = true;
			
			createTitleButton();
			crateMouseButton();
			
		}
		
		
		/**
		 * function create title buton of header.
		 */
		private function createTitleButton():void
		{
			
			bgOfbutTitle = new Sprite();
			bgOfbutTitle.alpha = 0.8;
			bgOfbutTitle.graphics.beginFill(0x000000);
			bgOfbutTitle.graphics.drawRect(0, 0, 100, 20);
			bgOfbutTitle.graphics.endFill();
			
			var titleButText:SimpleTextField = new SimpleTextField(Strings.HEADER_BTN_1);
			titleButText.x = 5;
			
			addChild(bgOfbutTitle);
			bgOfbutTitle.addChild(titleButText);
			
			bgOfbutTitle.buttonMode = true;
			bgOfbutTitle.mouseChildren = false;
			bgOfbutTitle.addEventListener(MouseEvent.CLICK, headerClick);
			
		}
		
		
		/**
		 * function creating mouse activate button
		 */
		private function crateMouseButton():void
		{
			bgOfbutMouse = new Sprite();
			
			bgOfbutMouse.alpha = 0.8;
			bgOfbutMouse.graphics.beginFill(0x000000);
			bgOfbutMouse.graphics.drawRect(0, 0, 100, 20);
			bgOfbutMouse.graphics.endFill();
			
			var mouseButText:SimpleTextField = new SimpleTextField(Strings.HEADER_BTN_2);
			mouseButText.x = 10;
			
			addChild(bgOfbutMouse);
			bgOfbutMouse.addChild(mouseButText);
			
			bgOfbutMouse.buttonMode = true;
			bgOfbutMouse.mouseChildren = false;
			bgOfbutMouse.addEventListener(MouseEvent.CLICK, mouseActiveClick);
		}
		
		
		
		/**
		 * mouse activation button event handler. Dispatch mouse active event name.
		 * 
		 * @param	e - mouse event
		 */
		private function mouseActiveClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(MOUSE_ACTIVE));
			e.stopPropagation();
		}
		
		
		/**
		 * header title click mouse event. Clicdek dispatch event min_max for minimalize console.
		 * 
		 * @param	e - mouse event
		 */
		private function headerClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(MIN_MAX));
		}
		
		
		
	}

}