package kr.co.shovvel.dm.util;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public class RequestUtil {

	/**
	 * Request 변수를 MAP으로 맵핑
	 *
	 * @param request
	 * @return
	 */
	public static Map<String, Object> getParameterMap( HttpServletRequest request ) {
		Map<String, Object>	parameterMap	= new HashMap<String, Object>();
		Enumeration<?>		enums			= request.getParameterNames();
		while ( enums.hasMoreElements() ) {
			String		paramName	= (String) enums.nextElement();
			String[]	parameters	= request.getParameterValues(paramName);

			// Parameter가 배열일 경우
			if ( parameters.length > 1 ) {
				parameterMap.put(paramName , parameters);
				// Parameter가 배열이 아닌 경우
			} else {
				parameterMap.put(paramName , String.valueOf(parameters[ 0 ]).replace("?" , "&#63;").replace("'" , "&#39;"));
			}
		}
		return parameterMap;
	}

	public static Map<String, Object> getParameterMap( MultipartHttpServletRequest request ) {
		Map<String, Object>	parameterMap	= new HashMap<String, Object>();
		Enumeration<?>		enums			= request.getParameterNames();

		while ( enums.hasMoreElements() ) {
			String		paramName	= (String) enums.nextElement();
			String[]	parameters	= request.getParameterValues(paramName);

			// Parameter가 배열일 경우
			if ( parameters.length > 1 ) {
				parameterMap.put(paramName , parameters);
				// Parameter가 배열이 아닌 경우
			} else {
				parameterMap.put(paramName , String.valueOf(parameters[ 0 ]).replace("?" , "&#63;").replace("'" , "&#39;"));
			}
		}
		return parameterMap;
	}

	/**
	 * Request 변수를 MAP으로 맵핑 (변수명을 소문자로 등록)
	 *
	 * @param request
	 * @return
	 */
	public static Map<String, Object> getParameterLcaseMap( HttpServletRequest request ) {
		Map<String, Object>	parameterMap	= new HashMap<String, Object>();
		Enumeration<?>		enums			= request.getParameterNames();
		while ( enums.hasMoreElements() ) {
			String		paramName	= (String) enums.nextElement();
			String[]	parameters	= request.getParameterValues(paramName);

			// Parameter가 배열일 경우
			if ( parameters.length > 1 ) {
				parameterMap.put(paramName.toLowerCase() , parameters);
				// Parameter가 배열이 아닌 경우
			} else {
				parameterMap.put(paramName.toLowerCase() , String.valueOf(parameters[ 0 ]).replace("?" , "&#63;").replace("'" , "&#39;"));
			}
		}
		return parameterMap;
	}

	public static Map<String, Object> getParameterLcaseMap( MultipartHttpServletRequest request ) {
		Map<String, Object>	parameterMap	= new HashMap<String, Object>();
		Enumeration<?>		enums			= request.getParameterNames();

		while ( enums.hasMoreElements() ) {
			String		paramName	= (String) enums.nextElement();
			String[]	parameters	= request.getParameterValues(paramName);

			// Parameter가 배열일 경우
			if ( parameters.length > 1 ) {
				parameterMap.put(paramName.toLowerCase() , parameters);
				// Parameter가 배열이 아닌 경우
			} else {
				parameterMap.put(paramName.toLowerCase() , String.valueOf(parameters[ 0 ]).replace("?" , "&#63;").replace("'" , "&#39;"));
			}
		}
		return parameterMap;
	}

	/**
	 * 세션 정보를 불러옴
	 *
	 * @param request
	 * @return
	 */
	public static Map<String, Object> getSessionMap( HttpServletRequest request ) {
		Map<String, Object>	parameterMap	= new HashMap<String, Object>();
		HttpSession			session			= request.getSession();
		Enumeration<?>		enums			= request.getSession().getAttributeNames();
		while ( enums.hasMoreElements() ) {
			String	paramName	= (String) enums.nextElement();
			String	parameters	= String.valueOf(session.getAttribute(paramName));
			parameterMap.put(paramName , parameters);
		}
		return parameterMap;
	}

	/**
	 * 쿠키 정보를 불러옴
	 *
	 * @param request
	 * @return
	 */
	public static Map<String, Object> getCookieMap( HttpServletRequest request ) {
		Map<String, Object>	parameterMap	= new HashMap<String, Object>();
		Cookie[]			cookies			= request.getCookies();
		if ( cookies != null ) {
			for ( Cookie cookie : cookies ) {
				String	paramName	= (String) cookie.getName();
				String	parameters	= String.valueOf(cookie.getValue());
				parameterMap.put(paramName , parameters);
			}
		}
		return parameterMap;
	}

	/***
	 * 쿠키 정보 등록
	 *
	 * @param key
	 * @param value
	 */
	public static void setCookie( HttpServletResponse response , String key , String value ) {

		if ( !StringUtil.isNull(key) ) {
			Cookie cookie = new Cookie(key, value);
			cookie.setMaxAge(60 * 60 * 24 * 365);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
	}

	/***
	 * 쿠키 정보 삭제
	 *
	 * @param request
	 * @param response
	 * @param key
	 */
	public static void removeCookie( HttpServletRequest request , HttpServletResponse response , String key ) {
		Cookie[] cookies = request.getCookies();
		if ( !StringUtil.isNull(cookies) ) {
			if ( !StringUtil.isNull(key) ) {
				for ( int i = 0 ; i < cookies.length ; i++ ) {
					cookies[ i ].setMaxAge(0);
					cookies[ i ].setPath("/");
					response.addCookie(cookies[ i ]);
				}
			} else {
				for ( int i = 0 ; i < cookies.length ; i++ ) {
					String paramName = (String) cookies[ i ].getName();
					if ( paramName.equals(key) ) {
						cookies[ i ].setMaxAge(0);
						cookies[ i ].setPath("/");
						response.addCookie(cookies[ i ]);
					}
				}
			}
		}
	}

}
