package kr.co.shovvel.dm.common;

public abstract class DMConstants {
	
	
	public abstract static class Result {
		public static final String SUCC		= "succ";
		public static final String OK 	    = "OK";
		public static final String FAIL 	= "FAIL";
		public static final String ERROR 	= "ERROR";
	}
	
	public abstract static class Operation {
		public static final String UPPER_PARTNER_CLCD	= "50201000";
	}
		
	public abstract static class DateFormat {
		public static final String PATTERN 	= "yyyy-MM-dd HH:mm:ss";
	}
}
