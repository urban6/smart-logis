package kr.co.shovvel.dm.dao.management.login;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.login.IpBandwidth;
import kr.co.shovvel.dm.domain.management.login.LoginDomain;


@Component
public interface PrevLoginMapper {
	
	/**
	 * 유저 아이디 존재 유무
	 * @return
	 */
	int countUser(String loginId);
	
	/**
     * 접속 유저 수
     * @return
     */
    int countLoginSession();
    
    /**
     * 사용자 계정 잠김 여부 조회
     * @param userSno
     * @return
     */
    String searchAccountLock(String userSno);
    
    /**
     * 
     * @param userSno
     * @return
     */
    String isValidUser(
    		@Param("userSno") String userSno,
    		@Param("sessionId") String sessionId
    );
    
    /**
     * 
     * @param userSno
     * @return
     */
    LoginDomain searchUserInfo(@Param("userSno") String userSno);
    
    /**
     * 사용자 정보 조회
     * @param userSno
     * @param password
     * @return
     */
    LoginDomain searchLoginUserInfo(
    		@Param("userSno") String userSno,
    		@Param("password") String password);
    
    
    /**
     * 로그인 시 login_id에 해당하는 user_sno 조회
     * @param userSno
     * @param password
     * @return
     */
    LoginDomain selectUserSno(
    		@Param("loginId") String loginId);
    /**
     * 중복 접속 유저인지 조회
     * @param userSno
     * @param remoteAddress
     * @return
     */
    LoginDomain searchLoginSessionUser(@Param("userSno") String userSno);
    
    /**
     * 로그인 실패 카운터 업데이트
     * @param userSno
     * @return
     */
    int updateLoginFailCount(String userSno);
    
    /**
     * 비밀번호 변경
     * @param userSno
     * @return
     */
    int updatePassword(
    		@Param("userSno") String userSno, 
    		@Param("passwd") String passwd,
    		@Param("passwdLifeCycle") String passwdLifeCycle,
    		@Param("defaultPasswordYn") String defaultPasswordYn);
    
    /**
     * 로그인 실패 카운터 업데이트
     * @param userSno
     * @return
     */
    int updateLoginFailCountDate(String userSno);
    
    /**
     * User 테이블에 마지막 날짜 업데이트
     * @param userSno
     */
    int updateLastLoginDate(
    		@Param("userSno") String userSno,
    		@Param("remoteAddress") String remoteAddress
    );
    
    /**
     * User 테이블에 LOGIN_FAIL_COUNT 0 으로 업데이트
     * @param sessionUser
     */
    int updateZeroLoginFailCount(@Param("userSno") String userSno);
    
    /**
     * 패스워드 만료 컬럼 널(null)여부 체크
     * @param userSno
     * @return
     */
    int countNullPasswordDate(String userSno);
    
    /**
     * 패스워드 기한 만료 체크
     * @param userSno
     * @return
     */
    int countNotiPasswordDate(String userSno);
    
    /**
     * 계정 만료전 노티 해줌
     * @param userSno
     * @return
     */
    int countNotiAccountDate(String userSno);
    
    /**
     * 계정 만료 컬럼 널(null)여부 체크
     * @param userSno
     * @return
     */
    int countNullAccountDate(String userSno);
    
    /**
     * 계정 기한 만료
     * @param userSno
     * @return
     */
    int countOverAccountDate(String userSno);
    
    /**
     * 로그인 실패 카운터 조회
     * @param userSno
     * @return
     */
    int searchLoginFailCount(String userSno);
    
    /**
     * 로그인 실패 최대 카운터 조회
     * @param userSno
     * @return
     */
    int searchLoginFailLimit(String userSno);
    
    String searchLoginFailCheckYN(String userSno);
    /**
     * 계정 락을 건다
     * @param userSno
     * @return
     */
    int updateAccountLock(
    		@Param("userSno") String userSno, 
    		@Param("status") String status, 
    		@Param("statusReason") String statusReason
    );
    
    
    /**
     * 세션 유저 상태값 조회
     * @param userSno
     * @param remoteAddress
     * @return
     */
    int countLoginSessionUser(@Param("userSno") String userSno
            , @Param("remoteAddress") String remoteAddress
            , @Param("sessionId") String sessionId);
    
    /**
     * 세션 유저 상태값 입력
     * @param loginSessionUser
     * @return
     */
    int insertLoginSessionUser(LoginDomain loginSessionUser);
    
    /**
     * 세션 유저 상태값 업데이트
     * @param loginSessionUser
     * @return
     */
    int updateLoginSessionUser(LoginDomain loginSessionUser);
    
    /**
     * 세션 유저 로그아웃 처리
     * @param loginSessionUser
     * @return
     */
    int destoryLogin(LoginDomain loginSessionUser);
    
    /**
     * 계정 만료 남은 일수 조회
     * @param userSno
     * @return
     */
    int searchAccountDueDate(String userSno);
    
    /**
     * 패스워드 만료 남은 일수 조회
     * @param userSno
     * @return
     */
    int searchPasswordDueDate(String userSno); 
    
    /**
     * 패스워드 오류로 LOCK된 후 LOCK_TIME이 지나면 0, 아직 지나지 않았으면 1
     * @param userSno
     * @return
     */
    String validLockTime(@Param("userSno") String userSno); 
    
	/**
	 * 
	 *   @return List<Map<String,Object>>
	 *   @param userSno
	 *   @return
	 */
	List<Map<String, Object>> findRecent(@Param(value="userSno")String userSno);
    
    /**
     * 중복 접속 유저인지 조회
     * @param userSno
     * @param remoteAddress
     * @return
     */
	List<IpBandwidth> listIpBandwidth(@Param("allowYn") String allowYn);
    
    /**
     * JUnit 테스트를 위한 SO_USER update
	 * 테스트하는 쪽에서 auto rollback 되어야 함.
     * @param userSno
     * @return
     */
    int updateTATUSERForTest(LoginDomain lsu);
    
    /**
     * JUnit 테스트를 위한 SO_USER_LEVEL update
	 * 테스트하는 쪽에서 auto rollback 되어야 함.
     * @param userSno
     * @return
     */
    int updateTATUSERLEVELForTest(LoginDomain lsu);
	
    
    /**
     * 사용자 이름과 휴대폰 번호가 등록된 사용자 정보를 가져온다.
     * @param username
     * @param phonenumber
     * @return
     */
    List<LoginDomain> listRegistedUser(@Param("loginId") String loginId);
    
    /**
     * SMS 인증번호 발송
     * @param msgSendGroupSno
     * @param msgCtcd
     * @param userSno
     * @return
     */
    int sendSmsPartnerAdminCertCode(LoginDomain lsu);
}
