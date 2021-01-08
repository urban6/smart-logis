package kr.co.shovvel.dm.interceptor;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.management.operation.menu.MenuVO;
import kr.co.shovvel.dm.service.common.CommonService;
import kr.co.shovvel.dm.service.management.operation.menu.MenuService;
import kr.co.shovvel.dm.util.CommonUtil;
import kr.co.shovvel.hcf.utils.ConfigurationUtil;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

public class CustomInterceptor extends HandlerInterceptorAdapter {
	private Logger			logger	= Logger.getLogger( this.getClass() );
	private String			redirectPage;
	private String			noSessionPage;
	private List< String >	noSession;

	@Autowired
	private CommonService	commonService;

	@Autowired
	private MenuService		menuService;

	@Autowired
	private Ehcache			ehcache;

	@Value( "#{configuration['url.ws.call.help']}" )
	private String			urlSendAll;

	@Override
	public boolean preHandle( HttpServletRequest request , HttpServletResponse response , Object handler ) throws Exception {

		logger.debug( "requestURI : " + request.getRequestURI() );

		// listNoSession를 호출하면 무조건 통과
		for ( int i = 0 ; i < noSession.size() ; i++ ) {

			String temp = noSession.get( i ).trim();
			// logger.debug( "noSessionURI : " + temp );

			if ( temp.equals( request.getRequestURI() ) ) {
				return super.preHandle( request , response , handler );
			}
		}

		HttpSession	session			= request.getSession( true );
		PrevSessionUser sessionUser		= (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
		boolean		bAjaxRequest	= this.isAJAXRequest( request );

		// set expireDate
		Date		nowDate			= new Date();
		// Date expireDate = getExpireDate(nowDate, getTimeoutMinute());
		Date		expireDate		= getExpireDate( nowDate , 3600 );
		session.setAttribute( "expireDate" , expireDate );

		if ( sessionUser == null ) {
			response.sendRedirect( redirectPage );
			return false;
		} else {
			// String checkLevelId = commonService.getUserLevelId( sessionUser.getUserSno() );
			String checkLevelId = sessionUser.getUserLevelId();
			logger.debug( "▶▷▶▷▶preHandle sessionUseLevelId ->" + sessionUser.getUserLevelId() );
			logger.debug( "▶▷▶▷▶preHandle checkUseLevelId ->" + checkLevelId );

			// user level 변경여부 체크
			if ( !checkLevelId.equals( sessionUser.getUserLevelId() ) ) {
				// session 중지
				session.invalidate();

				// ajax 체크
				if ( bAjaxRequest ) {
					logger.debug( "▶▷▶▷▶isAjaxRequest true ->" + request.getRequestURI() );
					response.setStatus( 501 );
					return false;
				} else {
					logger.debug( "▶▷▶▷▶isAjaxRequest false ->" + request.getRequestURI() );
					response.sendRedirect( noSessionPage );
					return false;
				}
			}
		}

		bAjaxRequest = true;

		if ( !bAjaxRequest ) {
			// http://127.0.0.1:8080/login/login -> http://127.0.0.1:8080/login/% 변환
			// http://127.0.0.1:8080/login/login/ -> http://127.0.0.1:8080/login/% 변환
			String	url	= request.getRequestURI();
			int		idx	= url.lastIndexOf( "/" );
			if ( idx == url.length() - 1 ) {
				url = url.substring( 0 , idx );
				idx = url.lastIndexOf( "/" );
			}
			url = url.substring( 0 , idx );
			url += "/%";
			logger.debug( "findMenuName.url=" + url );

			Map< String , Object > map = commonService.findMenuName( url , sessionUser.getUserSno() );
			if ( map != null ) {
				session.setAttribute( "upMenuId" , map.get( "UP_MENU_ID" ) );
				session.setAttribute( "menuId" , map.get( "MENU_ID" ) );
				session.setAttribute( "titleName" , map.get( "MENU_NAME" ) );
				session.setAttribute( "authType" , map.get( "AUTH_TYPE" ) );

				logger.debug( "▶▷▶▷▶preHandle sessionUser ->" + sessionUser.toString() );
				Map< String , Object > param = new HashMap< String , Object >();
				param.put( "menuId" , (Integer) map.get( "MENU_ID" ) );
				param.put( "userSno" , sessionUser.getUserSno() );

				// commonService.removeRecent(param);
				// commonService.addRecent(param); //메뉴 등록
			}
		}

		return super.preHandle( request , response , handler );
	}

	@SuppressWarnings( "unchecked" )
	@Override
	public void postHandle( HttpServletRequest request , HttpServletResponse response , Object handler , ModelAndView mv ) throws Exception {

		// listNoSession를 호출하면 무조건 통과
		for ( int i = 0 ; i < noSession.size() ; i++ ) {
			String temp = noSession.get( i ).trim();
			if ( temp.equals( request.getRequestURI() ) ) {
				return;
			}
		}

		super.postHandle( request , response , handler , mv );
		if ( mv != null && !this.isAJAXRequest( request ) ) {
			HttpSession	session		= request.getSession( true );
			PrevSessionUser sessionUser	= (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
			if ( sessionUser != null ) {
				logger.debug( "▶▷▶▷▶postHandle sessionUser ->" + sessionUser.toString() );

				String			user_level_id			= sessionUser.getUserLevelId();

				List< MenuVO >	listAuthorizationMenu	= null;
				Cache			cache					= ehcache.getCacheManager().getCache( "menuCache" );
				Element			menuHtmlElement			= cache.get( user_level_id );
				if ( menuHtmlElement != null && menuHtmlElement.getObjectValue() != null ) {
					logger.debug( "▶▷▶▷▶get menu for user_level_id=" + user_level_id + " from ehcache" );
					listAuthorizationMenu = (List< MenuVO >) menuHtmlElement.getObjectValue();
				} else {
					logger.debug( "▶▷▶▷▶load menu for user_level_id=" + user_level_id );

					listAuthorizationMenu = menuService.listAuthorizationMenu( user_level_id );
					String rootMenuId = "0";
					listAuthorizationMenu = CommonUtil.getOrganizedMenu( rootMenuId , listAuthorizationMenu );

					menuHtmlElement = new Element( user_level_id , listAuthorizationMenu );
					cache.put( menuHtmlElement );
				}
				mv.addObject( "listAuthorizationMenu" , listAuthorizationMenu );
				mv.addObject( "wsUrlSendAll" , urlSendAll );
				mv.addObject( "nowPagePath" , request.getRequestURI() );
				// mv.addObject("listRecent",
				// commonService.findRecent(sessionUser.getUserSno())); //최근 메뉴 목록
			}
		}
	}

	@Override
	public void afterCompletion( HttpServletRequest request , HttpServletResponse response , Object handler , Exception ex ) throws Exception {

		super.afterCompletion( request , response , handler , ex );
	}

	public String getRedirectPage() {
		return redirectPage;
	}

	public void setRedirectPage( String redirectPage ) {
		this.redirectPage = redirectPage;
	}

	public String getNoSessionPage() {
		return noSessionPage;
	}

	public void setNoSessionPage( String noSessionPage ) {
		this.noSessionPage = noSessionPage;
	}

	public List< String > getNoSession() {
		return noSession;
	}

	public void setNoSession( List< String > noSession ) {
		this.noSession = noSession;
	}

	public boolean isAJAXRequest( HttpServletRequest request ) {
		boolean	check		= false;
		String	ajaxRequest	= request.getHeader( "AJAX" );
		if ( ajaxRequest != null && ajaxRequest.equals( "true" ) ) {
			check = true;
		}
		return check;
	}

	private int getTimeoutMinute() {
		return (new ConfigurationUtil()).getLoginSessionTimeout();
	}

	private Date getExpireDate( Date nowDate , int timeoutMinute ) {
		return DateUtils.addMinutes( nowDate , timeoutMinute );
	}
}
