package kr.co.shovvel.dm.dao.logis.signUp;

import kr.co.shovvel.dm.domain.logis.user.LogisUser;
import kr.co.shovvel.dm.domain.logis.user.UserCompany;
import org.springframework.stereotype.Component;

@Component
public interface SignUpMapper {

    String searchLoginId(String loginId);

    void insertUser(LogisUser logisUser);

    void insertUserCompany(UserCompany userCompany);

}
