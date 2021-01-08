package kr.co.shovvel.hcf.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.Calendar;
import java.util.Locale;
import java.util.TimeZone;
import java.util.concurrent.TimeUnit;

public class LocaleUtil {
	
	public static ZoneOffset getZoneOffset(TimeZone timeZone) { //for using ZoneOffsett class
    	ZoneId zi = timeZone.toZoneId();
    	System.out.println(zi);
        OffsetDateTime odt = OffsetDateTime.now(zi);
        return odt.getOffset();
    }

    public static long getOffsetHours(TimeZone timeZone) { //just hour offset
        ZoneOffset zo = getZoneOffset(timeZone);
        return TimeUnit.SECONDS.toHours(zo.getTotalSeconds());
    }
    
    public static String getZoneOffset(Locale locale, String databaseZoneOffset) {
    	Calendar calendar = Calendar.getInstance(locale);
    	
//    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss (z Z)");
//    	TimeZone tz = TimeZone.getTimeZone("Asia/Seoul"); 
//    	df.setTimeZone(tz);
//    	System.out.format("%s%n%s%n%n", tz.getDisplayName(), df.format(date));

    	
    	int nDatabaseZoneOffset = Integer.parseInt(databaseZoneOffset);
    	
    	TimeZone clientTimeZone = calendar.getTimeZone();
    	ZoneOffset zoneOffset = getZoneOffset(clientTimeZone);
    	//zoneOffset = ZoneOffset.of("" + -(nDatabaseZoneOffset));
        
    	return zoneOffset + "";
    }
    
    public static long getOffsetHours(Locale locale) {
    	Calendar calendar = Calendar.getInstance(locale);
    	TimeZone clientTimeZone = calendar.getTimeZone();
    	
    	return getOffsetHours(clientTimeZone);
    }
}
