package kr.co.shovvel.hcf.utils;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

public class StringUtils extends org.apache.commons.lang.StringUtils {

	private static Logger logger = Logger.getLogger(StringUtils.class);
	
	/**
	 * src가 null 거나 ""이면 ""값으로 리턴한다.
	 * 
	 * @param src
	 *            문자열
	 * @return
	 */
	public static String nvl(String src) {
		return nvl(src, "");
	}

	/**
	 * <PRE>
	 * 
	 * src가 null거나 ""이면 tgt값으로 치환하여 return한다.
	 * @param src 문자열
	 * @param tgt 치환할 문자열
	 * @return 치환된 String
	 * 
	 * </PRE>
	 */
	public static String nvl(String src, String tgt) {
		String res = tgt;
		if (tgt == null)
			res = "";
		if (src == null)
			return res;
		else if (src.equals(""))
			return res;
		else
			return src;
	}

	/**
	 * Object가 null 일경우 기본문자열을 리턴한다.
	 * 
	 * @param obj
	 * @param def
	 *            기본 문자열
	 * @return
	 */
	public static String nvl(Object obj) {
		return nvl(obj, "");
	}

	/**
	 * Object가 null 일경우 기본문자열을 리턴한다.
	 * 
	 * @param obj
	 * @param def
	 *            기본 문자열
	 * @return
	 */
	public static String nvl(Object obj, String def) {
		if (obj == null)
			return def;
		return obj.toString();
	}

	/**
	 * 입력받은 String을 원하는 길이만큼 원하는 문자로 오른쪽을 채워주는 함수.
	 * 
	 * @param str
	 *            : 입력 문자열
	 * @param len
	 *            : 채우고 싶은 길이
	 * @param pad
	 *            : 채울문자
	 * @return 채워진 문자열
	 */
	public static String rpad(String str, int len, char pad) {
		String result = str;
		int templen = len - result.getBytes().length;
		for (int i = 0; i < templen; i++) {
			result = result + pad;
		}
		return result;
	}

	/**
	 * 입력받은 String을 원하는 길이만큼 원하는 문자로 왼쪽을 채워주는 함수.
	 * 
	 * @param str
	 *            : 입력 문자열
	 * @param len
	 *            : 채우고 싶은 길이
	 * @param pad
	 *            : 채울문자
	 * @return 채워진 문자열
	 */
	public static String lpad(String str, int len, char pad) {
		String result = str;
		int templen = len - result.getBytes().length;
		for (int i = 0; i < templen; i++)
			result = pad + result;
		return result;
	}

	/**
	 * <PRE>
	 * 
	 * 우편번호 타입으로 변환한다. (예) 630521 --> 630-521
	 * 
	 * </PRE>
	 * 
	 * @param postno
	 *            우편번호
	 * @return 변환된 우편번호 문자열
	 */
	public static String makePostType(String postno) {
		if (postno == null || postno.length() == 0)
			return "";
		if (postno.length() != 6)
			return postno;
		String postno1 = postno.substring(0, 3);
		String postno2 = postno.substring(3, 6);
		return (postno1 + "-" + postno2);
	}

	/**
	 * <PRE>
	 * 
	 * 전화 번호  타입으로 변환한다. (예) 0101234567 --> 010-123-4567
	 * 
	 * </PRE>
	 * 
	 * @param tel
	 *            전화번호
	 * @return 변환된 전화번호 문자열
	 */
	public static String makeTelType(String tel) {
		if (tel == null || tel.length() == 0)
			return "";
		String DELEMETER = "-";
		StringBuffer sb = new StringBuffer();
		String tnum = "";
		if (tel.startsWith("02")) {
			sb.append("02").append(DELEMETER);
			tnum = tel.substring(2);
		} else {
			sb.append(tel.substring(0, 3)).append(DELEMETER);
			tnum = tel.substring(3);
		}

		if (tnum.length() == 7) {
			sb.append(tnum.substring(0, 3)).append(DELEMETER).append(
					tnum.substring(3));
		} else if (tnum.length() == 8) {
			sb.append(tnum.substring(0, 4)).append(DELEMETER).append(
					tnum.substring(4));
		} else {
			return tel;
		}
		return sb.toString();
	}

