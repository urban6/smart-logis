package kr.co.shovvel.dm.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class StringUtil {

	/**
	 * [NULL] 입력값이 null 일 경우 "" 를 반환
	 *
	 * @param s
	 */
	public static String null2void( Object s ) {
		return (String) ((isNull( s )) ? "" : s);
	}

	/**
	 * [NULL] 입력값이 null 일 경우 지정된 String으로 변환
	 *
	 * @param s
	 */
	public static String null2void( Object s , String def ) {
		return (String) ((isNull( s )) ? def : s);
	}

	/**
	 * [NULL] 해당 String 이 "", null 인지 반환한다.
	 *
	 * @param s
	 * @return
	 */
	public static boolean isNull( Object s ) {
		return (s == null) || ((s.toString()).length() < 1);
	}

	/**
	 * [NULL] 해당 String을 Trim() 후 값이 "", null 인지 반환한다.
	 *
	 * @param s
	 * @return
	 */
	public static boolean isNullTrim( Object s ) {
		return (s == null) || ((s.toString()).trim().length() < 1);
	}

	/**
	 * [NULL] 해당 String을 Replace("\r\n", "\n", "\r"), Trim() 후 값이 "", null 인지 반환한다.
	 *
	 * @param s
	 * @return
	 */
	public static boolean isNullEnterTrim( Object s ) {
		if ( s == null )
			return true;
		String str = null2void( s , "" );
		str.replace( "\r\n" , "" );
		str.replace( "\r" , "" );
		str.replace( "\n" , "" );
		return (str.trim().length() < 1);
	}

	/**
	 * [GAP] 내용중에 공백을 제거
	 *
	 * @param src
	 *                변경할 문자열
	 * @return
	 */
	public static String gapRemove( String src ) {
		return replace( src , " " , "" , true );
	}

	/**
	 * [REPLACE] 특정 문자열 변경
	 *
	 * @param src
	 *                변경할 문자열
	 * @param org
	 *                변경대상 문자열
	 * @param tar
	 *                변경할 문자열
	 * @return
	 */
	public static String replace( String src , String org , String tar ) {
		return replace( src , org , tar , true );
	}

	/**
	 * [REPLACE] 특정 문자열 전체 변경
	 *
	 * @param src
	 *                변경할 문자열
	 * @param org
	 *                변경대상 문자열
	 * @param tar
	 *                변경할 문자열
	 * @param all
	 *                전체를 다 변경할것인지 (true 일경우 전체, false 일경우 첫번째)
	 * @return
	 */
	public static String replace( String src , String org , String tar , boolean all ) {
		if ( src == null ) {
			return "";
		}

		if ( org == null || tar == null || src.indexOf( org ) == -1 ) {
			return src;
		}

		String			tmp1		= src;
		StringBuilder	sbResult	= new StringBuilder();

		if ( all ) {
			int nIndex = 0;
			while ( (nIndex = tmp1.indexOf( org )) > -1 ) {
				sbResult.append( tmp1.substring( 0 , nIndex ) ).append( tar );
				tmp1 = tmp1.substring( nIndex + org.length() );
			}
			sbResult.append( tmp1 );
		} else {
			int nIndex = tmp1.indexOf( org );
			sbResult.append( tmp1.substring( 0 , nIndex ) ).append( tar ).append( tmp1.substring( nIndex + org.length() ) );
		}
		return sbResult.toString();
	}

	/**
	 * [FILL String] 입력한 String value 를 해당길이에 맞고 정렬 방법에 맞게 수정
	 *
	 * @param value
	 *                      입력값
	 * @param length
	 *                      길이
	 * @param padding
	 *                      길이보다 짧을때 체움 문자
	 * @param aligntype
	 *                      정렬 방법 'R','L','C'
	 * @return String 정렬된 문자열
	 */
	public static String setMaskString( String v , int length , char padding , char aligntype ) {
		return new String( setMaskString( v.getBytes() , length , (byte) padding , aligntype ) );
	}

	/**
	 * [FILL String] 입력한 byte[] value 를 해당길이에 맞고 정렬 방법에 맞게 수정
	 *
	 * @param input
	 *                      입력값
	 * @param length
	 *                      길이
	 * @param padding
	 *                      길이보다 짧을때 체움 문자
	 * @param aligntype
	 *                      정렬 방법 'R','L','C'
	 * @return String 정렬된 문자열
	 */
	public static byte[] setMaskString( byte[] input , int length , byte padding , char aligntype ) {
		byte[]	buffInput	= (input != null) ? input : new byte[ 0 ];
		byte[]	buffPadding	= getPaddingValue( padding , length - buffInput.length );
		byte[]	buffResult	= new byte[ length ];
		if ( buffPadding == null ) {
			System.arraycopy( buffInput , 0 , buffResult , 0 , length );
			return buffResult;
		}
		// 중앙 정렬
		if ( aligntype == 'C' ) {
			int nCount = buffPadding.length / 2;
			System.arraycopy( buffPadding , 0 , buffResult , 0 , nCount );
			System.arraycopy( buffInput , 0 , buffResult , nCount , buffInput.length );
			System.arraycopy( buffPadding , 0 , buffResult , nCount + buffInput.length , buffPadding.length - nCount );
		}
		// 좌측 정렬
		else if ( aligntype == 'L' ) {

			System.arraycopy( buffInput , 0 , buffResult , 0 , buffInput.length );
			System.arraycopy( buffPadding , 0 , buffResult , buffInput.length , buffPadding.length );
		}
		// 우측 정렬
		else {
			System.arraycopy( buffPadding , 0 , buffResult , 0 , buffPadding.length );
			System.arraycopy( buffInput , 0 , buffResult , buffPadding.length , buffInput.length );
		}
		return buffResult;
	}

	/**
	 * [FILL String] '0' 또는 ' '를 byte[] value 를 길이만큼 채워준다
	 *
	 * @param padding
	 *                    길이보다 짧을때 체움 문자
	 * @param length
	 *                    길이
	 * @return
	 */
	public static byte[] getPaddingValue( byte padding , int length ) {
		if ( length < 1 )
			return null;
		final byte[]	MASK_ZERO	= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000".getBytes();
		final byte[]	MASK_SPACE	= "                                                                                                    ".getBytes();

		byte[]			buffResult	= new byte[ length ];
		byte[]			buffMask	= null;
		if ( padding == (byte) '0' ) {
			buffMask = MASK_ZERO;
		} else if ( padding == (byte) ' ' ) {
			buffMask = MASK_SPACE;
		}
		if ( buffMask != null ) {
			int nPos = 0 , nCount = 0;
			while ( nPos < length ) {
				nCount = Math.min( length - nPos , buffMask.length );
				System.arraycopy( buffMask , 0 , buffResult , nPos , nCount );
				nPos += nCount;
			}
		} else {
			for ( int i = 0 ; i < length ; i++ ) {
				buffResult[ i ] = padding;
			}
		}
		return buffResult;
	}

	/**
	 * [REMOVE] 앞에서부터 "0"을 제거(정수형태로 변환)
	 *
	 * @param word
	 *                 : 삭제할 문자열
	 * @return
	 */
	public static String removeFirstWord( String word ) {
		String	sum			= "";
		String	firstWord	= "";
		for ( int i = 0 ; i < word.length() ; i++ ) {
			String dic = word.substring( i , i + 1 );
			if ( i == 0 ) {
				firstWord = dic;
			}
			if ( i != 0 && !firstWord.equals( "0" ) ) {
				sum += dic;
			} else if ( !dic.equals( "0" ) ) {
				sum += dic;
				firstWord = dic;
			}
		}
		return sum;
	}

	/**
	 * [REMOVE] 구분자 제거
	 *
	 * @param str
	 *                  전체문장
	 * @param delim
	 *                  제거할 구분자
	 * @return String 구분자가 제거된 문장
	 */
	public String delDelim( String str , String delim ) {
		if ( str == null || delim == null )
			return null;
		else
			return replace( str , delim , "" );
	}

	/**
	 * [LTRIM] 특정한 문자를 기준으로 왼쪽 문자를 반환하는 기능을 수행
	 *
	 * @param str
	 *                  문자열
	 * @param delim
	 *                  특정문자
	 * @return String
	 */
	public static String lSplit( String str , char delim ) {
		String returnValue = "";
		if ( str == null )
			returnValue = "";
		int i_pos = str.indexOf( delim );
		if ( i_pos != -1 ) {
			returnValue = str.substring( 0 , i_pos );
		} else {
			returnValue = str;
		}
		return returnValue;
	}

	/**
	 * [RTRIM] 특정한 문자를 기준으로 오른쪽 문자를 반환하는 기능을 수행
	 *
	 * @param str
	 *                  문자열
	 * @param delim
	 *                  특정문자
	 * @return String
	 */
	public static String rSplit( String str , char delim ) {
		String returnValue = "";
		if ( str == null )
			returnValue = "";
		int i_pos = str.indexOf( delim );
		if ( i_pos != -1 ) {
			returnValue = str.substring( i_pos + 1 );
		} else {
			returnValue = "";
		}
		return returnValue;
	}

	/**
	 * [LEFT] 좌측부터 글자 길이가 넘으면 자르는 기능
	 *
	 * @param txtData
	 *                    : 대상 문자열
	 * @param Len
	 *                    : 길이
	 * @return
	 */
	public static String cutLeft( String txtData , Integer Len ) {
		String result = StringUtil.null2void( txtData );
		if ( result.length() > Len ) {
			result = result.substring( 0 , Len );
		}
		return result;
	}

	/**
	 * [RIGHT] 우측부터 글자 길이가 넘으면 자르는 기능
	 *
	 * @param txtData
	 *                    : 대상 문자열
	 * @param Len
	 *                    : 길이
	 * @return
	 */
	public static String cutRight( String txtData , Integer Len ) {
		String result = StringUtil.null2void( txtData );
		if ( result.length() > Len ) {
			result = result.substring( result.length() - Len , result.length() );
		}
		return result;
	}

	/**
	 * [Set BR] \n\r 을 <br>
	 * 로 변경
	 *
	 * @param content
	 *                    : 대상 문자열
	 * @return String
	 */
	public static String convertBr( String content ) {
		String returnString;
		if ( content == null || content == "" ) {
			returnString = "";
		} else {
			returnString = content.replaceAll( "\n" , "<br/>" );
		}
		return returnString;
	}

	/**
	 * [NUMBER] 입력문자가 숫자인지 판별하는 기능
	 *
	 * @param str
	 *                문자열
	 * @return boolean
	 */
	public static boolean isNumeric( String str ) {
		if ( str == null ) {
			return false;
		}
		Pattern	p	= Pattern.compile( "([\\p{Digit}]+)(([.]?)(\\p{Digit}]+))?" );
		Matcher	m	= p.matcher( str );
		return m.matches();
	}

	/**
	 * [NUMBER] 숫자가 아닌 값 모두 삭제
	 *
	 * @param src
	 * @return String
	 * @author yongseoklee
	 */
	public static String removeNonNumeric( String src ) {
		if ( src == null || ("" + src).trim().length() == 0 )
			return null;

		return src.replaceAll( "\\D+" , "" );
	}

	/**
	 * [NUMBER] 문자를 숫자로 변환
	 *
	 * @param obj
	 * @return
	 */
	public static int objToNum( String obj ) {
		if ( null == obj || ((obj.toString()).length() < 1) )
			return 0;
		else
			return Integer.parseInt( obj );
	}

	/***
	 * [NUMBER] 랜덤 숫자를 발급
	 *
	 * @param Len
	 * @return
	 */
	public static String rndNum( int Len ) {
		Random	random	= new Random();
		String	result	= String.valueOf( random.nextInt() );
		result += String.valueOf( random.nextInt() );
		result += String.valueOf( random.nextInt() );
		result += String.valueOf( random.nextInt() );
		result += String.valueOf( random.nextInt() );
		result = result.replace( "-" , "" );
		if ( Len > 30 ) {
			Len = 30;
		}
		result = result.substring( 0 , Len );
		return result;
	}

	/**
	 * [HashMap] 배열형식의 Map 데이터를 String Array로 호출
	 *
	 * @param obj
	 *                : Map Data
	 * @return
	 */
	public static ArrayList< String > mapArray( Object mapObj ) {
		ArrayList< String > result = new ArrayList< String >();
		if ( mapObj instanceof String[] ) {
			for ( String objStr : (String[]) mapObj ) {
				result.add( objStr );
			}
		} else if ( mapObj instanceof String ) {
			result.add( mapObj.toString() );
		}
		return result;
	}

	public static ArrayList< String > mapArray( Map< String , Object > mapData , String targetKey ) {
		ArrayList< String > result = new ArrayList< String >();
		if ( mapData.get( targetKey ) instanceof String[] ) {
			for ( String objStr : (String[]) mapData.get( targetKey ) ) {
				result.add( objStr );
			}
		} else if ( mapData.get( targetKey ) instanceof String ) {
			result.add( mapData.get( targetKey ).toString() );
		}
		return result;
	}

	/***
	 * [HashMap] 배열형식의 Map 데이터를 JOIN으로 합쳐서 출력
	 *
	 * @param mapObj
	 * @param delimiter
	 * @return
	 */
	public static String mapArrayJoin( Object mapObj , String delimiter ) {
		String			result		= "";
		List< String >	arrString	= mapArray( mapObj );
		if ( arrString != null ) {
			result = String.join( delimiter , arrString );
		}
		return result;
	}

	public static String mapArrayJoin( Map< String , Object > mapData , String targetKey , String delimiter ) {
		String			result		= "";
		List< String >	arrString	= mapArray( mapData , targetKey );
		if ( arrString != null ) {
			result = String.join( delimiter , arrString );
		}
		return result;
	}

	/**
	 * [HashMap] Map데이터에 값을 추출하여 String으로 출력 (Null인 경우 빈값 추출)
	 *
	 * @param mapObj
	 *                      : Map Data
	 * @param targetKey
	 *                      : 값을 추출할 필드
	 * @return
	 */
	public static long mapLong( Object mapObj ) {
		long result = 0;
		if ( mapObj == null ) {
			return 0;
		}
		try {
			result = Long.valueOf( mapObj.toString() );
		} catch ( NumberFormatException e ) {
			result = 0;
		}
		return result;
	}

	/**
	 * [HashMap] Map데이터에 값을 추출하여 String으로 출력 (Null인 경우 빈값 추출)
	 *
	 * @param mapData
	 *                      : Map Data
	 * @param targetKey
	 *                      : 값을 추출할 필드
	 * @return
	 */
	public static String mapString( Object mapObj ) {
		String result = "";
		if ( mapObj == null ) {
			return "";
		}

		if ( mapObj instanceof String[] ) {
			String[] arrResult = (String[]) mapObj;
			result = arrResult[ 0 ];
		} else if ( mapObj instanceof String ) {
			result = mapObj.toString();
		} else if ( mapObj instanceof Integer || mapObj instanceof Long || mapObj instanceof Float || mapObj instanceof Double ) {
			result = String.valueOf( mapObj );
		}
		return result;
	}

	public static String mapString( Map< String , Object > mapData , String targetKey ) {
		String result = "";
		if ( mapData == null ) {
			return "";
		}
		if ( mapData.get( targetKey ) == null ) {
			return "";
		}

		if ( mapData.get( targetKey ) instanceof String[] ) {
			String[] arrResult = (String[]) mapData.get( targetKey );
			result = arrResult[ 0 ];
		} else if ( mapData.get( targetKey ) instanceof String ) {
			result = mapData.get( targetKey ).toString();
		}
		return result;
	}

	/***
	 * [인코딩] EUC-KR 을 UTF-8 문자열로 변경
	 *
	 * @param strObj
	 * @return
	 */
	public static String euckrToutf8( Object strObj ) {
		String result = "";
		if ( strObj == null ) {
			return "";
		}

		byte[] euckrStringBuffer = String.valueOf( strObj ).getBytes( Charset.forName( "euc-kr" ) );
		try {
			String	decodedFromEucKr	= new String( euckrStringBuffer , "euc-kr" );
			byte[]	utf8StringBuffer	= decodedFromEucKr.getBytes( "utf-8" );
			result = new String( utf8StringBuffer , "utf-8" );
		} catch ( UnsupportedEncodingException e ) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * JSON 문자열을 Map으로 변환
	 *
	 * @param str
	 * @return
	 */
	public static Map< String , Object > convertJsonStringToMap( String str ) {
		Map< String , Object > result = new HashMap< String , Object >();
		try {
			// System.out.println( "-------------------JSON String 을 MAP 으로 변환-----------------------" );

			ObjectMapper objectMapper = new ObjectMapper();

			result = objectMapper.readValue( str , new TypeReference< Map< String , Object > >() {
			} );
			System.out.println( "convertStringToMap=" + result );
		} catch ( JsonGenerationException e ) {
			System.out.println( "convertStringToMap error=" + e.getMessage() );
		} catch ( JsonMappingException e ) {
			System.out.println( "convertStringToMap error=" + e.getMessage() );
		} catch ( IOException e ) {
			System.out.println( "convertStringToMap error=" + e.getMessage() );
		} catch ( Exception e ) {
			System.out.println( "convertStringToMap error=" + e.getMessage() );
		}
		return result;
	}

	/**
	 * Object를 JSON 문자열로 변환
	 *
	 * @param str
	 * @return
	 */
	public static String convertObjectToJsonString( Object obj ) {
		String result = "";
		try {
			// System.out.println( "-------------------Object를 JSON String로 변환-----------------------" );

			ObjectMapper objectMapper = new ObjectMapper();
			result = objectMapper.writeValueAsString( obj );

			// System.out.println( "convertObjectToString=" + result );
		} catch ( JsonGenerationException e ) {
			System.out.println( "convertObjectToString error=" + e.getMessage() );
		} catch ( JsonMappingException e ) {
			System.out.println( "convertObjectToString error=" + e.getMessage() );
		} catch ( IOException e ) {
			System.out.println( "convertObjectToString error=" + e.getMessage() );
		} catch ( Exception e ) {
			System.out.println( "convertObjectToString error=" + e.getMessage() );
		}
		return result;
	}
}
