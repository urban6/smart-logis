package kr.co.shovvel.dm.dao.management.manager;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.manager.ManagerDomain;


@Component
public interface ManagerMapper {
	
	/**
	 * 관리자 관리 > 리스트(갯수)
	 * @return int
	 */
	int selectManagerListCnt(@Param(value = "condition") ManagerDomain managerDomain);

	/**
	 * 관리자 관리 > 리스트
	 * @return List<ManagerDomain>
	 */
	List<ManagerDomain> selectManagerList(@Param(value = "condition") ManagerDomain managerDomain);
	
	/**
	 * 관리자 관리 > 리스트(갯수)
	 * @return int
	 */
	int selectMngIdCnt(@Param(value = "condition") ManagerDomain managerDomain);

	/**
	 * 관리자 관리 > 관리자 등록
	 * @return int
	 */
	int insertManager(@Param(value = "condition") ManagerDomain managerDomain);
	
	/**
	 * 관리자 관리 > 관리자 상세
	 * @return ManagerDomain
	 */
	ManagerDomain selectManagerDetail(@Param(value = "condition") ManagerDomain managerDomain);
	
	/**
	 * 관리자 관리 > 사용여부 변경
	 * @return int
	 */
	int updateUsedYn(@Param(value = "condition") ManagerDomain managerDomain);
	
	/**
	 * 관리자 관리 > 수정하기
	 * @return int
	 */
	int updateManager(@Param(value = "condition") ManagerDomain managerDomain);
	
}
