package kr.co.shovvel.dm.service.management.login;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.dao.common.CommonMapper;
import kr.co.shovvel.dm.dao.management.login.PrevLoginMapper;
import kr.co.shovvel.dm.dao.management.operation.loginhist.LoginHistMapper;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.management.login.IpBandwidth;
import kr.co.shovvel.dm.domain.management.login.LoginDomain;
import kr.co.shovvel.dm.domain.management.operation.loginhist.LoginHistDomain;
import kr.co.shovvel.dm.exception.DMException;
import kr.co.shovvel.dm.util.EncryptUtil;
import kr.co.shovvel.hcf.utils.DateUtil;
import kr.co.shovvel.hcf.utils.LocaleUtil;
import kr.co.shovvel.hcf.utils.StringUtils;
import kr.co.shovvel.hcf.utils.crypto.Sha256Util;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.util.*;

@Service
public class PrevLoginService {

	private Logger					logger	= Logger.getLogger( this.getClass() );

	@Autowired
	private PrevLoginMapper loginMapper;

	@Autowired
	private LoginHistMapper			loginHistMapper;

	@Autowired
	private CommonMapper			commonMapper;

	@Autowired
	private CookieLocaleResolver	localeResolver;

	@Value( "#{configuration['database.zoneoffset']}" )
	private String					databaseZoneOffset;

	public String changePasswordAction( String userSno , String current_password , String new_password ) {

		LoginDomain loginUser = loginMapper.searchLoginUserInfo( userSno , current_password );
		if ( loginUser != null ) {
			loginMapper.updatePassword( userSno , new_password , loginUser.getPasswdLifeCycle() , Consts.DEFAULT_PASSWD_YN.NO );
			return "succ";
		} else {
			return "Password doesn’t match. Please try again";
		}
	}

	/**
	 * 로그인 시 login_id에 해당하는 user_sno 조회
	 *
	 * @param loginId
	 * @return
	 */
	public String selectUserSno( String loginId ) {
		String		userSno			= "";

		LoginDomain	selectUserSno	= loginMapper.selectUserSno( loginId );
		if ( selectUserSno != null ) {
			userSno = selectUserSno.getUserSno();
		}
		return userSno;
	}

	/**
	 * 로그인 시 login_id에 해당하는 user_sno, level_id 조회
	 *
	 * @param loginId
	 * @return
	 */
	public LoginDomain selectUserInfo( String loginId ) {
		return loginMapper.selectUserSno( loginId );
	}

