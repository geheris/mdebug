package com.maapiid.mdebug.console.display.windows 
{
	
	import com.maapiid.mdebug.data.DebugModel;
	import com.maapiid.mdebug.util.SimpleTextField;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class Window extends Sprite
	{
		/** @protected model instance */
		protected var model:DebugModel = DebugModel.getInstance();
		
		/** @protected background object of window */
		protected var _bg:Sprite;
		
		
		private var _bar:Sprite;
		private var _close:Sprite;
		
		private var _title:String = '';
		private var _titleTextField:SimpleTextField;
		
		
		/** constructor */
		public function Window() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removeStage);
		}
		
		/** remove from stage event */
		private function removeStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeStage);
		}
		
		
		/** add to stage event */
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			createLayout();
			uptateView();
		}
			
		
		/** 
		 * protected function of start
		 */
		protected function uptateView():void {}
		
		
		/**
		 * function crating layout of indyvidual of window.
		 */
		private function createLayout():void
		{
			_bar = new Sprite();
			_bar.graphics.beginFill(0x000000, 0.9);
			_bar.graphics.drawRect(0, 0, 200, 15);
			_bar.graphics.endFill();
			
			_titleTextField = new SimpleTextField(_title, 10, 0xffffff);
			_titleTextField.x = 5;
			
			_bg = new Sprite();
			_bg.graphics.beginFill(0x000000, 0.4);
			_bg.graphics.drawRect(0, 0, 200, 100);
			_bg.graphics.endFill();
			_bg.y = _bar.height;
			
			_bar.addChild(_titleTextField);
			addChild(_bar);
			addChild(_bg);
		}
		
		
		/**
		 * protected setter function for title.
		 */
		protected function set title(value:String):void
		{
			_title = value;
			
			if(_titleTextField)
				_titleTextField.updateText(_title);
		}
	}
}
