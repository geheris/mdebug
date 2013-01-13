package com.maapiid.mdebug.console.display.windows 
{
	
	 
	import com.maapiid.mdebug.data.Group;
	import com.maapiid.mdebug.data.Strings;
	import com.maapiid.mdebug.events.DebugEvent;
	import com.maapiid.mdebug.util.SimpleTextField;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	
	dynamic public class Filters extends Window
	{
		private var counter : int;
		private var items : Array;
		private var values : Array;
		private var groupName : String;
		
		/** 
		 * constructor. we set title of group here.
		 */
		public function Filters() 
		{
			title = Strings.WIN_TITLE_3;
			groupName = Group.LINE_TYPES;
			
			counter = 0;
			items = [];
			values = [];
			
			
			model.addEventListener(DebugEvent.CHANGE, onDebugChange);
		}
		
		
		
		/**
		 * override protected function when we want start display something.
		 * This dunction dynamicaly created textFields using SimpleTextField class, and set value.
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
					
					var valueTxt:SimpleTextField = new SimpleTextField(Strings.TRUE);
					
					
					valueTxt.background = true;
					valueTxt.backgroundColor = 0x000000;
					
					valueTxt.y = 20 + (valueTxt.height ) * counter;
					valueTxt.x = nameTxt.x + nameTxt.width;
					valueTxt.tabIndex = 200 + counter;
					valueTxt.name = itemName;
					
					
					items[itemName] = nameTxt;
					values[itemName] = valueTxt;
					
					addChild(nameTxt);
					addChild(valueTxt);
					
					counter++;
					
					
				}
				else
				{
					values[itemName].updateText(Strings.FALSE);
				}
				
				assignFilters(itemName);
				
				values[itemName].addEventListener(MouseEvent.CLICK, changeFilter);
			}
			
			_bg.height = counter * 20;
			
		}	
		
		private function assignFilters(itemName:String):void
		{
			var f2:int;
			var l2:int = model.filters.length;
			for (f2 = 0; f2 < l2; f2++)
			{
				
				if ( model.filters[f2] == itemName)
				{
					values[itemName].updateText(Strings.TRUE);
				}
			}
		}
		
		
		
		/**
		 * click change visual display (true/false) and set change in model
		 * @param	e - mouse event
		 */
		private function changeFilter(e:MouseEvent):void 
		{
			var futureFill:String;
			e.target.text == Strings.FALSE ? futureFill = Strings.TRUE : futureFill = Strings.FALSE;
			
			var f:int;
			var l:int = model.filters.length;
			var exists:Boolean = false;
			for (f = 0; f < l; f++)
			{
				if ( model.filters[f] == e.target.name)
				{
					exists = true;
					
					if (futureFill == Strings.FALSE)
						model.filters.splice(f, 1);
				}
			}
			
			if (!exists)
			{
				model.filters.push(e.target.name);
			}
			
			e.target.text = futureFill;
			
		}
		
		
		
		/**
		 * Model change handler. After change we refresh value of text fields by creating not existed or updateText .
		 * @param	e - DebugEvent
		 */
		private function onDebugChange(e:DebugEvent):void 
		{
			uptateView();
		}
	}
}