	/**
	 * 로그인 처리 프로세스
	 *
	 * @param userSno
	 * @param password
	 * @param request
	 * @param servletContext
	 * @return 0 : 로그인 성공 1 : 로그인 실패 (패스워드 실패) 2 : 로그인 실패 (없는 계정) 5 :
	 *             config.properties 설정 파일 에러 100 : 필수파라메터(아아디 / 비번) null 에러 200 : 총 접속
	 *             유저수 제한 300 : 사용자 계정 잠김 여부 400 : 중복 접속 유저인지 여부 500 : 접속 IP 확인 600 :
	 *             계정기한 기한 만료 700 : 계정기한 만료하기전 알림(노티) 800 : 패스워드 기간 만료하기전 알림(노티) 900 :
	 *             모름
	 * @throws PfnmException
	 * @throws ParseException
	 */
	// @Transactional
	public int certiAction( String userSno , String loginId , String password , HttpServletRequest request , ServletContext servletContext ) throws ParseException {

		// 1. ID와 Password가 존재하는지 확인
		if ( (StringUtils.isEmpty( loginId )) || (StringUtils.isEmpty( password )) ) {
			logger.debug( "▶▷▶▷input data (loginId): " + loginId + " (password): " + password );
			return Consts.LOGIN_RESULT.FAIL_PARAM;
		}

		// 2. 로그인 사용자 정보 생성
		String	language		= DateUtil.getDateRepresentation();
		String	remoteAddress	= request.getRemoteAddr();					// 접속 아이피
		String	nowDateTIme		= commonMapper.getNowDateTime( language );

		// 3. 사용자 아이디로 사용자가 존재하는지 조회
		if ( loginMapper.countUser( loginId ) > 0 ) { // 계정 존재

			LoginHistDomain loginHistDomain = new LoginHistDomain();
			loginHistDomain.setLogin_date( nowDateTIme );
			loginHistDomain.setInout( Consts.LOGIN_INOUT.IN );
			loginHistDomain.setUser_sno( userSno );
			loginHistDomain.setLogin_ip( remoteAddress );
			loginHistDomain.setLogin_client_type( Consts.LOGIN_CLIENT_TYPE.WEB );

			logger.debug( "▶▷▶▷remoteAddress : " + remoteAddress );
			logger.debug( "▶▷▶▷nowDateTIme : " + nowDateTIme );
			logger.debug( " userSno : " + userSno );
			logger.debug( " password : " + password );

			// 5. 로그인 실패 카운트 +1
			loginMapper.updateLoginFailCount( userSno ); // 접속하면 Count 1 업데이트한다.

			LoginDomain searchUserInfo = loginMapper.searchUserInfo( userSno );

			logger.debug( "▶▷▶▷searchUserInfo : " + searchUserInfo );
			logger.debug( " retryCount : " + searchUserInfo.getRetryCount() );
			logger.debug( " lockTime : " + searchUserInfo.getLockTime() );
			logger.debug( " lockType : " + searchUserInfo.getLockType() );

			// login check
			LoginDomain loginUser = loginMapper.searchLoginUserInfo( userSno , password );

			if ( loginUser != null ) { // 로그인 성공

				logger.debug(
						"userSno, lockType : " + loginUser.getUserSno() + "\t" + loginUser.getLastLoginDate() + "\t" + loginUser.getLockType() + "\t" + loginUser.getAbsentLock() + "\t" + loginUser.getAbsentLockDay() );

				logger.debug( "userSno : " + userSno );
				logger.debug( "remoteAddress : " + remoteAddress );

				// 관리자가 등록한 패스워드일 경우 알림
				if ( loginUser.getDefaultPasswdYn().equals( Consts.DEFAULT_PASSWD_YN.YES ) ) {

					return Consts.LOGIN_RESULT.NOTI_DEFAULT_PASSWD;
				}

				// 인증번호 발송
				// 참고 : loginService.resetPassword
				StringBuilder	temporaryCertCode	= new StringBuilder();
				Random			random				= new Random();

				char[]			charset				= "0123456789".toCharArray();
				for ( int i = 0 ; i < 4 ; i++ ) {
					temporaryCertCode.append( charset[ random.nextInt( charset.length ) ] );
				}

				loginUser.setMsgCtcd( Consts.messageCategory.loginCertCode );
				loginUser.setUserSno( userSno );
				loginUser.setMsgCtnt( "[" + loginUser.getUserFnm() + "] 인증번호는 " + temporaryCertCode.toString() + " 입니다." );

				loginMapper.sendSmsPartnerAdminCertCode( loginUser );

				HttpSession session = request.getSession();
				session.setAttribute( "certiCode" , temporaryCertCode.toString() );
				session.setAttribute( "certiTimeInMillis" , Calendar.getInstance().getTimeInMillis() );

				// 로그인 성공 0
				return Consts.LOGIN_RESULT.SUCCESS;

			}
			// 패스워드 오류 로그인 실패
			else {

				logger.debug( "▶▷▶▷login failed" );

				// 로그인 이력처리
				loginHistDomain.setLogin_result( Consts.LOGIN_RSLT.FAILURE );
				loginHistDomain.setDescription( Consts.LOGIN_DESCRIPTION.INVALID_PASSWD );
				loginHistDomain.setFail_count( searchUserInfo.getRetryCount() );

				logger.debug( "▶▷▶▷LoginHistory : " + loginHistDomain.toString() );
				loginHistMapper.insertLoginHistory( loginHistDomain );

				return Consts.LOGIN_RESULT.FAIL_PASSWORD;
			}
		}
		// 계정이 없음
		else {
			logger.info( "▶▷▶▷user id not found" );
			return Consts.LOGIN_RESULT.FAIL_ACCOUNT;
		}
	}

