package com.maapiid.mdebug.data 
{
	
	public class Default
	{
		
		public static function create():void
		{
			
			/* groups */
			DebugModel.getInstance().groups[Group.INFO] = { };
			DebugModel.getInstance().groups[Group.SETTINGS] = { };
			DebugModel.getInstance().groups[Group.LINE_TYPES] = { };
			
			
			/* info */
			DebugModel.getInstance().groups[Group.INFO][Items.ITEM_FPS] = null;
			DebugModel.getInstance().groups[Group.INFO][Items.ITEM_MEMORY] = null;
			DebugModel.getInstance().groups[Group.INFO][Items.ITEM_MOUSEPOSITION] = null;
			DebugModel.getInstance().groups[Group.INFO][Items.ITEM_OS] = null;
			DebugModel.getInstance().groups[Group.INFO][Items.ITEM_RESOLUTION] = null;
			DebugModel.getInstance().groups[Group.INFO][Items.ITEM_STAGESIZE] = null;
			
			
			/* settings */
			DebugModel.getInstance().groups[Group.SETTINGS][Items.ITEM_BGALPHA] = DebugModel.getInstance().bgAlpha;
			DebugModel.getInstance().groups[Group.SETTINGS][Items.ITEM_FONTSIZE] = DebugModel.getInstance().fontSize;
			
			
			/* line types */
			DebugModel.getInstance().groups[Group.LINE_TYPES][DebugLineType.DEFAULT] = 0xcccccc;
			DebugModel.getInstance().groups[Group.LINE_TYPES][DebugLineType.ERROR] = 0xff0000;
			DebugModel.getInstance().groups[Group.LINE_TYPES][DebugLineType.POSITIVE] = 0x339900;
			DebugModel.getInstance().groups[Group.LINE_TYPES][DebugLineType.WARNING] = 0xEABB00;
			DebugModel.getInstance().groups[Group.LINE_TYPES][DebugLineType.INFO] = 0x0099FF;
			
			
			/* filters */
			// TODO: tu przy kategorii ktora nie istniee wyrzuca plac ze nie ma name, tzn ze nie znalazlo, trzeba osbluzyc
			DebugModel.getInstance().filters.push(DebugLineType.DEFAULT);
			DebugModel.getInstance().filters.push(DebugLineType.ERROR);
			DebugModel.getInstance().filters.push(DebugLineType.POSITIVE);
			DebugModel.getInstance().filters.push(DebugLineType.WARNING);
			DebugModel.getInstance().filters.push(DebugLineType.INFO);
			
			
			DebugModel.getInstance().currentLineType = DebugLineType.DEFAULT;
		}
		
	}

}