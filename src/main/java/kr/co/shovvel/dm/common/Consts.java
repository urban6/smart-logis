package kr.co.shovvel.dm.common;

public abstract class Consts {
	
	public static final String URL_MAIN 	= "/management/dashboard/dashboard";
	
	public static final String IP_DELIM 	= ".*";
	public static final String EMPTY_STRING = "";

	public static final class USER {
		public static final String SESSION_USER	= "sessionUser";
	}

	public static final class LOGIS_USER {
		public static final String SESSION_LOGIS_USER	= "sessionLogisUser";
	}
	
	/**
	 * 로그인 프로세스 결과
	 * @author nextman-note
	 */
	public static final class LOGIN_RESULT {
		public static final int SUCCESS 			= 0;	// 로그인 성공
		public static final int FAIL_PASSWORD 		= 1;	// 로그인 실패 (패스워드 실패)
		public static final int FAIL_ACCOUNT 		= 2;	// 로그인 실패 (없는 계정)
		public static final int FAIL_CONFIG 		= 5;	// config.properties 설정 파일 에러
		public static final int FAIL_CERT_CODE		= 7;	// 인증번호 입력오류
		public static final int CERT_TIME_OVER		= 8;	// 인증번호 시간초과
		public static final int FAIL_PARAM 			= 100;	// 필수파라메터(아아디 / 비번) null 에러
		public static final int FAIL_USERCNT_LIMIT 	= 200;	// 총 접속 유저수 제한
		public static final int FAIL_ACCOUNT_LOCK 	= 300;	// 사용자 계정 잠김 여부		
		public static final int FAIL_USER_DUPL 		= 400;	// 중복 접속 유저인지 여부
		public static final int FAIL_IP 			= 500;	// 접속 IP 확인
		public static final int FAIL_ACCOUNT_EXPIRE = 600;	// 계정기한 기한 만료 
		public static final int LONGTIME_NOTLOGIN 	= 650;	// 장기미접속으로 계정 lock 
		public static final int NOTI_ACCOUNT_EXPIRE = 700;	// 계정기한 만료하기전 알림(노티)
		public static final int NOTI_PASSWD_EXPIRE 	= 800;	// 패스워드 기간 만료하기전 알림(노티)
		public static final int NOTI_DEFAULT_PASSWD = 880;	// 기본패스워드 변경 알림(노티)
		public static final int UNKNOWN 			= 900;  // 모름
	}
	
	/**
	 * 로그아웃 프로세스 결과
	 * @author nextman-note
	 */
	public static final class LOGOUT_RESULT {
		public static final String NORMAL 			= "N";	// normal
		public static final String BY_ADMIN 		= "F";	// 관리자가 세션을 강제로 KILL
		public static final String ABNORMAL 		= "A";	// 세션타임아웃(브라우저를 닫는경우 등..) 
	}
	
	/**
	 * 로그인 상태
	 * @author nextman-note
	 *
	 */
	public static final class LOGIN_STATUS {
		public static final String SUCCESS 	= "S";
		public static final String FAIL 	= "F";
	}
	
	/**
	 * 로그인 상태
	 * @author nextman-note
	 * SO_LOGIN_HIST LOGIN_RESULT의 값
	 *
	 */
	public static final class LOGIN_RSLT {
		public static final String SUCCESS 	= "Y";
		public static final String FAILURE 	= "N";
	}
	
	/**
	 * IP 대역 허용 여부
	 * @author nextman-note
	 * SO_LOGIN_HIST LOGIN_RESULT의 값
	 *
	 */
	public static final class IP_BANDWIDTH {
		public static final String ALLOW 	= "Y";
		public static final String DENY 	= "N";
	}
	
	/**
	 * 로그인 타입
	 * @author nextman-note
	 *
	 */
	public static final class LOGIN_CLIENT_TYPE {
		public static final String WEB 		= "0";
		public static final String SERVER 	= "1";
	}
	
	/**
	 * 로그인 타입
	 * @author nextman-note
	 *
	 */
	public static final class LOGIN_INOUT {
		public static final String IN 		= "IN";
		public static final String OUT 		= "OUT";
	}
	
	/**
	 * 로그인 설명
	 * @author nextman-note
	 *
	 */
	public static final class LOGIN_DESCRIPTION {
		public static final String MAX_SESSION 		= "Maximum user session";
		public static final String DUPL_USER 		= "Duplicate user account";
		public static final String FAIL_IPBANDWIDTH = "Failed on as IP Bandwidth";
		public static final String ACCOUNT_EXPIRE 	= "User account has expired";
		public static final String INVALID_PASSWD	= "Invalid password";
		public static final String SUCCESS 			= "Successfully login";
		public static final String BROWSER_CLOSED	= "Browser closed";
		public static final String ACCOUNT_LOCK		= "Account lock";
		public static final String ABSENT_LOCK		= "Exceed absent lock day";
	}
	