	/**
	 * 로그인 처리 프로세스
	 *
	 * @param userSno
	 * @param password
	 * @param request
	 * @param servletContext
	 * @return
	 *
	 *             <PRE>
	 *	0 : 로그인 성공
	 *	1 : 로그인 실패 (패스워드 실패)
	 *	2 : 로그인 실패 (없는 계정)
	 *	5 : config.properties 설정 파일 에러
	 *	100 : 필수파라메터(아아디 / 비번) null 에러
	 *	200 : 총 접속 유저수 제한
	 *	300 : 사용자 계정 잠김 여부
	 *	400 : 중복 접속 유저인지 여부
	 *	500 : 접속 IP 확인
	 *	600 : 계정기한 기한 만료
	 *	700 : 계정기한 만료하기전 알림(노티)
	 *	800 : 패스워드 기간 만료하기전 알림(노티)
	 *	900 : 모름
	 *             </PRE>
	 *
	 * @throws ParseException
	 */
	// @Transactional
	public int loginAction( String userSno , String loginId , String password , HttpServletRequest request , ServletContext servletContext ) throws ParseException {

		// 1. ID와 Password가 존재하는지 확인
		if ( (StringUtils.isEmpty( loginId )) || (StringUtils.isEmpty( password )) ) {
			logger.debug( "▶▷▶▷input data (loginId): " + loginId + " (password): " + password );
			return Consts.LOGIN_RESULT.FAIL_PARAM;
		}

		// 2. 로그인 사용자 정보 생성
		String	language		= DateUtil.getDateRepresentation();
		String	remoteAddress	= request.getRemoteAddr();					// 접속 아이피
		String	nowDateTIme		= commonMapper.getNowDateTime( language );

		// 3. 사용자 아이디로 사용자가 존재하는지 조회
		if ( loginMapper.countUser( loginId ) > 0 ) { // 계정 존재

			LoginHistDomain loginHistDomain = new LoginHistDomain();
			loginHistDomain.setLogin_date( nowDateTIme );
			loginHistDomain.setInout( Consts.LOGIN_INOUT.IN );
			loginHistDomain.setUser_sno( userSno );
			loginHistDomain.setLogin_ip( remoteAddress );
			loginHistDomain.setLogin_client_type( Consts.LOGIN_CLIENT_TYPE.WEB );

			logger.debug( "▶▷▶▷remoteAddress : " + remoteAddress );
			logger.debug( "▶▷▶▷nowDateTIme : " + nowDateTIme );
			logger.debug( " userSno : " + userSno );
			logger.debug( " password : " + password );

			// 5. 로그인 실패 카운트 +1
			loginMapper.updateLoginFailCount( userSno ); // 접속하면 Count 1 업데이트한다.

			LoginDomain searchUserInfo = loginMapper.searchUserInfo( userSno );

			logger.debug( "▶▷▶▷searchUserInfo : " + searchUserInfo );
			logger.debug( " retryCount : " + searchUserInfo.getRetryCount() );
			logger.debug( " lockTime : " + searchUserInfo.getLockTime() );
			logger.debug( " lockType : " + searchUserInfo.getLockType() );

			password = EncryptUtil.getEncryptPasswd( password );
			logger.debug( "password : " + password );

			// login check
			LoginDomain loginUser = loginMapper.searchLoginUserInfo( userSno , password );

			if ( loginUser != null ) { // 로그인 성공

				logger.debug(
						"userSno, lockType : " + loginUser.getUserSno() + "\t" + loginUser.getLastLoginDate() + "\t" + loginUser.getLockType() + "\t" + loginUser.getAbsentLock() + "\t" + loginUser.getAbsentLockDay() );

				logger.debug( "userSno : " + userSno );
				logger.debug( "remoteAddress : " + remoteAddress );

				// 로그인 시간 저장(비밀번호 변경주기를 위한...)
				// loginMapper.updateLastLoginDate(userSno, dateNow, timeNow);
				// SO_USER의 LAST_LOGIN_DATE = NOW(), LOGIN_COUNT = LOGIN_COUNT+1
				int lldResult = loginMapper.updateLastLoginDate( userSno , remoteAddress );
				logger.debug( "lldResult : " + lldResult );

				int zlfcResult = loginMapper.updateZeroLoginFailCount( userSno ); // LoginFailCount 0 으로 업데이트한다.
				logger.debug( "zlfcResult : " + zlfcResult );

				// session create
				HttpSession	session	= request.getSession( true );
				Locale		locale	= localeResolver.resolveLocale( request );

				// 로그인 이력처리
				loginHistDomain.setLogin_result( Consts.LOGIN_RSLT.SUCCESS );
				loginHistDomain.setDescription( Consts.LOGIN_DESCRIPTION.SUCCESS );
				// 로그인에 성공하면 sessionid를 입력
				loginHistDomain.setSession_id( session.getId() );
				loginHistMapper.insertLoginHistory( loginHistDomain );

				// 관리자가 등록한 패스워드일 경우 알림
				if ( loginUser.getDefaultPasswdYn().equals( Consts.DEFAULT_PASSWD_YN.YES ) ) {

					return Consts.LOGIN_RESULT.NOTI_DEFAULT_PASSWD;
				}
				// 관리자가 비밀번호 초기화한 경우
				else if ( loginUser.getInitPasswdYn().equals( Consts.DEFAULT_PASSWD_YN.YES ) ) {

					return Consts.LOGIN_RESULT.NOTI_DEFAULT_PASSWD;
				}

				logger.info( "---------------------- SessionUser Info start --------------------------------" );
				logger.info( "userSno : " + loginUser.getUserSno() );
				logger.info( "partnerSno : " + loginUser.getPartnerSno() );
				logger.info( "partnerClcd : " + loginUser.getPartnerClcd() );
				logger.info( "remoteAddress : " + remoteAddress );
				logger.info( "userLevel : " + loginUser.getLevelName() );
				// logger.info("userLoginDate : " + dateNow +" "+ timeNow );
				logger.info( "userLoginDate : " + nowDateTIme );
				logger.info( "language1 : " + request.getLocale().getLanguage() );
				logger.info( "language2 : " + locale.getLanguage() );
				logger.info( "country : " + request.getLocale().getCountry() );
				logger.info( "zoneOffset : " + LocaleUtil.getZoneOffset( locale , databaseZoneOffset ) );

				PrevSessionUser sessionUser = new PrevSessionUser();
				sessionUser.setUserSno( loginUser.getUserSno() );
				sessionUser.setPartnerSno( loginUser.getPartnerSno() );
				sessionUser.setPartnerClcd( loginUser.getPartnerClcd() );
				sessionUser.setUserLevelId( loginUser.getLevelId() );
				sessionUser.setUserLevel( loginUser.getLevelName() );
				sessionUser.setUserIpAddress( remoteAddress );
				// sessionUser.setUserLoginDate( dateNow +" "+ timeNow );
				sessionUser.setUserLoginDate( nowDateTIme );
				sessionUser.setLanguage( locale.getLanguage() );
				sessionUser.setCountry( locale.getCountry() );
				sessionUser.setZoneOffset( LocaleUtil.getZoneOffset( locale , databaseZoneOffset ) );
				sessionUser.setUserFnm( loginUser.getUserFnm() );
				sessionUser.setLoginId( loginUser.getLoginId() );

				// Map<String, Object> map = commonMapper.findLocalePattern(locale.getLanguage());
				// if (map != null) {
				// sessionUser.setPatternDate((String) map.get("PATTERN_DATE"));
				// sessionUser.setPatternTime((String) map.get("PATTERN_TIME").);
				// sessionUser.setPatternMonth((String) map.get("PATTERN_MONTH"));
				// }
				//
				// Map<String, Object> mapLanguage = commonMapper.findLocaleLanguage(locale.getLanguage());
				// if (mapLanguage != null) {
				// sessionUser.setLanguage_clcd((String) mapLanguage.get("COM_CD"));
				// logger.info("sessionUser.getLanguage_clcd : " + sessionUser.getLanguage_clcd());
				// }

				logger.info( "---------------------- SessionUser Info end ----------------------------------" );

				session.removeAttribute( Consts.USER.SESSION_USER );
				session.setAttribute( Consts.USER.SESSION_USER , sessionUser );
				session.setAttribute( "userSno" , loginUser.getUserSno() );
				session.setAttribute( "loginDate" , loginUser.getLastLoginDate() );
				session.setAttribute( "loginTime" , loginUser.getLastLoginTime() );

				// FIXME 실행되는지 확인해야 됨.
				// session user 업데이트 또는 인서트
				if ( loginMapper.countLoginSessionUser( userSno , remoteAddress , session.getId() ) > 0 ) {
					updateLoginSessionUser( userSno , session.getId() , remoteAddress , Consts.ACCOUNT_STATUS.YES );
				} else {
					insertLoginSessionUser( userSno , session.getId() , remoteAddress , Consts.ACCOUNT_STATUS.YES );
				}

				return Consts.LOGIN_RESULT.SUCCESS;

			}
			// 패스워드 오류 로그인 실패
			else {

				logger.debug( "▶▷▶▷login failed" );

				// 로그인 이력처리
				// loginHistory.setLoginStatus("F");
				loginHistDomain.setLogin_result( Consts.LOGIN_RSLT.FAILURE );
				loginHistDomain.setDescription( Consts.LOGIN_DESCRIPTION.INVALID_PASSWD );
				loginHistDomain.setFail_count( searchUserInfo.getRetryCount() );

				logger.debug( "▶▷▶▷LoginHistory : " + loginHistDomain.toString() );
				loginHistMapper.insertLoginHistory( loginHistDomain );

				return Consts.LOGIN_RESULT.FAIL_PASSWORD;
			}
		}
		// 계정이 없음
		else {
			logger.info( "▶▷▶▷user id not found" );
			return Consts.LOGIN_RESULT.FAIL_ACCOUNT;
		}
	}

