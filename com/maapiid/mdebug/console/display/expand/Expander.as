package com.maapiid.mdebug.console.display.expand 
{
	
	
	import com.maapiid.mdebug.data.DebugModel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	
	public class Expander extends Sprite
	{
		private var _model:DebugModel = DebugModel.getInstance();
		private var _name:String;
		
		private var tx:TextField;
		private var txf:TextFormat;
		
		private var _objectString:String = '';
		private var _object:Object;
		
		private var _recurencyCounter:int = 0;
		
		
		
		
		/**
		 * Expander constructor.
		 * @param	name (String) - name of expander. The sam id is in model expanders object.
		 */
		public function Expander(name:String) 
		{
			_name = name;
			_object = _model.objects[_name];
			
			mouseEnabled = false;
			mouseChildren = true;
			
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
			
			_model.expanders[_name] = this;
			
			
			createString();
			
			if (_objectString.length > 30)
			{
				createMiniScreen();
				
				tx.htmlText += '<u>' + _name + '</u>';
				tx.htmlText += '\n';
				
				updateText();
				drawBg();
			}
		}
		
		
		/**
		 * Function creating complety strong from recurency of objets.
		 */
		private function createString():void
		{
			
			rekurency(_object);	
		}
		
		
		/**
		 * Recurency function
		 * @param	ob (Object) - object to expand
		 */
		private function rekurency(ob:Object):void
		{
			var inside:Boolean = false;
			
			for (var name:String in  ob) 
			{
				inside = true;
				
				
				var spacer:String = '';
				var a:int = 0;
				while (a < _recurencyCounter )
				{
					spacer += '   ';
					a++;
				}
				
				
				_recurencyCounter++;
				
				(ob[name] is Array) 
				? _objectString += spacer + name + ' -> ' + '[object Array]' + '\n'
				: _objectString += spacer + name + ' -> ' + ob[name] + '\n';
					
				rekurency(ob[name]);
				
				_recurencyCounter--;
			}
			
			
		}
		
		
		/**
		 * Function create text field for recurency string.
		 */
		private function createMiniScreen():void
		{
			txf = new TextFormat('Verdana', _model.fontSize, 0xffffff);
			tx = new TextField();
			tx.htmlText = '';
			
			//text field properties....
			tx.autoSize = 'left';
			tx.multiline = true;
			tx.selectable = true;
			addChild(tx);
			
			tx.x = 10;
			tx.y = 5;
		}
		
		/**
		 * Function update textfield
		 */
		private function updateText():void
		{
			tx.htmlText += _objectString;
			tx.setTextFormat(txf);
		}
		
		
		/**
		 * Function draw graphic background, base on size of text field
		 */
		private function drawBg():void
		{
			graphics.beginFill(0x000000, 0.7);
			graphics.drawRect(0, 0, tx.width + 20, tx.height + 10 );
			graphics.endFill();
			
			x = mouseX;
			y = mouseY;
			
			if (y + height > stage.stageHeight)
			{
				y = stage.stageHeight - height;
			}
		}
	}

}