	/**
	 * <PRE>
	 * 
	 * 주민등록 번호 타입으로 변환한다. (예) 6305211234567 --> 630521-1234567
	 * 
	 * </PRE>
	 * 
	 * @param postno
	 *            주민번호
	 * @return 변환된 주민번호 문자열
	 */
	public static String makeJuminType(String jumin) {
		if (jumin == null || jumin.length() == 0)
			return "";
		if (jumin.length() != 13)
			return jumin;
		String postno1 = jumin.substring(0, 6);
		String postno2 = jumin.substring(6);
		return (postno1 + "-" + postno2);
	}

	/**
	 * <PRE>
	 * 
	 * Post Code의 앞 세자리를 반환한다. (예) 123456 --> 123
	 * 
	 * </PRE>
	 * 
	 * @param postcode
	 *            우편번호 문자열
	 * @return 우편번호 앞 세자리 문자열
	 */
	public static String getPostCode1(String postcode) {
		if (postcode == null || postcode.length() == 0)
			return "";

		if (postcode.length() == 6)
			return postcode.substring(0, 3);
		else
			return postcode;
	}

	/**
	 * <PRE>
	 * 
	 * Post Code의 뒷 세자리를 반환한다. (예) 123456 --> 456
	 * 
	 * </PRE>
	 * 
	 * @param postcode
	 *            우편번호 문자열
	 * @return 우편번호 뒷 세자리 문자열
	 */
	public static String getPostCode2(String postcode) {
		if (postcode == null || postcode.length() == 0)
			return "";

		if (postcode.length() == 6)
			return postcode.substring(3);
		else
			return postcode;
	}

	/**
	 * <PRE>
	 * 
	 * 전화 번호의 국번을 반환한다. (예) 0101234567 --> 010,  01112345678 -> 011
	 * 
	 * </PRE>
	 * 
	 * @param tel
	 *            전화번호
	 * @return 국번 문자열
	 */
	public static String getTelNum1(String tel) {
		if (tel == null || tel.length() == 0)
			return "";
		if (tel.startsWith("02")) {
			return "02";
		} else {
			return tel.substring(0, 3);
		}
	}

	/**
	 * <PRE>
	 * 
	 * 전화 번호의 앞번호를 반환한다. (예) 0101234567 --> 123,  01112345678 -> 1234
	 * 
	 * </PRE>
	 * 
	 * @param tel
	 *            전화번호
	 * @return 전화번호 앞번호 문자열
	 */
	public static String getTelNum2(String tel) {
		if (tel == null || tel.length() == 0)
			return "";
		if (tel.startsWith("02")) {
			if ((tel.length() - 2) == 7)
				return tel.substring(2, 5);
			else if ((tel.length() - 2) == 8)
				return tel.substring(2, 6);
			else
				return tel;
		} else {
			if ((tel.length() - 3) == 7)
				return tel.substring(3, 6);
			else if ((tel.length() - 3) == 8)
				return tel.substring(3, 7);
			else
				return tel;
		}
	}

	/**
	 * <PRE>
	 * 
	 * 전화 번호의 뒷번호를 반환한다. (예) 0101234567 --> 4567,  01112345678 -> 5678
	 * 
	 * </PRE>
	 * 
	 * @param tel
	 *            전화번호
	 * @return 전화번호 뒷번호 문자열
	 */
	public static String getTelNum3(String tel) {

		if (tel == null || tel.length() == 0)
			return "";
		if (tel.startsWith("02")) {
			if ((tel.length() - 2) == 7) {
				// logger.debug( tel.substring( 5 ) );
				return tel.substring(5);
			} else if ((tel.length() - 2) == 8) {
				// logger.debug( tel.substring( 6 ) );
				return tel.substring(6);
			} else
				return tel;
		} else {
			if ((tel.length() - 3) == 7) {
				// logger.debug( tel.substring( 6 ) );
				return tel.substring(6);
			} else if ((tel.length() - 3) == 8) {
				// logger.debug( tel.substring( 7 ) );
				return tel.substring(7);
			} else
				return tel;
		}
	}

