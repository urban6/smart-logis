package kr.co.shovvel.hcf.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;

public class DateUtil {
	private static final String dateRepresentation = "en";

	public static String dateFormatChangeToString( String date , String format ) throws ParseException {
		SimpleDateFormat	transFormat		= new SimpleDateFormat( format );
		Date				stringDate		= transFormat.parse( date );
		SimpleDateFormat	transFormat1	= new SimpleDateFormat( "yyyyMMdd" );
		return transFormat1.format( stringDate );
	}

	public static String dateFormaVchk( String date , String format ) throws ParseException {

		SimpleDateFormat	transFormat		= new SimpleDateFormat( format );
		Date				stringDate		= transFormat.parse( date );
		SimpleDateFormat	transFormat1	= new SimpleDateFormat( "yyyy-MM-dd" );
		return transFormat1.format( stringDate );
	}

	/**
	 * 10자리 문자열로 되어 있는 시간 값을 1주일이 지나지 않았다면, 몇초전/몇분전/몇일전으로 표시해 주고 1주일이 지났다면,
	 * yyyy.MM.dd hh:mm 포맷으로 리턴.
	 *
	 * @param writtenTime
	 * @return
	 */
	public static String elapsedTime( String writtenTime ) {
		if ( writtenTime == null || writtenTime.trim().isEmpty() ) {
			return "";
		}
		long		writtenL	= Long.parseLong( writtenTime ) * 1000;

		Calendar	writtenAdd7	= Calendar.getInstance();
		writtenAdd7.setTimeInMillis( writtenL );
		writtenAdd7.add( Calendar.DAY_OF_MONTH , 7 );

		Calendar currCal = Calendar.getInstance();
		currCal.setTimeInMillis( System.currentTimeMillis() );

		int		compare	= currCal.compareTo( writtenAdd7 );
		String	result	= "";
		if ( compare < 0 ) {
			// 1주일이 안 지났음.
			long	currTimeL	= currCal.getTimeInMillis();
			long	diffL		= (currTimeL - writtenL) / 1000;

			int		diff		= (int) diffL;

			if ( diff < 60 ) {
				// 초로 리턴
				result = diff + "초전";
			} else if ( diff < 3600 ) {
				// 분으로 리턴
				diff = diff / 60;
				result = diff + "분전";
			} else if ( diff < 86400 ) {
				// 시간으로 리턴
				diff = diff / 3600;
				result = diff + "시간전";
			} else {
				diff = diff / 86400;
				// 일자로 리턴.
				result = diff + "일전";
			}

		} else {
			// 1주일이 지났음.
			SimpleDateFormat formatter = new SimpleDateFormat( "yyyy.MM.dd hh:mm" );
			result = formatter.format( new Date( writtenL ) );
		}

		return result;

	}

	/**
	 * unix 타입의 시간을 변환해준다.
	 *
	 * @param writtenTime
	 * @return
	 */
	public static String getTime( String writtenTime ) {
		if ( writtenTime == null || writtenTime.trim().isEmpty() ) {
			return "";
		}
		long				writtenL	= Long.parseLong( writtenTime ) * 1000;

		String				result		= "";

		SimpleDateFormat	formatter	= new SimpleDateFormat( "yyyy.MM.dd  a hh:mm" );
		result = formatter.format( new Date( writtenL ) );

		return result;

	}

	/**
	 *
	 */
	public static String getNow( String pattern ) {
		if ( pattern == null || pattern.trim().isEmpty() ) {
			pattern = "yyyy-MM-dd HH:mm:ss";
		}

		SimpleDateFormat sdf = new SimpleDateFormat( pattern );

		return sdf.format( new Date() );
	}

	/**
	 * return add day to date strings
	 *
	 * @param String
	 *                   date string
	 * @param int
	 *                   더할 일수
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 일수 더하기
	 *             형식이 잘못 되었거나 존재하지 않는 날짜: java.text.ParseException 발생
	 */
	public static String addDays( String s , int day ) {
		return addDays( s , day , "yyyy-MM-dd" );
	}

	/**
	 * return add day to date strings with user defined format.
	 *
	 * @param String
	 *                   date string
	 * @param int
	 *                   더할 일수
	 * @param format
	 *                   string representation of the date format. For example, "yyyy-MM-dd".
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 일수 더하기
	 *             형식이 잘못 되었거나 존재하지 않는 날짜: null return
	 */
	public static String addDays( String s , int day , String format ) {
		try {
			java.text.SimpleDateFormat	formatter	= new java.text.SimpleDateFormat( format );
			java.util.Date				date		= check( s , format );

			date.setTime( date.getTime() + ((long) day * 1000 * 60 * 60 * 24) );
			return formatter.format( date );
		} catch ( ParseException pe ) {
			// m_logger.debug( pe.toString() );
			return null;
		}
	}

	/**
	 * check date string validation with the default format "yyyyMMdd".
	 *
	 * @param s
	 *              date string you want to check with default format "yyyyMMdd".
	 * @return date java.util.Date
	 */
	public static java.util.Date check( String s ) {
		try {
			return check( s , "yyyy-MM-dd" );
		} catch ( ParseException pe ) {
			return null;
		}
	}

