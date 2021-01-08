package kr.co.shovvel.hcf.utils;

public class PasingUtil {

	public static int getPage( Integer page , Integer perPage , Integer totalCount ) {
		int overridePage = (int) Math.ceil( (float) totalCount / (float) perPage );
		if ( overridePage == 0 )
			return 1;
		else if ( page > overridePage )
			return overridePage;
		return page;
	}

	public static int getStartRowNum( int page , int perPage ) {
		int start = ((page - 1) * perPage);
		return start;
	}

	public static int getEndRowNum( int page , int perPage ) {
		int end = perPage;
		return end;
	}
}
