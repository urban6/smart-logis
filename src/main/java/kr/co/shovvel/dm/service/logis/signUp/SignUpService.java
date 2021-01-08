package kr.co.shovvel.dm.service.logis.signUp;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.dao.logis.signUp.SignUpMapper;
import kr.co.shovvel.dm.domain.logis.signUp.SignUpInfo;
import kr.co.shovvel.dm.domain.logis.user.LogisUser;
import kr.co.shovvel.dm.domain.logis.user.UserCompany;
import kr.co.shovvel.dm.util.EncryptUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SignUpService {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private SignUpMapper signUpMapper;

    public String searchLoginId(String loginId) {
        return signUpMapper.searchLoginId(loginId);
    }


    /**
     * 회원가입
     */
    public String signUpAction(LogisUser logisUser, UserCompany userCompany) {

        String result;

        // 아이디에 대한 회원가입 여부를 확인한다.
        // 이미 가입되어 있을 경우, UID를 리턴하고
        // 가입되어 있지 않은 경우, null을 리턴한다.
        String userUid = signUpMapper.searchLoginId(logisUser.getLoginId());

        // 회원가입이 가능한 경우
        if (userUid == null) {
            // 회사 정보를 먼저 추가한다.
            signUpMapper.insertUserCompany(userCompany);

            // 회사 고유번호가 제대로 있을 경우, 회원가입을 진행한다.
            if (userCompany.getCompanyUid() != null) {

                // 회사 고유번호 추가하고 회원 데이터 추가
                logisUser.setCompanyUid(userCompany.getCompanyUid());
                signUpMapper.insertUser(logisUser);

                if (logisUser.getUserUid() != null) {
                    result = Consts.SIGN_UP.SUCCESS;
                } else {
                    result = Consts.SIGN_UP.FAIL;
                }
            } else {
                result = Consts.SIGN_UP.FAIL;
            }
        } else {
            // 이미 회원가입 된 경우
            result = Consts.SIGN_UP.DUPLICATED;
        }

        return result;
    }
}
