package kr.co.shovvel.hcf.utils.crypto;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.CharEncoding;
import org.apache.commons.codec.binary.Base64;

public class AES128Util {
	private final static String KEY =  "012345678901234567890123";
	private final static String KEY_128 = KEY.substring(0, 128/8);
	
	// 암호화
	public static String encryptAES128(String str) {
		try{
			byte[] keyData = KEY_128.getBytes(CharEncoding.UTF_8);
			//운용모드 CBC, 패딩은 PKCSSPadding
			Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
			
			//Key 와 iv 같게
			//블록 암호의 운용 모드(Block engine modes of operation)가 CBC/OFB/CFB를 사용할 경우에는 
			//Initialization Vector(IV), IvParameterSpec을 설정해줘야한다. 아니면 InvalidAlgorithmParameterException 발생
			c.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(keyData, "AES"), new IvParameterSpec(keyData));
			
			//AES 암호화
			byte[] encrypted = c.doFinal(str.getBytes(CharEncoding.UTF_8));
			//base64 인코딩
			byte[] base64Encoded = Base64.encodeBase64(encrypted);
			
			String result = new String(base64Encoded, CharEncoding.UTF_8);
			return result;
			
		} catch(Exception e){
			return null;
		}
	}

	// 복호화
	public static String decyptAES128(String enStr) {
		try{
			byte[] keyData = KEY_128.getBytes(CharEncoding.UTF_8);
			//운용모드 CBC, 패딩은 PKCSSPadding
			Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");

			c.init(Cipher.DECRYPT_MODE, new SecretKeySpec(keyData, "AES"), new IvParameterSpec(keyData));
			
			//base64 디코딩
			byte[] base64Decoded = Base64.decodeBase64(enStr.getBytes(CharEncoding.UTF_8));
			//AES 복호화
			byte[] decrypted = c.doFinal(base64Decoded);
			
			String result = new String(decrypted, CharEncoding.UTF_8);
			return result;
			
		} catch(Exception e){
			return null;
		}
	}
}
