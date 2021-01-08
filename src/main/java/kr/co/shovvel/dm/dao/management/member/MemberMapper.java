package kr.co.shovvel.dm.dao.management.member;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.member.MemberDomain;

@Component
public interface MemberMapper {
	
	/**
	 * SMS > 사용자 인증번호 검증 테이블 등록
	 * @return int
	 */
	int selectCoachIdCnt(@Param(value = "condition") MemberDomain MemberDomain);
	
	/**
	 * SMS > 사용자 인증번호 검증 테이블 등록
	 * @return int
	 */
	int insertSmsCertNumber(@Param(value = "condition") MemberDomain MemberDomain);

	/**
	 * SMS > 사용자 인증번호 SMS 전송
	 * @return int
	 */
	int insertSms(@Param(value = "condition") MemberDomain MemberDomain);
	
	/**
	 * SMS > 사용자 인증번호 확인
	 * @return int
	 */
	int selectSmsCertInfo(@Param(value = "condition") MemberDomain MemberDomain);
	
	/**
	 * SMS > 인증번호 확인
	 * @return int
	 */
	int updateSmsCertNumberUseYn(@Param(value = "condition") MemberDomain MemberDomain);
	
	/**
	 * 코치회원가입 > 코치 등록
	 * @return int
	 */
	int insertCoach(@Param(value = "condition") MemberDomain MemberDomain);
	
	/**
	 * 코치회원가입 > 코치 프로필 사진 정보 업데이트
	 * @return int
	 */
	int updateImgFileSnoCoach(@Param(value = "condition") MemberDomain MemberDomain);

	/**
	 * 내정보 > 정보 조회
	 * @return MemberDomain
	 */
	MemberDomain selectCoachDetail(@Param(value = "condition") MemberDomain MemberDomain);

	/**
	 * 내정보 > 현재 비밀번호 확인
	 * @return MemberDomain
	 */
	MemberDomain selectEqPasswdOrg(@Param(value = "condition") MemberDomain MemberDomain);
	
	/**
	 * 내정보 > 정보 변경
	 * @return int
	 */
	int updateCoach(@Param(value = "condition") MemberDomain MemberDomain);
	
}
