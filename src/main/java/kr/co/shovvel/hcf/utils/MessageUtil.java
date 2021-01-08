package kr.co.shovvel.hcf.utils;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.MessageSourceAccessor;

/**
 * The Class MessageUtil.
 */
public class MessageUtil {

	/** The ms acc. */
	private static MessageSourceAccessor msAcc = null;

	/**
	 * Sets the message source accessor.
	 *
	 * @param msAcc the new message source accessor
	 */
	public void setMessageSourceAccessor(MessageSourceAccessor msAcc){
		MessageUtil.msAcc = msAcc;
	}
	
	/**
	 * 키에 해당하는 메세지 반환
	 *
	 * @param key the key
	 * @return the message
	 */
	public static String getMessage(String key) {
		return msAcc.getMessage(key, LocaleContextHolder.getLocale());
		
	}
	
	/**
	 * 키에 해당하는 메세지 반환 (파라미터 포함)
	 *
	 * @param key the key
	 * @param objs the objs
	 * @return the message
	 */
	public static String getMessage(String key, Object[] obj){
		return msAcc.getMessage(key, obj, LocaleContextHolder.getLocale());
	}
	
}
