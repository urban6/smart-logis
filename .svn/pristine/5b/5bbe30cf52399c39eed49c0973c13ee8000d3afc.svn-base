package kr.co.shovvel.hcf.utils.crypto;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *  The Class Sha256Util<br>.
 *<br>
 * 사용법<br>
 * <br>
 * public static void main(String[] args)throws Exception { <br>
 * 		String password = "123456"; <br>
 * 		logger.debug("Hex format : " + getEncrypt(password)); <br>
 * }
 */
public class Sha256Util {

	public static String getEncrypt(String source) {
		String result = "";
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(source.getBytes());

			byte byteData[] = md.digest();

			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16)
						.substring(1));
			}
			result = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			
			e.printStackTrace();
		}

		return result;
	}
}
