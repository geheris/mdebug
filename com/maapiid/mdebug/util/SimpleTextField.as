package com.maapiid.mdebug.util 
{
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	
	public class SimpleTextField extends TextField
	{
		
		private var _txf:TextFormat;
		
		
		/**
		 * Constructor of SimpleTextField. We set arguments and class create fast text field. We only mus add this to display list.
		 * 
		 * @param	string (String) - text to display
		 * @param	fontSize (int) - size of font
		 * @param	fontColor (uint) - color of font
		 * @param	fontFamily (String) - family of font
		 * @param	type (String) - type of text field
		 */
		public function SimpleTextField(string:String, fontSize:int = 10, fontColor:uint = 0xffffff, fontFamily:String = 'Verdana', type:String = 'dynamic') 
		{
			autoSize = TextFieldAutoSize.LEFT;
			type = type;
			
			_txf = new TextFormat(fontFamily, fontSize, fontColor);
			
			text = string;
			
			setTextFormat(_txf);
			
		}
		
		
		/**
		 * Function update text in console
		 * 
		 * @param	string (String) - text to display
		 * @param	fontSize (int) - size of font
		 * @param	fontColor (uint) - color of font
		 * @param	fontFamily (String) - family of font
		 * @param	type (String) - type of text field
		 */
		public function updateText(string:String, fontSize:int = 10, fontColor:uint = 0xffffff, fontFamily:String = 'Verdana', type:String = 'dynamic'):void
		{
			type = type;
			
			_txf = null;
			_txf = new TextFormat(fontFamily, fontSize, fontColor);
			
			text = string;
			
			setTextFormat(_txf);
		}
		
	}

}