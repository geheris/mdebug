package com.maapiid.mdebug.console.display.windows 
{
	 
	import com.maapiid.mdebug.console.display.expand.Expander;
	import com.maapiid.mdebug.data.DebugModel;
	import com.maapiid.mdebug.data.Group;
	import com.maapiid.mdebug.events.DebugEvent;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuClipboardItems;
	import flash.ui.ContextMenuItem;
	
	public class Screen extends Sprite
	{
		private var _model:DebugModel = DebugModel.getInstance();
		
		private var tx:TextField;
		private var txf:TextFormat;
		
		private var wathFiltersChange:int;
		
		private var _linesFormatInfo:Vector.<Object>;
		
		
		//-----------------------------------------------------
		
		/** constructor */
		public function Screen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removeStage);
		}
		
		
		/** remove from stage event */
		private function removeStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeStage);
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		
		
		/** add to stage event */
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			stage.addEventListener(Event.RESIZE, onResize);
			
			wathFiltersChange = _model.filters.length;
			_model.addEventListener(DebugEvent.CHANGE, onDebugChange);
			
			start();
			onResize();
		}
		
		
		/**
		 * Handler of change in debug model. Wee refresh screen only when font size or filters was changed.
		 * @param	e - DebugEvent
		 */
		private function onDebugChange(e:DebugEvent):void 
		{
			if (txf.size != _model.fontSize || wathFiltersChange != _model.filters.length)
			{
				refresh();
			}
		}
		
		
		
		/** on resize event handler */
		private function onResize(e:Event = null):void 
		{
			tx.x = _model.marginLeft + 5;
			tx.y = _model.marginTop + 5;
			
			stage.stageWidth <= _model.minWidth ? tx.width = _model.minWidth - _model.marginRight - 10 : tx.width = stage.stageWidth -  (_model.marginLeft + _model.marginRight) - 10;
			stage.stageHeight <= _model.minHeight ? tx.height = _model.minHeight - _model.marginBottom - 10 : tx.height = stage.stageHeight - (_model.marginTop + _model.marginBottom) - 10;
		}
		
		
		
		/**
		 * start function creating text fild for all lines from debugger.
		 */
		private function start():void
		{
			_linesFormatInfo = new Vector.<Object>();
			
			txf = new TextFormat('Verdana', _model.fontSize, 0xffffff);
			tx = new TextField();
			
			tx.htmlText = '';
			addEventListener(TextEvent.LINK, linkHandler);
			
			//text field properties....
			tx.multiline = true;
			tx.wordWrap = true;
			tx.selectable = true;
			addChild(tx);
		}
		
		
		/**
		 * Handler of clicked elements in text field, with event TextEvent
		 * @param	e - TextEvent object
		 */
		private function linkHandler(e:TextEvent):void 
		{
			if (!_model.expanders[e.text])
			{
				closeAllExpanders();
				addChild(new Expander(e.text));
			}
			else
			{
				removeChild(_model.expanders[e.text]);
				delete _model.expanders[e.text];
			}
		}
		
		/**
		 * Function closing all opened expanders
		 */
		private function closeAllExpanders():void
		{
			for (var name:String in _model.expanders) 
			{
				removeChild(_model.expanders[name]);
				delete _model.expanders[name];
			}
		}
		
		
		
		/**
		 * this function adding text to text filed. Check type and set line type color. Scrolling text and push to array information about line for future refresh.
		 * @param	str (String) - string to display
		 */
		public function addText(str:String):void
		{
			txf.color = _model.groups[Group.LINE_TYPES][_model.currentLineType];
			
			var ind:int = tx.text.length;
			
			tx.htmlText += str;
			
			tx.setTextFormat(txf, ind, tx.text.length);
			
			if (_linesFormatInfo.length >  _model.maxLines - 1)
				_linesFormatInfo.shift();
			
				
			_linesFormatInfo.push( { string:str, format:txf, type:_model.currentLineType } );
			
			
			
			tx.scrollV = tx.numLines;
			refresh();
		}
		
		
		/**
		 *  This function adding interactive text to text filed with object to expand.
		 * 
		 * @param	tag (String) - custom tag. 
		 * @param	name (String) - custom name/id
		 * @param	object (Object) - custom object to expand
		 */
		public function addInteractiveText(tag:String, name:String, object:Object):void
		{
			var str:String;
			
			if(object is Array)
				str = tag + ': ' + name  + ' <u><b><a href="event:' + name + '">' + '[object Array]' + '</a></b></u> ';
			else if(object is Sprite)	
				str = tag + ': ' + name  + ' <b>' + object + '</b>';
			else
				str = tag + ': ' + name  + ' <u><b><a href="event:' + name + '">' + object + '</a></b></u> ';
			
			
			
			
			
			
				
			txf.color = _model.groups[Group.LINE_TYPES][_model.currentLineType];
			
			var ind:int = tx.text.length;
			
			tx.htmlText += str;
			
			tx.setTextFormat(txf, ind, tx.text.length);
			
			if (_linesFormatInfo.length > _model.maxLines - 1)
				_linesFormatInfo.shift();
				
				
			_linesFormatInfo.push( { string:str, format:txf, type:_model.currentLineType } );
			
			tx.scrollV = tx.numLines;
			
			
			refresh();
			_model.objects[name] = object;
			
		}
		
		
		
		/**
		 * function refresh main text filed using information from _linesFormatInfo array. This function work like addText function.
		 */
		public function refresh():void
		{
			tx.text = '';
			txf.size = _model.fontSize;
			wathFiltersChange = _model.filters.length;
			
			for (var i:int = 0; i < _linesFormatInfo.length; i++)
			{
				txf.color = _model.groups[Group.LINE_TYPES][_linesFormatInfo[i].type];
				
				var j:int;
				var l:int = _model.filters.length;
				var existFilter:Boolean;
				
				for (j = 0;j < l; j++)
				{
					if ( _model.filters[j] == _linesFormatInfo[i].type)
					{
						existFilter = true;
					}
				}
				
				
					
				var ind:int = tx.text.length;
				
				if (existFilter)
				{
					tx.htmlText += _linesFormatInfo[i].string;
					tx.setTextFormat(_linesFormatInfo[i].format, ind, tx.text.length);
				}
						
						
				existFilter = false;
				tx.scrollV = tx.numLines;
			}
			
		}
	}

}