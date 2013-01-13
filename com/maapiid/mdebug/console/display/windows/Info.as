package com.maapiid.mdebug.console.display.windows 
{
	 
	import com.maapiid.mdebug.data.Group;
	import com.maapiid.mdebug.data.Strings;
	import com.maapiid.mdebug.events.DebugEvent;
	import com.maapiid.mdebug.util.SimpleTextField;
	
	import flash.events.Event;
	
	
	dynamic public class Info extends Window
	{
		private var counter : int;
		private var items : Array;
		private var values : Array;
		private var groupName : String;
		
		
		/**
		 * constructor.
		 * we set title here and add listener to mdoel for listen change.
		 */
		public function Info() 
		{
			title = Strings.WIN_TITLE_1;
			groupName = Group.INFO;
			
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
					
					var valueTxt:SimpleTextField = new SimpleTextField(String(model.groups[groupName][itemName]));
					valueTxt.y = 20 + (valueTxt.height ) * counter;
					valueTxt.x = nameTxt.x + nameTxt.width;
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
				
			}
			
			_bg.height = counter * 20;
			
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