package kr.co.shovvel.dm.service.management.operation.usermanage;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.shovvel.dm.dao.management.login.PrevLoginMapper;
import kr.co.shovvel.dm.dao.management.operation.userlevel.UserLevelMapper;
import kr.co.shovvel.dm.dao.management.operation.usermanage.UserManageMapper;
import kr.co.shovvel.dm.domain.management.login.LoginDomain;
import kr.co.shovvel.dm.domain.management.operation.userlevel.UserLevelDomainVO;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserDeptDomainVO;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserManageDomain;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserManageDomainVO;
import kr.co.shovvel.dm.util.EncryptUtil;
import kr.co.shovvel.dm.util.StringUtil;
import kr.co.shovvel.hcf.utils.PasingUtil;

@Service
public class UserManageService {
	private Logger				logger	= Logger.getLogger( this.getClass() );

	@Autowired
	private PrevLoginMapper loginMapper;

	@Autowired
	private UserManageMapper	userManageMapper;

	@Autowired
	private UserLevelMapper		userLevelMapper;

	public List< UserLevelDomainVO > listUserLevel( String userLevelId ) {
		return userLevelMapper.listUserLevel( userLevelId );

	}

	// public String selectEncryptPasswd( String passwd ) {
	// return userManageMapper.selectEncryptPasswd(passwd);
	// }
	//
	// public String getPasswd( String user_sno ) {
	// return userManageMapper.getPasswd(user_sno);
	// }
	//
	// public int getPasswdLifeCycle( String userLevelId ) {
	// return userManageMapper.getPasswdLifeCycle(userLevelId);
	// }
	//
	// public int duplChkUserSno( String userSno ) {
	// return userManageMapper.duplChkUserSno(userSno);
	// }

	public int count( UserManageDomain userManageDomain ) {
		return userManageMapper.count( userManageDomain );
	}

	public List< UserManageDomainVO > list( UserManageDomain userManageDomain ) {
		List< UserManageDomainVO > list = list( userManageDomain , 0 , 0 );

		return list;
	}

	public List< UserManageDomainVO > list( UserManageDomain userManageDomain , int page , int perPage ) {
		int	start	= ((page - 1) * perPage);
		int	end		= perPage;

		if ( page != 0 && perPage != 0 ) {
			start = PasingUtil.getStartRowNum( userManageDomain.getPage() , userManageDomain.getPerPage() );
			end = PasingUtil.getEndRowNum( userManageDomain.getPage() , userManageDomain.getPerPage() );
		}

		if ( start < 0 )
			start = 0;

		List< UserManageDomainVO > list = userManageMapper.list( userManageDomain , start , end );

		return list;
	}

	public List< UserDeptDomainVO > listDept() {
		List< UserDeptDomainVO > list = userManageMapper.listDept();

		return list;
	}

	public UserManageDomainVO detail( UserManageDomain userManageDomain ) {
		UserManageDomainVO detail = userManageMapper.detail( userManageDomain );

		return detail;
	}