	/**
	 * <PRE>
	 * 
	 * 성별 Type을 받아서 "남자, 여자"를 반환한다. (예) W -> 여자 , femail -> 여자 , m -> 남자
	 * 
	 * </PRE>
	 * 
	 * @param gender
	 * @return "남자/여자"
	 */
	public static String getGender(String gender) {
		if (gender == null || gender.length() == 0)
			return "";

		String gen = gender.toUpperCase();
		if (gen.equals("F") || gen.equals("FEMAIL") || gen.equals("W")
				|| gender.equals("WOMAN")) {
			return "여자";
		} else if (gen.equals("M") || gen.equals("MAIL")
				|| gender.equals("MAN")) {
			return "남자";
		} else {
			return gender;
		}
	}

	/**
	 * <pre>
	 *  space 를 _로 변환해서 리턴한다(get방식에서의 한글 스페이스 문제)
	 *  (예 : 홍 길 동 --> 홍_길_동)
	 * 
	 * </pre>
	 * 
	 * @param args
	 *            : 스페이스를 포함한 한글 문자열
	 * @return '_'를 포함한 한글 문자열
	 */
	public String encodeSpace(String str) {

		StringTokenizer st = new StringTokenizer(str);
		String spString = "";
		while (st.hasMoreTokens()) {
			spString = spString + st.nextToken() + "_";
		}
		return spString;
	}

	/**
	 * <pre>
	 * 
	 *  _ 를 space로 변환해서 리턴한다(get방식에서의 한글 스페이스 문제)
	 *  (예 : 홍_길_동 --> 홍 길 동)
	 * 
	 * </pre>
	 * 
	 * @param args
	 *            : '_'를 포함한 한글 문자열
	 * @return '_'를 제외한 한글 문자열
	 */
	public String decodeSpace(String str) {
		StringTokenizer st = new StringTokenizer(str, "_");
		String returnStr = "";
		while (st.hasMoreTokens()) {
			returnStr = returnStr + st.nextToken() + " ";
		}
		return returnStr;
	}

	/**
	 * <PRE>
	 * 
	 * 문자열중 특정문자를 제거한다 (예) 2001/01/01 ==> 20010101
	 * 
	 * </PRE>
	 * 
	 * @param str
	 *            대상문자열
	 * @param tok
	 *            제거할 문자열
	 * @return 완성된 문자열
	 */
	public static String remove(String str, String tok) {
		return replaceAll(str, tok, "");
	}

	/**
	 * Replace given source string with target string.
	 * 
	 * @return Replaced string.
	 * @param str1
	 *            Original string.
	 * @param str2
	 *            치환하고싶은 문자
	 * @param replace
	 *            치환할 문자
	 */
	public static String replace(String str1, String str2, String replace) {
		return replace(str1, 0, str2, replace);
	}

	/**
	 * Replace string start from given offset to given length.
	 * 
	 * @return String Replaced string.
	 * @param str
	 *            Original string.
	 * @param off
	 *            Given offset.
	 * @param len
	 *            Given length.
	 * @param replace
	 *            Given replcae string.
	 */
	public static String replace(String str, int off, int len, String replace) {
		StringBuffer buff = new StringBuffer(str);
		buff.replace(off, off + len, replace);
		return buff.toString();
	}

	/**
	 * Relace string start from given offset and replace one str2 with given
	 * replace string.
	 * 
	 * @return Replaced string.
	 * @param str1
	 *            Original string.
	 * @param off
	 *            Given offset.
	 * @param str2
	 *            Given string that will be replaced by other string.
	 * @param replace
	 *            Given replcae string.
	 */
	public static String replace(String str1, int off, String str2,
			String replace) {
		off = str1.indexOf(str2, off);
		if (off == -1)
			return str1;

		StringBuffer buff = new StringBuffer(str1);
		buff.replace(off, off + str2.length(), replace);
		return buff.toString();
	}

	/**
	 * Relace string start from given offset and replace all of str2 with given
	 * replace string.
	 * 
	 * @return Replaced string.
	 * @param str1
	 *            Original string.
	 * @param off
	 *            Given offset
	 * @param str2
	 *            Given source string.
	 * @param replace
	 *            Given target string.
	 */
	public static String replaceAll(String str1, int off, String str2,
			String replace) {
		if (str1 == null || str2 == null || replace == null)
			return str1;

		off = str1.indexOf(str2, off);
		StringBuffer buff = new StringBuffer(str1);
		while (off != -1) {
			buff.replace(off, off + str2.length(), replace);
			str1 = buff.toString();
			if (off + str2.length() < str1.length())
				off = str1.indexOf(str2, off + replace.length());
			else
				off = -1;
		}
		return str1;
	}

