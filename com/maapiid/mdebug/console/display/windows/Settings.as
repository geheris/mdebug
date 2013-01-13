package com.maapiid.mdebug.console.display.windows 
{

	import com.maapiid.mdebug.data.Items;
	import com.maapiid.mdebug.data.Group;
	import com.maapiid.mdebug.data.Strings;
	import com.maapiid.mdebug.events.DebugEvent;
	import com.maapiid.mdebug.util.SimpleTextField;
	
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	
	dynamic public class Settings extends Window
	{
		private var counter : int;
		private var items : Array;
		private var values : Array;
		private var groupName : String;
		
		
		/** 
		 * constructor. we set title of group here.
		 */
		public function Settings() 
		{
			title = Strings.WIN_TITLE_2;
			groupName = Group.SETTINGS;
			
			counter = 0;
			items = [];
			values = [];
			
			
			model.addEventListener(DebugEvent.CHANGE, onDebugChange);
		}
		
		
		
		/**
		 * override protected function when we want start display something.
		 * This dunction dynamicaly created textFields using SimpleTextField class, and set value.
		 * Listen for listeners focus change and mouse click on text field.
		 */
		override protected function uptateView():void
		{
			for (var itemName:String in model.groups[groupName])
			{
				
				if (!items[itemName])
				{
					var nameTxt:SimpleTextField = new SimpleTextField(String(itemName + Strings.COLON), 10, 0xcccccc);
					nameTxt.x = 5;
					nameTxt.y = 20 + (nameTxt.height ) * counter;
					
					var valueTxt:SimpleTextField = new SimpleTextField(String(model.groups[groupName][itemName]));
					valueTxt.y = 20 + (valueTxt.height ) * counter;
					valueTxt.x = nameTxt.x + nameTxt.width;
					valueTxt.type = TextFieldType.INPUT;
					valueTxt.tabIndex = counter;
					valueTxt.name = itemName;
					
					
					items[itemName] = nameTxt;
					values[itemName] = valueTxt;
					
					addChild(nameTxt);
					addChild(valueTxt);
					
					counter++;
				}
				else
				{
					values[itemName].updateText(String(model.groups[groupName][itemName]));
				}
				
				values[itemName].addEventListener(MouseEvent.CLICK, onFocusIn);
				values[itemName].addEventListener(FocusEvent.KEY_FOCUS_CHANGE, onKeyFocus);
			}
			
			_bg.height = counter * 20;
		}
		
		
		/**
		 * Model change handler. After change we refresh value of text fields by creating not existed or updateText .
		 * @param	e - DebugEvent
		 */
		private function onDebugChange(e:DebugEvent):void 
		{
			//start();
		}
		
		
		/**
		 * focus evemt handler. We check what was change and change model data. 
		 * @param	e - focus event
		 */
		private function onKeyFocus(e:FocusEvent):void 
		{
			if (e.target.name == Items.ITEM_BGALPHA)
			{
				model.bgAlpha = Number(e.target.text);
			}
			if (e.target.name == Items.ITEM_FONTSIZE)
			{
				model.fontSize = int(e.target.text);
			}
		}
		
		
		/**
		 * mouse click event handler, check click and then set seletcion on text field.
		 * @param	e - mouse event
		 */
		private function onFocusIn(e:MouseEvent):void 
		{
			e.target.setSelection(0, e.target.text.length);
		}
	}

}