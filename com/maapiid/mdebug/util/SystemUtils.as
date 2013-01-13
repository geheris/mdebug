package com.maapiid.mdebug.util 
{
	 
	import com.maapiid.mdebug.data.Strings;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.utils.getTimer;
	
	public class SystemUtils
	{
		
		private static var ticks:uint = 0;
		private static var last:uint = getTimer();
		private static var fps:Number;
		private static var result:String;
		
		private static var _warningMemory:uint = 1000*1000*500;
		private static var _abortMemory:uint = 1000 * 1000 * 625;
		
		
		
		/**
		 * empty constructor of class.
		 */
		public function SystemUtils() 
		{
			
		}
		
		
		/**
		 * Fps counter.
		 * @param	stageFrameRate (Number) - the stage framerate
		 * @return result (String) - string of frame per second and system framerate
		 */
		public static function fpsCounter(stageFrameRate:Number):String 
		{
			ticks++;
			var now:uint = getTimer();
			var delta:uint = now - last;
			
			if (delta >= 1000)
			{
				fps = ticks / delta * 1000;
				result =  '' + fps.toFixed(1) + Strings.SLASH  + stageFrameRate + Strings.FPS;
				ticks = 0;
				last = now;
			}
			
			return result;
		}
		
		
		
		/**
		 * function show actual memory used, and trace when we used to much of memory.
		 * 
		 * @return result (String) - total memory
		 */
		public static function checkMemoryUsage():String
		{
			var result:String;
			
			if (System.totalMemory > _warningMemory) 
			{
				//listener
				trace('Application abort warning! Memory used: ', System.totalMemory, ' - Memory limit: ', _abortMemory);
			}
			if (System.totalMemory > _abortMemory) 
			{
				//listener
				trace('Application aborted! Memory used: ', System.totalMemory, ' - Memory limit: ', _abortMemory);
				abort();
			}
			
			result = String( ( Math.ceil (System.totalMemory / 1000) / 1000 ) + Strings.MB  );
			
			return result;
		}
		
		
		/**
		 * private function abort, run html page with info about that.
		 * 
		 * @todo mozliwosc ustawienia strony z zewnatrz.
		 */
		private static function abort():void
		{
		 
		   navigateToURL(new URLRequest("memoryError.html"));
		}
	}

}