	/**
	 * 중복 접속 유저인지 확인 여부
	 *
	 * @param userSno
	 * @param remoteAddress
	 * @return
	 */
	private boolean isDuplicatedSessionLogin( String userSno ) {

		LoginDomain lsu = loginMapper.searchLoginSessionUser( userSno );

		if ( lsu.getLoginCount() < lsu.getLoginType() ) {
			return false;
		}

		return true;
	}

	/**
	 * 등록된 아이피가 접속아이피랑 체크 로직 허용가능 IP대역이면 true 리턴
	 *
	 * @param sessionUser
	 * @param remoteAddress
	 * @return
	 */
	private String isPassIP_Bandwidth( String remoteAddress ) {

		// 허용 IP 리스트
		List< IpBandwidth >		ipList			= loginMapper.listIpBandwidth( Consts.IP_BANDWIDTH.ALLOW );

		IpBandwidth				ib				= null;
		Iterator< IpBandwidth >	itor			= ipList.iterator();
		String					ipBandwidth		= "";

		String					tempIpBandWidth	= "";
		int						tempAstCount	= 5;

		while ( itor.hasNext() ) {

			logger.debug( "remoteAddress : " + remoteAddress );
			logger.debug( "( ipBandwidth.indexOf(Consts.IP_DELIM)==-1 )  : " + (ipBandwidth.indexOf( Consts.IP_DELIM ) == -1) );

			ib = (IpBandwidth) itor.next();
			ipBandwidth = ib.getIp();

			if ( ipBandwidth.indexOf( Consts.IP_DELIM ) == -1 ) {
				// 등록된 IP대역이 full ip이면(ex. 127.0.0.1)
				// 4-1. 사용자의 client IP가 허용 대역인지 확인
				if ( ipBandwidth.equals( remoteAddress ) && (ib.getMaxSimult() > ib.getSessionCnt()) )
					return ipBandwidth;
			} else {
				// 등록된 IP대역이 *를 포함하고 있으면...
				boolean		bMatch		= true;
				String[]	arr			= ipBandwidth.split( "\\." );
				String[]	remoteArr	= remoteAddress.split( "\\." );
				int			nAstCount	= 0;
				int			index		= 0;
				for ( String ip : arr ) {
					if ( ip.equals( "*" ) ) {
						nAstCount++;
					} else {
						if ( !ip.equals( remoteArr[ index ] ) ) {
							bMatch = false;
							break;
						}
					}
					if ( !bMatch ) {
						break;
					}
					index++;
				}
				if ( bMatch ) {
					// if ( nAstCount < tempAstCount && ib.getMaxSimult() > ib.getSessionCnt() ) {
					tempIpBandWidth = ipBandwidth;
					tempAstCount = nAstCount;
					// }
				}
			}
		}
		return tempIpBandWidth;
	}

