package kr.co.shovvel.hcf.utils;

import java.text.DecimalFormat;

import org.apache.log4j.Logger;

public class ByteUtil extends org.apache.commons.lang.StringUtils {

	private static Logger logger = Logger.getLogger(ByteUtil.class);
	
	
	public static String ByteUnitChange(String bytes, String unit) {
		float fBytes = Float.parseFloat(bytes);
		String strByteUnit = null;
		
		if (fBytes <= 0) {
			strByteUnit = "0 " + unit;
	    } else {
		    final String[] units = new String[] {" ", " K", " M", " G", " T", " P" };
		    int digitGroups = (int) (Math.log10(fBytes) / Math.log10(1000));
		    String strChangedByte = new DecimalFormat("#,##0.#").format(fBytes / Math.pow(1000, digitGroups)) + units[digitGroups];
		    
		    strByteUnit = strChangedByte + unit;
	    }
		return strByteUnit;
	}
}
