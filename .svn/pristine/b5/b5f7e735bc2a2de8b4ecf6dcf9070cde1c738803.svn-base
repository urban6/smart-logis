package kr.co.shovvel.dm.dao.management.common;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.common.ManagementCommonDomain;

@Component
public interface ManagementCommonMapper {
	
	/**
	 * (공통) 카테고리 리스트
	 * @return List<ManagementCommonDomain>
	 */
	List<ManagementCommonDomain> selectProgramCate();
	
	/**
	 * (공통) 보험사 리스트
	 * @return List<ManagementCommonDomain>
	 */
	List<ManagementCommonDomain> selecComInsurerList();
	
	/**
	 * 미션 관리 > (공통) 분류 리스트
	 * @return List<ManagementCommonDomain>
	 */
	List<ManagementCommonDomain> selectMissionClass();

	/**
	 * (공통) 범용 리스트
	 * @return List<ManagementCommonDomain>
	 */
	List<ManagementCommonDomain> selectComCode(@Param(value = "condition") ManagementCommonDomain managementCommonDomain);
	
}
