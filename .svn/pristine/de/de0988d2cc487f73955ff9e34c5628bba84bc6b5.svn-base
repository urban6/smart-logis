package kr.co.shovvel.dm.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

public class Unit {

	private static final Logger	logger			= LoggerFactory.getLogger(Unit.class);

	private HttpServletRequest	_request		= null;
	private Map<String, Object>	_req			= new HashMap<String, Object>();
	private Map<String, Object>	_session		= new HashMap<String, Object>();
	private Map<String, Object>	_cookies		= new HashMap<String, Object>();
	private Map<String, Object>	_unit			= new HashMap<String, Object>();
	private String[]			_unitKey		= new String[] {};
	private String				_unitFunc		= new String();

//	private String _sourceDir = new String();
	private String				_sourceRoot		= new String();
	private String				_sourceTarget	= new String();

	/***
	 * Class 진입점
	 *
	 * @param request
	 */
	public Unit( HttpServletRequest request ) {
		// Request & Session
		_request = request;
		_req = RequestUtil.getParameterMap(request);
		_session = RequestUtil.getSessionMap(request);
		_cookies = RequestUtil.getCookieMap(request);
		_sourceRoot = request.getRequestURI();

		String unitKey = EncryptUtil.decode(StringUtil.null2void(_req.get("unitkey")));
		if ( !StringUtil.isNull(unitKey) ) {
			_unitKey = unitKey.split("\\|");
		}
		if ( !StringUtil.isNull(_req.get("unitfunc")) ) {
			_unitFunc = _req.get("unitfunc").toString();
		}

		request.getSession().removeAttribute("unitAlert");

		logger.debug("## REQ : {}" , _req);
		logger.debug("## SESSION : {}" , _session);
		logger.debug("## UnitFunc : {}" , _unitFunc);
		logger.debug("## UnitKey : {}" , _unitKey);

//		System.out.println("## REQ : "+ _req);
//		System.out.println("## SESSION : "+ _session);
//		System.out.println("## UnitFunc : "+ _unitFunc);
//		System.out.println("## UnitKey : "+ _unitKey);
	}

	/***
	 * ModelAndView 설정
	 *
	 * @param source
	 * @return
	 */
	public ModelAndView setMV( String source ) {

		// Path & Url Setting
		_sourceRoot = StringUtil.null2void(source , _sourceRoot);
//		_sourceDir = _sourceRoot.substring(0,  _sourceRoot.lastIndexOf("/")+1 );

		// Model & View
		ModelAndView mv = new ModelAndView();
		if ( !StringUtil.isNull(_sourceTarget) && !_sourceRoot.equals(_sourceTarget) ) {
			mv = new ModelAndView(new RedirectView(_sourceTarget));
		} else {
			mv = new ModelAndView(_sourceRoot);
		}

		mv.addObject("req" , _req);
		mv.addObject("session" , _session);
		mv.addObject("cookies" , _cookies);
		mv.addObject("unit" , _unit);
		return mv;
	}

	/***
	 * Request Param Get
	 *
	 * @param name
	 * @return
	 */
	public String getReq( String name ) {
		String result = "";
		if ( !StringUtil.isNull(_req.get(name)) ) {
			result = _req.get(name).toString();
		}
		return result;
	}

	/***
	 * Request Param All Get
	 *
	 * @return
	 */
	public Map<String, Object> getReqAll() {
		return _req;
	}

	/***
	 * Session Param Get
	 *
	 * @param name
	 * @return
	 */
	public String getSes( String name ) {
		String result = "";
		if ( !StringUtil.isNull(_session.get(name)) ) {
			result = _session.get(name).toString();
		}
		return result;
	}

	/***
	 * Session Param All Get
	 *
	 * @return
	 */
	public Map<String, Object> getSesAll() {
		return _session;
	}

	/***
	 * [FRONT 함수] Unit.setKey
	 *
	 * @param source
	 * @param values
	 * @return
	 */
	public static String setKey( String ... values ) {
		String unitKey = "";
		if ( values.length > 0 ) {
			unitKey = EncryptUtil.encode(String.join("|" , values));
		}
		return unitKey;
	}

	/***
	 * [SERVER 함수] Unit.getKeyCnt (키 갯수)
	 *
	 * @param eq
	 * @return
	 */
	public int getKeyCnt() {
		return _unitKey.length;
	}

	/***
	 * [SERVER 함수] Unit.getKey
	 *
	 * @param eq
	 * @return
	 */
	public String getKey( int eq ) {
		String result = "";
		if ( _unitKey.length > eq ) {
			result = _unitKey[ eq ].trim();
		}
		return result;
	}

	/***
	 * [SERVER 함수] Unit.getFunc
	 *
	 * @return
	 */
	public String getFunc() {
		return _unitFunc;
	}

	/***
	 * [SERVER 함수] Unit.isFunc
	 *
	 * @param funcNm
	 * @return
	 */
	public boolean isFunc( String funcNm ) {
		boolean result = false;
		if ( _unitFunc.toUpperCase().equals(funcNm.toUpperCase()) ) {
			result = true;
		}
		return result;
	}

	public void setAlert( String altMsg ) {
		if ( !StringUtil.isNull(altMsg) ) {
			_request.getSession().setAttribute("unitAlert" , altMsg);
		}
	}

	/**
	 * List Map에서 unikey 생성
	 *
	 * @param listData  : ListMap 데이터
	 * @param targetKey : 암호화 시킬 필드키
	 * @param addKey    : 암호화하여 추가할 필드키
	 * @return
	 */
	public static List<Map<String, Object>> setFilekey( List<Map<String, Object>> listData , String FileCd , String targetSeq , String addKey ) {
		if ( listData == null ) {
			return null;
		}
		if ( FileCd == null || "".equals(FileCd) ) {
			return null;
		}
		if ( targetSeq == null || "".equals(targetSeq) ) {
			return null;
		}
		if ( addKey == null || "".equals(addKey) ) {
			return null;
		}
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		for ( Map<String, Object> rowData : listData ) {
			rowData.put(addKey , EncryptUtil.encode(FileCd.toUpperCase() + "|" + rowData.get(targetSeq).toString()));
			result.add(rowData);
		}
		return result;
	}
}