	/**
	 * 세션 유저 상태값 입력
	 *
	 * @param userSno
	 * @param sessionId
	 * @param remoteAddress
	 * @param status
	 */
	private void insertLoginSessionUser( String userSno , String sessionId , String remoteAddress , String status ) {

		LoginDomain loginSessionUser = new LoginDomain();

		loginSessionUser.setUserSno( userSno );
		loginSessionUser.setSessionId( sessionId );
		loginSessionUser.setStatus( status );
		loginSessionUser.setGatewayIp( remoteAddress );

		loginMapper.insertLoginSessionUser( loginSessionUser );
	}

	/**
	 * 세션 유저 상태값 업데이트
	 *
	 * @param userSno
	 * @param sessionId
	 * @param remoteAddress
	 * @param status
	 */
	private void updateLoginSessionUser( String userSno , String sessionId , String remoteAddress , String status ) {
		LoginDomain loginSessionUser = new LoginDomain();
		loginSessionUser.setUserSno( userSno );
		loginSessionUser.setSessionId( sessionId );
		loginSessionUser.setStatus( status );
		loginSessionUser.setGatewayIp( remoteAddress );

		loginMapper.updateLoginSessionUser( loginSessionUser );
	}

	/**
	 * 계정 만료 남은 일수 조회
	 *
	 * @param userSno
	 * @return
	 * @throws PfnmException
	 */
	public int searchAccountDueDate( String userSno ) {
		return loginMapper.searchAccountDueDate( userSno );
	}

