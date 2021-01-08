package kr.co.shovvel.dm.util;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class SearchUtil {

	/**
	 * 검색어를 Session에 담는 함수
	 *
	 * @param request
	 * @param searchGrp
	 */
	@SuppressWarnings( "unchecked" )
	public static void setValues( HttpServletRequest request , String searchGrp ) {
		Map<String, Object>	parameterMap	= new HashMap<String, Object>();
		Enumeration<?>		enums			= request.getParameterNames();
		while ( enums.hasMoreElements() ) {
			String		paramName	= (String) enums.nextElement();
			String[]	parameters	= request.getParameterValues(paramName);

			if ( parameters.length > 1 ) {
				// Parameter가 배열일 경우
				parameterMap.put(paramName , parameters);
				for ( String item : parameters ) {
					parameterMap.put(paramName + "_" + item , item);
				}
			} else {
				// Parameter가 배열이 아닌 경우
				parameterMap.put(paramName , parameters[ 0 ]);
				parameterMap.put(paramName + "_" + parameters[ 0 ] , parameters[ 0 ]);
			}
		}

		// Search Param Code
		if ( "".equals(searchGrp) ) {
			searchGrp = request.getRequestURI();
		}
		searchGrp = EncryptUtil.md5(searchGrp).substring(0 , 10);

		// Search Group Map
		Map<String, Object> paramObj = new HashMap<String, Object>();

		// Search group Setting
		if ( request.getSession().getAttribute("search-group") == null ) {
			paramObj = new HashMap<String, Object>();
			paramObj.put(searchGrp , parameterMap);
			request.getSession().setAttribute("search-group" , searchGrp);
			request.getSession().setAttribute("search-params" , paramObj);
		} else {
			if ( searchGrp.equals(request.getSession().getAttribute("search-group").toString()) ) {
				if ( request.getSession().getAttribute("search-params") == null ) {
					paramObj.put(searchGrp , parameterMap);
				} else {
					paramObj = (Map<String, Object>) request.getSession().getAttribute("search-params");
				}
				paramObj.put(searchGrp , parameterMap);
				request.getSession().setAttribute("search-group" , searchGrp);
				request.getSession().setAttribute("search-params" , paramObj);
			} else {
				request.getSession().removeAttribute("search-group");
				request.getSession().removeAttribute("search-params");
			}
		}
	}

	/**
	 * 검색어에 추가로 값을 추가하는 함수
	 *
	 * @param request
	 * @param searchGrp
	 * @param key
	 * @param value
	 */
	@SuppressWarnings( "unchecked" )
	public static void addValues( HttpServletRequest request , String searchGrp , String key , Object value ) {
		// Search Param Code
		if ( "".equals(searchGrp) ) {
			searchGrp = request.getRequestURI();
		}
		searchGrp = EncryptUtil.md5(searchGrp).substring(0 , 10);

		// Data Read And Write
		Map<String, Object>	paramObj	= new HashMap<String, Object>();
		Map<String, Object>	valuesMap	= new HashMap<String, Object>();
		if ( request.getSession().getAttribute("search-params") != null ) {
			paramObj = (Map<String, Object>) request.getSession().getAttribute("search-params");
			valuesMap = (Map<String, Object>) paramObj.get(searchGrp);
		}

		valuesMap.put(key , value);
		paramObj.put(searchGrp , valuesMap);
		request.getSession().setAttribute("search-params" , paramObj);
	}

	/**
	 * 검색어를 Session에서 얻는 함수
	 *
	 * @param request
	 * @param searchGrp
	 * @return
	 */
	@SuppressWarnings( "unchecked" )
	public static Map<String, Object> getValues( HttpServletRequest request , String searchGrp ) {
		Map<String, Object> valuesMap = new HashMap<String, Object>();

		// Search Param Code
		if ( "".equals(searchGrp) ) {
			searchGrp = request.getRequestURI();
		}
		searchGrp = EncryptUtil.md5(searchGrp).substring(0 , 10);

		// Search Group Map
		if ( request.getSession().getAttribute("search-group") != null ) {
			Map<String, Object> paramObj = new HashMap<String, Object>();
			if ( searchGrp.equals(request.getSession().getAttribute("search-group")) ) {
				if ( request.getSession().getAttribute("search-params") == null ) {
					paramObj = new HashMap<String, Object>();
				} else {
					paramObj = (Map<String, Object>) request.getSession().getAttribute("search-params");
					valuesMap = (Map<String, Object>) paramObj.get(searchGrp);
				}
			} else {
				setValues(request , searchGrp);
			}
		}
		return valuesMap;
	}

	/**
	 * Search값에 기본값이 없는 경우 추가
	 *
	 * @param searchMap
	 * @param key
	 * @param value
	 * @return
	 */
	public static Map<String, Object> setDefault( Map<String, Object> searchMap , String key , String value ) {
		if ( searchMap.containsKey(key) ) {
			String thisValue = searchMap.get(key) == null ? "" : searchMap.get(key).toString();
			if ( !"".equals(thisValue) ) {
				value = thisValue;
			}
		}
		searchMap.put(key , value);
		return searchMap;
	}

}