	/**
	 * 사용자 정보 저장
	 *
	 * @param userManageDomain
	 * @return
	 */
	@Transactional
	public String addAction( UserManageDomain userManageDomain ) {
		try {
			// 사용자 기본정보(loginId) 중복 확인
			int dupCnt = userManageMapper.duplChkUserSno( userManageDomain );

			// 중복 아닌 경우만 추가
			if ( dupCnt == 0 ) {

				String brdy = StringUtil.null2void( userManageDomain.getBrdy() );
				brdy = brdy.replace( "-" , "" );
				// 생년월일이 8자리가 아닌 경우 오류 발생
				if ( brdy.length() != 8 || !StringUtil.isNumeric( brdy ) ) {
					return "birthdayError";
				}

				System.out.println( "brdy=" + brdy );

				// 생년월일 (6자리, YYMMDD)
				brdy = brdy.substring( 2 , 8 );
				System.out.println( "brdy=" + brdy );
				// 비밀번호 암호화
				String passwd = EncryptUtil.getEncryptPasswd( brdy );
				
				userManageDomain.setPasswd( passwd );

				// 사용자 기본정보 insert
				userManageMapper.addAction( userManageDomain );

				return "succ";
			} else {
				return "alreadyExists";
			}
		} catch ( Exception ex ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	@Transactional
	public String modifyAction( UserManageDomain userManageDomain ) {
		try {
			// 사용자 기본정보(loginId) 중복 확인
			int dupCnt = userManageMapper.duplChkUserSno( userManageDomain );

			// 변경할 자료의 건수가 1건인 경우만 수정
			if ( dupCnt == 1 ) {
				// 사용자 기본정보 update
				userManageMapper.modifyAction( userManageDomain );

				return "succ";
			} else {
				return "Fail";
			}
		} catch ( Exception ex ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	@Transactional
	public String removeAction( UserManageDomain userManageDomain ) {
		try {
			// 사용자 기본정보(loginId) 중복 확인
			int dupCnt = userManageMapper.duplChkUserSno( userManageDomain );

			// 삭제할 자료의 건수가 1건인 경우만 수정
			if ( dupCnt == 1 ) {
				userManageMapper.removeAction( userManageDomain );

				return "succ";
			} else {
				return "Fail";
			}
		} catch ( Exception ex ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	@Transactional
	public String initPasswdAction( UserManageDomain userManageDomain ) {
		try {
			// 사용자 기본정보(loginId) 중복 확인
			int dupCnt = userManageMapper.duplChkUserSno( userManageDomain );

			// 변경할 자료의 건수가 1건인 경우만 수정
			if ( dupCnt == 1 ) {

				UserManageDomainVO user = userManageMapper.detail( userManageDomain );

				if ( user == null ) {
					return "Null";
				}

				String brdy = StringUtil.null2void( user.getBrdy() );
				brdy = brdy.replace( "-" , "" );

				// 생년월일 (6자리, YYMMDD)
				brdy = brdy.substring( 2 , 8 );
				System.out.println( "brdy=" + brdy );
				// 비밀번호 암호화
				String passwd = EncryptUtil.getEncryptPasswd( brdy );
				userManageDomain.setPasswd( passwd );

				userManageMapper.initPasswdAction( userManageDomain );

				return "succ";
			} else {
				return "비밀번호 초기화에 실패했습니다.";
			}
		} catch ( Exception ex ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	@Transactional
	public String changePasswdAction( UserManageDomain userManageDomain ) {
		try {
			if ( StringUtil.null2void( userManageDomain.getUserSno() ).equals( "" ) ) {

				String loginId = StringUtil.null2void( userManageDomain.getLoginId() );

				if ( loginId.equals( "" ) ) {
					return "로그인 아이디가 없습니다.";
				}

				LoginDomain	userInfo	= loginMapper.selectUserSno( loginId );

				String		userSno		= StringUtil.null2void( userInfo.getUserSno() );

				if ( userSno.equals( "" ) ) {
					return "로그인 정보가 없습니다.";
				}

				userManageDomain.setUserSno( userSno );
			}

			// 사용자 기본정보(loginId) 중복 확인
			int dupCnt = userManageMapper.duplChkUserSno( userManageDomain );

			// 변경할 자료의 건수가 1건인 경우만 수정
			if ( dupCnt == 1 ) {

				UserManageDomainVO user = userManageMapper.detail( userManageDomain );

				if ( user == null ) {
					return "Null";
				}

				String	passwdOld	= userManageDomain.getPasswdOld();
				String	passwd1		= userManageDomain.getPasswd1();
				String	passwd2		= userManageDomain.getPasswd2();

				if ( !passwd1.equals( passwd2 ) ) {
					return "notMatchNew";
				}

				String passwdDb = user.getPasswd();
				passwdOld = EncryptUtil.getEncryptPasswd( passwdOld );

				if ( !passwdOld.equals( passwdDb ) ) {
					return "notMatch";
				}

				// 비밀번호 암호화
				passwd1 = EncryptUtil.getEncryptPasswd( passwd1 );
				userManageDomain.setPasswd( passwd1 );

				userManageMapper.changePasswdAction( userManageDomain );

				return "succ";
			} else {
				return "비밀번호 변경에 실패했습니다.";
			}
		} catch ( Exception ex ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	@Transactional
	public String restoreAction( UserManageDomain userManageDomain ) {
		try {
			// 사용자 기본정보(loginId) 중복 확인
			int dupCnt = userManageMapper.duplChkUserSno( userManageDomain );

			// 변경할 자료의 건수가 1건인 경우만 수정
			if ( dupCnt == 1 ) {
				userManageMapper.restoreAction( userManageDomain );

				return "succ";
			} else {
				return "복구에 실패했습니다.";
			}
		} catch ( Exception ex ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

}