	/**
	 * 패스워드 만료 남은 일수 조회
	 *
	 * @param userSno
	 * @return
	 * @throws PfnmException
	 */
	public int searchPasswordDueDate( String userSno ) {
		return loginMapper.searchPasswordDueDate( userSno );
	}

	/**
	 * 비밀번호 오류 허용 한계
	 *
	 * @param userSno
	 * @return
	 * @throws PfnmException
	 */
	public int searchLoginFailLimit( String userSno ) {
		return loginMapper.searchLoginFailLimit( userSno );
	}

	/**
	 * 비밀번호 오류 횟수
	 *
	 * @param userSno
	 * @return
	 * @throws PfnmException
	 */
	public int searchLoginFailCount( String userSno ) {
		return loginMapper.searchLoginFailCount( userSno );
	}

	public String searchLoginFailCheckYN( String userSno ) {
		return loginMapper.searchLoginFailCheckYN( userSno );
	}

	/**
	 * 로그아웃
	 *
	 * @param request
	 * @return
	 * @throws PfnmException
	 */
	public int logoutAction( HttpServletRequest request ) throws DMException {

		// String resultUrl = "index";
		HttpSession session = request.getSession( false );
		if ( session == null )
			return 0;

		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		logger.debug( "▶▷▶▷sessionUser  : " + sessionUser );

		LoginDomain loginSessionUser = new LoginDomain();

		loginSessionUser.setUserSno( sessionUser.getUserSno() );
		loginSessionUser.setGatewayIp( request.getRemoteAddr() );
		loginSessionUser.setStatus( "N" );
		loginSessionUser.setSessionId( session.getId() );

		logger.debug( "▶▷▶▷loginSessionUser  : " + loginSessionUser );

		// 세션 유저 상태값 업데이트
		int lsuResult = loginMapper.updateLoginSessionUser( loginSessionUser );

		/*
		 * private void updateLoginSessionUser( String userSno, String sessionId, String
		 * remoteAddress, String status) {
		 */
		logger.debug( "lsuResult : " + lsuResult );

		LoginHistDomain loginHistDomain = new LoginHistDomain();

		logger.debug( "▶▷▶▷userSno  : " + sessionUser.getUserSno() );
		logger.debug( "▶▷▶▷loginDate : " + sessionUser.getUserLoginDate() );

		loginHistDomain.setUser_sno( sessionUser.getUserSno() );
		loginHistDomain.setLogin_client_type( Consts.LOGIN_CLIENT_TYPE.WEB );
		loginHistDomain.setLogout_result( Consts.LOGOUT_RESULT.NORMAL ); // 정상적인 로그아웃
		loginHistDomain.setLogin_date( sessionUser.getUserLoginDate() );
		loginHistDomain.setInout( Consts.LOGIN_INOUT.OUT );

		// 로그아웃 이력처리
		int lhResult = loginHistMapper.updateLoginHistory( loginHistDomain );
		logger.debug( "lhResult : " + lhResult );

		// session remove
		if ( sessionUser != null )
			session.invalidate();

		return 0;
	}

