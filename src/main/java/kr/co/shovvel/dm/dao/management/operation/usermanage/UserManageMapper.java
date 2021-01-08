package kr.co.shovvel.dm.dao.management.operation.usermanage;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.operation.usermanage.UserDeptDomainVO;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserManageDomain;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserManageDomainVO;

@Component
public interface UserManageMapper {

//	String selectEncryptPasswd( @Param( value = "passwd" ) String passwd );

//	String getPasswd( @Param( value = "user_sno" ) String user_sno );

//	int getPasswdLifeCycle( @Param( value = "userLevelId" ) String userLevelId );

	int duplChkUserSno( @Param( value = "condition" ) UserManageDomain userManageDomain );

	int count( @Param( value = "condition" ) UserManageDomain userManageDomain );

	List<UserManageDomainVO> list( @Param( "condition" ) UserManageDomain userManageDomain , @Param( "start" ) int start , @Param( "end" ) int end );

	UserManageDomainVO detail( @Param( value = "condition" ) UserManageDomain userManageDomain );

//	List<UserManageDomain> detailUserGroupList(@Param(value="condition") UserManageDomain userManageDomain);

	// int addAction(@Param(value="condition") UserManageDomain userManageDomain);
	int addAction( UserManageDomain userManageDomain );

	int modifyAction( @Param( value = "condition" ) UserManageDomain userManageDomain );

	int removeAction( @Param( value = "condition" ) UserManageDomain userManageDomain );

	int initPasswdAction( @Param( value = "condition" ) UserManageDomain userManageDomain );

	List<UserDeptDomainVO> listDept();

	int changePasswdAction( @Param( value = "condition" ) UserManageDomain userManageDomain );

	int restoreAction( @Param( value = "condition" ) UserManageDomain userManageDomain );

//	int removeUserGroupList(@Param(value="condition") UserManageDomain userManageDomain);

//	int addUserGroupList(@Param(value="condition") UserManageDomain userManageDomain);

//	List<UserGroupDomain> getGroupList(@Param("userSno")String user_sno);

//	int addTsycoUser(@Param(value="condition")UserManageDomain userManageDomain);

//	int addTsycoUserGroupRole(@Param(value="condition")UserManageDomain userManageDomain);

//	int addTsycoSOAuthInfo(@Param(value="condition")UserManageDomain userManageDomain);

//	int removeTsycoUser(UserManageDomain userManageDomain);

//	int removeTyscoSOAuthInfo(UserManageDomain userManageDomain);

//	int removeTyscoUserGroupRole(UserManageDomain userManageDomain);

//	int modifyTsycoUser(UserManageDomain userManageDomain);

//	List<UserManageDomain> listEmp(@Param("condition") UserManageDomain userManageDomain);
}
