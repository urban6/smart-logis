package kr.co.shovvel.dm.dao.logis.login;

import kr.co.shovvel.dm.domain.logis.user.LogisUser;
import kr.co.shovvel.dm.domain.logis.user.UserLoginLog;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

@Component
public interface LoginMapper {

    String searchUserUid(@Param(value = "loginId") String loginId);

    int countUser(@Param(value = "loginId") String loginId);

    LogisUser searchUserInfo(@Param(value = "loginId") String loginId, @Param(value = "passwd") String passwd);

    void updateLastLogin(@Param(value = "lastLoginIp") String lastLoginIp, @Param(value = "userUid") String userUid);

    void insertLoginLog(UserLoginLog userLoginLog);
}
