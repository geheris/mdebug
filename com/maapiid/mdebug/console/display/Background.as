package com.maapiid.mdebug.console.display 
{
	
	import com.maapiid.mdebug.data.DebugModel;
	import com.maapiid.mdebug.events.DebugEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	
	public class Background extends Sprite
	{
		
		private var _model:DebugModel = DebugModel.getInstance();
		
		
		/**
		 * constructor
		 */
		public function Background() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removeStage);
		}
		
		/**
		 * remove from stage event
		 * @param	e - event
		 */
		private function removeStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeStage);
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		
		
		/**
		 * add to stage event. start display and resizing
		 * @param	e - event
		 */
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			stage.addEventListener(Event.RESIZE, onResize);
			
			_model.addEventListener(DebugEvent.CHANGE, onDebugChange);
			
			start();
			onResize();
		}
		
		
		/**
		 * listener for debug model. Listen of change in model. In this case , we change alpha of console backgrond.
		 * @param	e - DebugEvent
		 */
		private function onDebugChange(e:DebugEvent):void 
		{
			alpha = _model.bgAlpha;
		}
		
		
		
		/**
		 * set alpha and background graphic object.
		 */
		private function start():void
		{
			alpha = _model.bgAlpha;
			graphics.beginFill(_model.bgColor);
			graphics.drawRect(0, 0, 1,1);
			graphics.endFill();
		}
		
		
		
		/**
		 * resizing handler of  background
		 * @param	e - event , default null.
		 */
		private function onResize(e:Event = null):void 
		{
			x = _model.marginLeft;
			y = _model.marginTop;
			
			stage.stageWidth <= _model.minWidth ? width = _model.minWidth - _model.marginRight : width = stage.stageWidth -  (_model.marginLeft + _model.marginRight);
			stage.stageHeight <= _model.minHeight ? height = _model.minHeight - _model.marginBottom : height = stage.stageHeight - (_model.marginTop + _model.marginBottom);
			
		}
		
	}

}