	/**
	 * check date string validation with an user defined format.
	 *
	 * @param s
	 *                   date string you want to check.
	 * @param format
	 *                   string representation of the date format. For example, "yyyy-MM-dd".
	 * @return date java.util.Date
	 */
	public static java.util.Date check( String s , String format ) throws java.text.ParseException {
		if ( s == null )
			throw new java.text.ParseException( "date string to check is null" , 0 );
		if ( format == null )
			throw new java.text.ParseException( "format string to check date is null" , 0 );

		java.text.SimpleDateFormat	formatter	= new java.text.SimpleDateFormat( format );
		java.util.Date				date		= null;
		try {
			date = formatter.parse( s );
		} catch ( java.text.ParseException e ) {
			throw new java.text.ParseException( " wrong date:\"" + s + "\" with format \"" + format + "\"" , 0 );
		}

		if ( !formatter.format( date ).equals( s ) )
			throw new java.text.ParseException( "Out of bound date:\"" + s + "\" with format \"" + format + "\"" , 0 );
		return date;
	}

	/**
	 * 언어에 따른 데이트 포맷 형식을 변환한다.
	 *
	 * @param data
	 * @param targetFormat
	 * @return
	 * @throws java.text.ParseException
	 */
	public static String changeDateFormatToLocale( String data , String targetFormat ) throws java.text.ParseException {

		String	default_target_format	= "yyyy-MM-dd";
		String	result					= "";
		String	localeFormat			= "";
		String	language				= dateRepresentation;

		if ( StringUtils.isEmpty( targetFormat ) ) {
			targetFormat = default_target_format;
		}

		if ( "en".equals( language ) ) {
			localeFormat = "dd-MM-yyyy";
		} else {
			localeFormat = "yyyy-MM-dd";
		}

		result = DateFormatUtils.format( DateUtils.parseDate( data , new String[] { localeFormat } ) , targetFormat );

		return result;

	}

	public static String getDateRepresentation() {
		return DateUtil.dateRepresentation;
	}

	/**
	 * checkExceedDate
	 *
	 * @param strDate
	 *                     String
	 * @param language
	 *                     String
	 * @return String
	 * @throws ParseException
	 */
	public static String checkExceedDate( String strDate , String language ) throws ParseException {
		Date	nowDate		= new Date();
		Date	compareDate	= null;
		String	pattern		= null;

		if ( "en".equals( language ) ) {
			pattern = "ddMMyyyy";
		} else {
			pattern = "yyyyMMdd";
		}

		compareDate = new SimpleDateFormat( pattern ).parse( strDate );

		if ( nowDate.getTime() < compareDate.getTime() ) {
			return DateUtil.getNow( pattern );
		}

		return strDate;
	}

	/**
	 * checkExceedTime
	 *
	 * @param checkDate
	 *                      String
	 * @param checkTime
	 *                      String
	 * @return
	 */
	public static String checkExceedTime( String checkDate , String checkTime ) {
		String	indexDate	= DateUtil.getNow( "yyyyMMdd" );
		String	indexHH		= DateUtil.getNow( "HH" );

		int		mm			= (Integer.parseInt( DateUtil.getNow( "mm" ) ) / 5) * 5;
		String	indexMM		= (mm < 10) ? "0" + Integer.toString( mm ) : Integer.toString( mm );

		String	indexTime	= indexHH + indexMM;

		if ( Integer.parseInt( checkDate ) > Integer.parseInt( indexDate ) ) {
			return indexTime;
		} else if ( Integer.parseInt( checkDate ) == Integer.parseInt( indexDate ) ) {
			if ( Integer.parseInt( checkTime ) > Integer.parseInt( indexTime ) )
				return indexTime;
			else
				return checkTime;
		} else
			return checkTime;
	}

	/**
	 * n 값에 따라 날짜 계산를 계산하여 String으로 전달( n이 0=오늘, -1=어제, 1=내일)
	 *
	 * @param int
	 * @return String
	 */
	public static String getDateStringYYYYMMDD( int n ) {
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date() );
		cal.add( Calendar.DATE , n );
		SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd" );
		return dateFormat.format( cal.getTime() );
	}

	/**
	 * n 값에 따라 날짜 계산를 계산하여 String으로 전달( n이 0=현재, -1=1초전, 1=1초)
	 *
	 * @param int
	 * @return String
	 */
	public static String getDateStringYYYYMMDDHH24MISS( int n ) {

		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date() );
		cal.add( Calendar.SECOND , n );
		SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyyMMddHHmmss" );
		return dateFormat.format( cal.getTime() );
	}

	/**
	 * 오늘 날짜 DATE 객체
	 *
	 * @param int
	 * @return String
	 */
	public static Date sysdate() {
		Date date = new Date();
		return date;
	}

	/**
	 * 날짜 유형 변경
	 *
	 * @param dateStr
	 * @param oldFormat
	 *                      예전 날짜 유형
	 * @param newFormat
	 *                      새로운 날짜 유형
	 * @return
	 */
	public static String convertDateFormat( String dateStr , String oldFormat , String newFormat ) {
		String result = "";
		try {
			SimpleDateFormat	transFormat		= new SimpleDateFormat( oldFormat );
			Date				stringDate		= transFormat.parse( dateStr );
			SimpleDateFormat	transFormat1	= new SimpleDateFormat( newFormat );
			result = transFormat1.format( stringDate );
		} catch ( ParseException e ) {

		}
		return result;
	}
}
