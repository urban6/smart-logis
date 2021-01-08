package kr.co.shovvel.dm.service.logis.login;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.dao.common.CommonMapper;
import kr.co.shovvel.dm.dao.logis.login.LoginMapper;
import kr.co.shovvel.dm.domain.logis.user.LogisUser;
import kr.co.shovvel.dm.domain.logis.user.SessionLogisUser;
import kr.co.shovvel.dm.domain.logis.user.UserLoginLog;
import kr.co.shovvel.hcf.utils.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class LoginService {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private LoginMapper loginMapper;

    @Autowired
    private CommonMapper commonMapper;

    /**
     * 로그인 아이디를 조회해서 회원 고유번호가 있는지 조회한다.
     */
    public String searchUserUid(String loginId) {
        return loginMapper.searchUserUid(loginId);
    }

    /**
     * 로그인
     */
    public int loginAction(String userUid, String loginId, String passwd, HttpServletRequest request) {

        // 아이디와 비밀번호가 존재하는지 확인
        if (StringUtils.isEmpty(loginId) || StringUtils.isEmpty(passwd)) {
            return Consts.LOGIN_RESULT.FAIL_PARAM;
        }

        // 사용자 아이디가 DB에 저장되어 있는지 조회
        if (loginMapper.countUser(loginId) > 0) {
            LogisUser logisUser = loginMapper.searchUserInfo(loginId, passwd);

            if (logisUser != null) {
                // 현재 날짜 시간
                Date date = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String nowDatetime = formatter.format(date);

                String ip = request.getHeader("X-FORWARDED-FOR");
                if (ip == null) {
                    ip = request.getRemoteAddr();
                }

                // 마지막 로그인 시간, IP 업데이트
                loginMapper.updateLastLogin(ip, logisUser.getUserUid());

                // 로그인 로그 데이터 추가
				/*
				 * UserLoginLog log = ((Object)
				 * UserLoginLog.builder()).userUid(logisUser.getUserUid())
				 * .loginId(logisUser.getLoginId()) .loginIp(logisUser.getLastLoginIp())
				 * .build(); loginMapper.insertLoginLog(log);
				 */

                // 세션 생성
                HttpSession session = request.getSession();

                // 로그인에 성공했을 경우 기사 객체를 만들어서 세션에 추가를 해줘야 한다.
                // 그렇지 않으면 TaxiCustomInterceptor에서 /으로 리다이렉트 된다.
                SessionLogisUser sessionLogisUser = new SessionLogisUser();
                sessionLogisUser.setUserUid(logisUser.getUserUid());
                sessionLogisUser.setUserIpAddress(ip);
                sessionLogisUser.setLastLoginDate(nowDatetime);

                // 세션에 데이터 저장
                // 아래의 내용이 없으면 TaxiCustomInterceptor클래스의 preHandler에서 걸러진다.
                session.removeAttribute(Consts.LOGIS_USER.SESSION_LOGIS_USER);
                session.setAttribute(Consts.LOGIS_USER.SESSION_LOGIS_USER, sessionLogisUser);
                session.setAttribute("userUid", logisUser.getUserUid());

                return Consts.LOGIN_RESULT.SUCCESS;
            } else {
                return Consts.LOGIN_RESULT.FAIL_PARAM;
            }
        } else {
            return Consts.LOGIN_RESULT.FAIL_PARAM;
        }
    }

}
