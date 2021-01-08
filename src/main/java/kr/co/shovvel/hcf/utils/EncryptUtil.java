package kr.co.shovvel.hcf.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;

public class EncryptUtil {

	// 암호화 키
	private static String[] _encKeyCd = {"f4","9h","U0","tM","EZ","Wj","h6","xh","FG","U2"};
	private static String _encBase = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	private static String[] _encChar = {
		 "ht3GHw7foFbjPzVD+deqkYQ9g4A1BOxEZI/mrac6NSui=U2LJsTWpCRl8nMK5vX0y"
		,"z01SEAwxcM3=TFPlm4Da+OKJnoijkCb2/pqVQR78NhIuL9WUstHBydv6grXYZG5ef"
		,"ygJc1/TQe3C7rf4bSYoRl8vLAx+d=9h60wMm2OaK5uEZDHjsXkBWUFGpPNzqiIntV"
		,"PzVLJWu5poYQxh1Bnm4tb2gXijKRZc6Dyf+aU0AE=78/deHkOvwl9GS3NrqFsTICM"
		,"/NygJsXkBRl8vr3CuEZGpPf4bSY7=V9hLAx1TWjInzU2OaK5oQeqMmt+dic60wFDH"
		,"ab2Dyl9rFQZK78/0AEBc6noYvMxhm4Gftq3NLJWdeHwzVgX=ijkOsTICR+UPu5p1S"
		,"oY9gRmfQZliU2ICvX0AEK1BN5rLJsT=Wpnac6MS3+deqkGHw78/OxyuFbjPzVD4ht"
		,"stHACREB6nox+UPylwm4GcMN=L5pqVgXYZab2DIu/3OK789rFQhijkz01STvJWdef"
		,"3GToFbmU2L+deqkpCu=iK5JsXz/Nygx1BRl8nDHw7V9htMSWjPQvOac6AY0EZIf4r"
		,"UG5po0AE78/deHwsTKac6nh1BrLJWFbQx=2DijPzVf+uY9gRyqkOvXZlICMS3Nm4t"	
	};

	
	/**
	 * 자체 암호화 모듈 : Encode
	 * @param word : 암호화 시킬 평문
	 * @return
	 */
	public static String encode( String word ){
		if ( word == null ){ return ""; }
		if ( "".equals(word) ){ return ""; }
		int keyCd = ((int)( Math.random() * 10) + 1) - 1;
		String encWord = "";		
		String base64word = Base64encode(word);		
		for (int index=0; index < base64word.length(); index++ ){
			String wordBlock = base64word.substring(index, index+1);
			int wordIndex = _encBase.indexOf( wordBlock );			
			if ( wordIndex > -1 ){
				encWord += _encChar[keyCd].substring(wordIndex, wordIndex+1);
			} else {
				encWord += wordBlock;
			}
		}
		encWord = encWord.replace("+", "26b1722");
		encWord = encWord.replace("/", "50cc7d9");
		encWord = _encKeyCd[keyCd] + encWord;
		return encWord;
	}
	
	/**
	 * 자체 암호화 모듈 : Decode
	 * @param encWord : 암호화 된 문장
	 * @return
	 */
	public static String decode( String encWord ){
		if ( encWord == null ){ return ""; }	
		if ( "".equals(encWord) ){ return ""; }
		int keyCd = -1;
		for (int i=0; i<_encKeyCd.length; i++) {
		    if (_encKeyCd[i].equals(encWord.substring(0,2))) { 	keyCd = i;  break;  }
		}
		if ( keyCd < 0 ){ return ""; }		
		
		String base64word = encWord.substring(2);
		base64word = base64word.replace("50cc7d9", "/");
		base64word = base64word.replace("26b1722", "+");
		
		String word = "";
		boolean identify = true;
		for (int index=0; index < base64word.length(); index++ ){
			String encBlock = base64word.substring(index, index+1);
			int wordIndex =  _encChar[keyCd].indexOf( encBlock );			
			if ( wordIndex < 0 ){ identify = false; break; }			
			word += _encBase.substring(wordIndex, wordIndex+1);		
		}
		word = Base64decode(word);
		if ( !identify ){ word = ""; }
		return word;
	}
	
	
	
	
	
	/**
	 * BASE64 :: Encode
	 * @param word : 암호화 시킬 평문
	 * @return
	 */
	public static String Base64encode ( String word 	)
	{
		if ( "".equals(word) ) { return ""; }
		try {
			word = URLEncoder.encode(word, "UTF-8");				
		} catch (UnsupportedEncodingException e) { e.printStackTrace(); }
		byte[] encoded = Base64.encodeBase64(word.getBytes());
		return new String(encoded);
	}
		
	/**
	 * BASE64 :: Decode
	 * @param encWord : 암호화 된 문장
	 * @return
	 */
	public static String Base64decode ( String encWord 	)
	{
		if ( "".equals(encWord) ) { return ""; }
		String word = "";
		byte[] decoded = Base64.decodeBase64(encWord.getBytes());
		try {
			word = URLDecoder.decode(new String(decoded), "UTF-8");
		} catch (UnsupportedEncodingException e) { e.printStackTrace(); }
		return word;
	}
	
	/**
	 * MD5 암호화
	 * @param word : 암호화 할 텍스트
	 * @return
	 */
	public static String md5(String word){
		String MD5 = ""; 
		try{
			MessageDigest md = MessageDigest.getInstance("MD5"); 
			md.update(word.getBytes()); 
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			MD5 = sb.toString();
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace(); 
			MD5 = null; 
		}
		return MD5;
	}
	
	/**
	 * SHA256 암호화
	 * @param word : 암호화 할 텍스트
	 * @return
	 */
	public static String sha256(String word){
		String SHA = ""; 
		try{
			MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
			sh.update(word.getBytes()); 
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace(); 
			SHA = null; 
		}
		return SHA;
	}
	
	
	
	
	
	
	/**
	 * List Map에서 특정 필드를 암호화하여 추가
	 * @param listData : ListMap 데이터
	 * @param targetKey : 암호화 시킬 필드키
	 * @param addKey : 암호화하여 추가할 필드키
	 * @return
	 */
	public static List<Map<String, Object>> ListMapEncode( List<Map<String, Object>> listData, String targetKey, String addKey)
	{		
		if ( listData == null ){ return null; }
		if ( targetKey == null || "".equals(targetKey) ){ return null; }
		if ( addKey == null || "".equals(addKey) ){ return null; }
		
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();		
		for ( Map<String, Object> rowData : listData){
			rowData.put(addKey, EncryptUtil.encode( rowData.get(targetKey).toString() ));
			result.add(rowData);
		}		
		return result;		
	}
}