	/**
	 * 계정 상태
	 * @author nextman-note
	 * SO_USER.STATUS_REASON
	 */
	public static final class STATUS_REASON {
		public static final String PASSWORD_LIMIT		= "Account expired by password limit";
		public static final String ABSENT_LOCK_DAY		= "Account exceed absent lock day";
		public static final String ACCOUNT_EXPIRE_DATE	= "Account expired by account expire date";
		public static final String SUCCESS				= "";
	}
	
	/**
	 * 로그인한 계정의 유효 여부
	 * @author nextman-note
	 */
	public static final class VALID_USER {
		public static final int VALID 		= 0;	// 계정 정상
		public static final int CHK_LEVEL	= 3;	// 유저레벨이 변경됨
		public static final int INVALID		= 2;	// 세션 끊김
		public static final int NULL 		= 1; 	// 세션 invalidated
	}
	
	/**
	 * 계정 잠김 여부
	 * @author nextman-note
	 * SO_USER.STATUS
	 */
	public static final class ACCOUNT_STATUS {
		public static final String YES 	= "Y";	// 계정 정상
		public static final String LOCK	= "L";	// 계정 잠김
		public static final String NO 	= "N"; 	// 계정 삭제(사용안함)
	}
	
	/**
	 * 기본 패스워드 여부(관리자가 등록한 패스워드)
	 * @author nextman-note
	 * SO_USER.DEFAULT_PASSWD_YN
	 */
	public static final class DEFAULT_PASSWD_YN {
		public static final String YES 	= "Y";	// 관리자가 등록한 패스워드
		public static final String NO 	= "N"; 	// 계정 소유자가 변경한 패스워드
	}
	
	/**
	 * 계정 잠김 타입
	 * @author nextman-note
	 * SO_USER_LEVEL.LOCK_TYPE
	 */
	public static final class ACCOUNT_LOCK_TYPE {
		public static final String MANUAL 	= "M";	// 운영자(관리자)가 잠김 해제
		public static final String TIME		= "T";	// 일정시간이 경과하면 계정 잠김 해제
	}
	
	/**
	 * RSA key size
	 * @author nextman-note
	 *
	 */
	public static final class SECURITY {
		public static final int KEY_SIZE	= 512;
	}
	
	/**
	 * Operation History
	 * @author nextman-note
	 * 1.Display 2.Search  3.Insert  4.Delete  5.Update  6.Save
	 */
	public static final class OPERATION_HISTORY {
		public static final String DISPLAY 			= "1";
		public static final String SEARCH 			= "2";
		public static final String INSERT 			= "3";
		public static final String DELETE 			= "4";
		public static final String UPDATE 			= "5";
		public static final String SAVE 			= "6";
	}
	
	public static final class messageType {
		public static final String sms = "sms";
		public static final String push = "push";
	}
	
	public static final class messageCategory {
		public static final String membershipCertification = "00707010";
		public static final String resetPassword = "00707080";
		public static final String findAdministratorId = "00707120";
		public static final String loginCertCode = "00707050";
	}

	public static final class AUTH {
		public static final String SUCCESS = "000";
		public static final String FAIL = "001";
		public static final String EXPIRED = "002";
	}

	public static final class DRIVING_STATE {
		public static final String WAIT = "0"; // 운행 대기
		public static final String DRIVING = "1"; // 운행중
		public static final String END = "2"; // 운행 종료
		public static final String CANCEL = "3"; // 운행 취소
	}

	public static final class SIGN_UP {
		public static final String SUCCESS = "0";
		public static final String FAIL = "1";
		public static final String DUPLICATED = "2";
		public static final String CERT_FAIL = "3";
	}

	public static final class SESSION_TYPE {
		public static final String PASSENGER = "0";
		public static final String DRIVER = "1";
	}

	public static final class LOGIS_APPLY_RESULT {
		public static final String SUCCESS = "0";
		public static final String FAIL = "1";
	}

	public static final class LOGIS_STATE {
		// public static final int
	}

	public static final class SPACE_PREV_PAY_STATE {
		public static final int SUCCESS = 0;
		public static final int FAIL = -1;
	}

	public static final class LOGIS_PRICE_KEY {
		public static final int BOX = 5;
		public static final int PALETTE = 6;
	}
}