	/**
	 * Replace all source string to given target string.
	 * 
	 * @return Replcaed string.
	 * @param str1
	 *            Original string.
	 * @param str2
	 *            Given source string.
	 * @param replace
	 *            Given target string.
	 */
	public static String replaceAll(String str1, String str2, String replace) {
		return replaceAll(str1, 0, str2, replace);
	}

	/**
	 * <pre>
	 * 
	 *  str1 문자열을 str2 문자열로 파싱하여 문자배열로 리턴한다.
	 *  String str1 : 파싱할 문자
	 * <br>
	 * 
	 *  String str2 : 토큰
	 * 
	 * </pre>
	 * 
	 * @param str1
	 *            : Original string.
	 * @param str2
	 *            : 파싱할 문자
	 * @return Vector
	 */
	/*
	 * public static Vector split( String str1, String str2 ) { String str = "";
	 * String newStr = str1; Vector v = new Vector( ); while( newStr.length( ) >
	 * 0 ) { if (newStr.indexOf( str2 ) >= 0) { //구분자가 있다면 int ord =
	 * newStr.indexOf( str2 ); //구분자의 위치 str = newStr.substring( 0, ord ); //구분자
	 * 앞까지 잘라냄 v.addElement( new String( str ) ); newStr = newStr.substring( ord
	 * + 1 ); } else { v.addElement( new String( newStr ) ); break; } } return
	 * v; }
	 */

	/**
	 * 입력받은 문자열 중 size(byte)를 넘지 않도록 계산해서 해당 문자열을 돌려줌.
	 * 
	 * @param p_str
	 *            : 문자열
	 * @param p_len
	 *            : length
	 * @return
	 */
	public static String getShortString(String p_str, int p_len) {
		boolean chkFlag = false;
		String strName = p_str.trim();
		byte[] arName = strName.getBytes();
		if (arName.length > p_len) {
			for (int idx = 0; idx < p_len; idx++) {
				if (arName[idx] < 0) { // 0x80 이상 ( 1byte짜리. 키값들)
					chkFlag = !chkFlag; // true로
				} else {
					chkFlag = false; // false로
				}
			}
			if (chkFlag) {
				strName = new String(arName, 0, p_len + 1); // 홀수이면
			} else {
				strName = new String(arName, 0, p_len); // 짝수일때
			}
		} else {
			strName = new String(arName, 0, arName.length);
		}
		return strName;
	}

	/**
	 * 주어진 str을 max 만큼 자르고 뒤에 '...'을 붙인다.
	 * 
	 * <pre>
	 * 
	 * // for limited to 18 characters.
	 * ex) 'What are you doing now?' -> 'What are you doing...'
	 * 
	 * </pre>
	 * 
	 * @param str
	 *            Given original string.
	 * @param maxNum
	 *            Limited maximum length.
	 * @return Result string.
	 */
	public static String getShortStatement(String str, int maxNum) {
		return str.length() > maxNum ? getShortString(str, maxNum) + "..."
				: str;
	}

	/**
	 * 문자열에서 숫자만을 가져온다.
	 * 
	 * @return java.lang.String
	 * @param str
	 *            java.lang.String
	 */
	public static String getRawDigit(String str) {
		char[] c = str.toCharArray();
		StringBuffer buff = new StringBuffer();
		for (int i = 0; i < c.length; i++)
			if (Character.isDigit(c[i])) 
				buff.append(c[i]);
		return buff.toString();
	}

	/**
	 * Altibase에서는 Numeric, int 등 숫자 필드에서 Empty String을 입력하려고 하면 Error 발생 Null이
	 * 입력가능한 필드는 null로 입력 할 수 있도록 변환
	 * 
	 * @param inStr
	 * @return
	 */
	public static String changeEmptyStringToNULL(String inStr) {
		if (inStr == null)
			return null;

		if (inStr.equals(""))
			return null;
		else
			return inStr;
	}

	/**
	 * 특수문자를 특수이름으로 변경
	 * 
	 * @param text
	 * @return
	 */
	public static String changeEntityReference(String text) {
		String result = text;

		result = StringUtils.replaceAll(result, "&", "&amp;");
		result = StringUtils.replaceAll(result, "'", "&apos;");
		result = StringUtils.replaceAll(result, "\"", "&quot;");
		result = StringUtils.replaceAll(result, "<", "&lt;");
		result = StringUtils.replaceAll(result, ">", "&gt;");

		return result;

	}

