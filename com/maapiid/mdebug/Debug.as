package com.maapiid.mdebug
{

	import com.maapiid.mdebug.data.DebugLineType;
	import com.maapiid.mdebug.data.DebugModel;
	
	
	public class Debug 
	{
		
		public static function expand(tag:*, name:String, object:Object):void
		{
			if (DebugModel.getInstance().enabled || DebugModel.getInstance().forceDebug)
			{
				if(DebugModel.getInstance().showTrace || DebugModel.getInstance().forceDebug)
					trace(tag, name, object);		
				
				if(DebugModel.getInstance().controler)
					DebugModel.getInstance().controler.addInteractiveLine(tag, name, object);
					
				DebugModel.getInstance().forceDebug = false;
				
			}
		}
		
		
		/**
		* metoda wswietlajaca trace
		* @param message - string do wyswietlenia. Stringi laczy sie +. Aby wyswietlic zmienna, nalezy ja zamienic na stringa.
		**/
		public static function echo( tag : * , ... args):void
		{
			/*if (DebugModel.getInstance().enabled || DebugModel.getInstance().forceDebug)
			{*/
				if(DebugModel.getInstance().showTrace || DebugModel.getInstance().forceDebug)
					trace(tag, DebugModel.getInstance().currentLineType.toUpperCase() + ': ' + args);		
				
				if(DebugModel.getInstance().controler)
					DebugModel.getInstance().controler.addLine(tag, String(args));
					
				DebugModel.getInstance().forceDebug = false;
				
			/*}*/
		}
		
		
		
		/**
		 * debug defined as error
		 * @param	tag - string
		 * @param	... args - arguments
		 */
		public static function e(tag:*, ... args):void
		{
			DebugModel.getInstance().currentLineType = DebugLineType.ERROR;
			echo(tag, args);
		}
		
		
		/**
		 * debug defined as warrning
		 * @param	tag - string
		 * @param	... args - arguments
		 */
		public static function w(tag:*, ... args):void
		{
			DebugModel.getInstance().currentLineType = DebugLineType.WARNING;
			echo(tag, args);
		}
		
		
		/**
		 * debug defined as information
		 * @param	tag - string
		 * @param	... args - arguments
		 */
		public static function i(tag:*, ... args):void
		{
			DebugModel.getInstance().currentLineType = DebugLineType.INFO;
			echo(tag, args);
		}
		
		
		/**
		 * debug defined as positive event
		 * @param	tag - string
		 * @param	... args - arguments
		 */
		public static function p(tag:*, ... args):void
		{
			DebugModel.getInstance().currentLineType = DebugLineType.POSITIVE;
			echo(tag, args);
		}
		
		
		/**
		 * debug defined as default
		 * @param	tag - string
		 * @param	... args - arguments
		 */
		public static function d(tag:*, ... args):void
		{
			//DebugModel.getInstance().type = DebugLineType.DEFAULT;
			echo(tag, args);
		}
		
		
		
	}
	
}