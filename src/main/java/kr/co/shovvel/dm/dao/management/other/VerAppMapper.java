package kr.co.shovvel.dm.dao.management.other;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.other.VerAppDomain;
import kr.co.shovvel.dm.domain.management.other.VerAppDomainVO;
import kr.co.shovvel.dm.domain.management.other.VerAppUpFileDomain;

@Component
public interface VerAppMapper {

	/**
	 * 기타 관리 > 버전 관리 목록
	 *
	 * @return List<VerAppDomainVO>
	 */
	List< VerAppDomainVO > selectVerAppList( @Param( value = "condition" ) VerAppDomain condition );

	/**
	 * 기타 관리 > 버전 관리 목록 건수
	 *
	 * @return int
	 */
	int selectCountVerAppList( @Param( value = "condition" ) VerAppDomain condition );

	/**
	 * 기타 관리 > 버전 관리
	 *
	 * @return VerAppDomainVO
	 */
	VerAppDomainVO selectVerApp( @Param( value = "condition" ) VerAppDomain condition );

	/**
	 * 기타 관리 > 버전 관리 > 버전 식별번호 가져오기
	 *
	 * @return
	 */
	int selectVerAppNum( @Param( value = "condition" ) VerAppUpFileDomain condition );

	/**
	 * 기타 관리 > 버전 관리 > 버전 추가
	 *
	 * @return
	 */
	int insertVerApp( @Param( value = "condition" ) VerAppUpFileDomain condition );

	/**
	 * 기타 관리 > 버전 관리 > 버전 수정
	 *
	 * @return
	 */
	int updateVerApp( @Param( value = "condition" ) VerAppUpFileDomain condition );

	/**
	 * 기타 관리 > 버전 관리 > 버전 수정 (파일 정보)
	 *
	 * @return
	 */
	int updateVerAppFile( @Param( value = "condition" ) VerAppUpFileDomain condition );

	/**
	 * 기타 관리 > 버전 관리 > 버전 수정 (전체 정보)
	 *
	 * @return
	 */
	int updateVerAppInfo( @Param( value = "condition" ) VerAppUpFileDomain condition );

	/**
	 * 기타 관리 > 버전 관리 > 버전 삭제
	 *
	 * @return
	 */
	int updateVerAppDelete( @Param( value = "condition" ) VerAppUpFileDomain condition );
}