	/**
	 * 특수이름을 특수문자로 변경
	 * 
	 * @param text
	 * @return
	 */
	public static String changeNormalText(String text) {
		String result = text;

		result = StringUtils.replaceAll(result, "&gt;", ">");
		result = StringUtils.replaceAll(result, "&lt;", "<");
		result = StringUtils.replaceAll(result, "&quot;", "\"");
		result = StringUtils.replaceAll(result, "&apos;", "'");
		result = StringUtils.replaceAll(result, "&amp;", "&");

		return result;

	}

	/**
	 * return random String
	 * 
	 * @param minValue
	 * @param maxValue
	 * @param fixLength
	 * @return
	 */
	public static String getRandomString(int minValue, int maxValue,
			int fixLength) {
		double value = NumberUtil.getRandom(minValue, maxValue);
		String str = Double.toString(value);

		int index = str.indexOf(".");
		str = str.substring(0, index);

		if (fixLength == -1)
			return str;
		index = str.length();

		while (index < fixLength) {
			str = "0" + str;

			index++;
		}
		return str;
	}

	public static void main(String[] args) {
		String sText1 = "123_456_789_10";
		String sText2 = "_";
		String sText3 = "=";

		logger.debug("--" + rpad("123", 5, '0'));

		logger.debug("1>>" + remove(sText1, sText2));
		logger.debug("1>>" + replace(sText1, sText2, sText3));
		logger.debug("2>>" + replace("123&&&456", 3, 3, ""));
		logger.debug("3>>" + replace(sText1, 4, sText2, sText3));
		logger.debug("4>>" + replaceAll(sText1, sText2, sText3));
		logger.debug("5>>" + replaceAll(sText1, 4, sText2, sText3));

		logger.debug("6>>" + getRawDigit("ab3c4"));
		logger.debug("8>>" + getShortString("abcde한fg", 6));

		logger.debug("9>>" + getTelNum2("0101230123"));
		logger.debug("9>>" + getTelNum2("01012340123"));

		logger.debug("10>>" + split("010-111-2222", "-"));

	}

	/**
	 * 인자로 받은 String 값이 enumString 값에 해당하는지 체크한다.
	 * 
	 * @param String
	 *            []
	 * @param String
	 * @return boolean
	 */
	public static boolean checkEnumString(String[] list, String val) {
		if (val == null)
			return false;

		for (String s : list) {
			if (s == null)
				continue;
			if (s.equals(val))
				return true;
		}

		return false;
	}
	
	public static String stringToHtml(String sSrc)
	{
		try
		{
			if (sSrc == null || sSrc.equals(""))
				return "";
			StringBuffer sBuf = new StringBuffer();
			int nCount = sSrc.length();
			for (int i=0;i<nCount;i++)
			{
				char cChar = sSrc.charAt(i);
				// &#34; = " 
				if (cChar == '\"')
				{
					sBuf.append("&#34;");
					continue;
				}	
				// &#39; = ' 
				if (cChar == '\'')
				{
					sBuf.append("&#39;");
					continue;
				}
				if (cChar == '#')
				{
					sBuf.append("&#35;");
					continue;
				}
				if (cChar == '&')
				{
					sBuf.append("&#38;");
					continue;
				}
				if (cChar == '<')
				{
					sBuf.append("&#60;");
					continue;
				}
				if (cChar == '>')
				{
					sBuf.append("&#62;");
					continue;
				}
				if (cChar == '\n')
				{
					sBuf.append("<br>\n");
					continue;
				}
				sBuf.append(""+sSrc.charAt(i));
			}
			return sBuf.toString();
		}
		catch (Exception ex)
		{
		}
		return "";
	}

	// convert String into TimeStamp
	public static Timestamp cvtStrIntoTimeStp(String strInpTime) throws ParseException {

		strInpTime = StringUtils.nvl(strInpTime.replaceAll("[^0-9]", ""));
		if (strInpTime == null || strInpTime.length() != 8) {
			return null;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		return new Timestamp ((dateFormat.parse(strInpTime)).getTime());
	}
}