	/**
	 * 접속 메뉴 권한 조회
	 *
	 * @param url
	 * @param user_group_id
	 * @return
	 * @throws PfnmException
	 */
	public boolean authMenu( String userSno , String password ) throws DMException {

		LoginDomain loginUser = loginMapper.searchLoginUserInfo( userSno , Sha256Util.getEncrypt( password ) );

		if ( loginUser == null ) {
			return false;
		} else {

			logger.debug( "searchLoginUserInfo userSno : " + loginUser.getUserSno() );
			logger.debug( "searchLoginUserInfo userFnm : " + loginUser.getUserFnm() );
			logger.debug( "searchLoginUserInfo levelId : " + loginUser.getLevelId() );
			logger.debug( "searchLoginUserInfo retruCount : " + loginUser.getRetryCount() );
			logger.debug( "searchLoginUserInfo lastLoginDate : " + loginUser.getLastLoginDate() );

			return true;
		}
	}

	public String isValidUser( String userSno , String sessionId ) {
		return loginMapper.isValidUser( userSno , sessionId );
	}

	public String checkPasswordAction( String userSno , String password ) {
		LoginDomain loginUser = loginMapper.searchLoginUserInfo( userSno , Sha256Util.getEncrypt( password ) );
		if ( loginUser != null ) {
			return "succ";
		}
		return "Your user password doesn't match";
	}

	public List< LoginDomain > listRegistedUser( String loginId ) {
		return loginMapper.listRegistedUser( loginId );
	}

	public int resetPassword( LoginDomain user ) {

		int cnt = loginMapper.updatePassword( user.getUserSno() , user.getPasswd() , user.getPasswdLifeCycle() , Consts.DEFAULT_PASSWD_YN.YES );
		return cnt;
	}
}
