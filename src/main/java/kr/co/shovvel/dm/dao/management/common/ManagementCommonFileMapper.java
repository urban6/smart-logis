package kr.co.shovvel.dm.dao.management.common;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.common.ManagementCommonFileDomain;

@Component
public interface ManagementCommonFileMapper {
	
	/**
	 * 공통 > 첨부파일 리스트 (갯수)
	 * @return int
	 */
	int selectFileListCnt(@Param(value = "condition") ManagementCommonFileDomain ManagementCommonFileDomain);
	
	/**
	 * 공통 > 첨부파일 리스트
	 * @return ManagementCommonFIleDomain
	 */
	List<ManagementCommonFileDomain> selectFileList(@Param(value = "condition") ManagementCommonFileDomain ManagementCommonFileDomain);
	
	/**
	 * 공통 > 첨부파일 상세
	 * @return ManagementCommonFIleDomain
	 */
	ManagementCommonFileDomain selectFileDetail(@Param(value = "condition") ManagementCommonFileDomain ManagementCommonFileDomain);
	
	/**
	 * 공통 > 첨부파일 상세 (복수 첨부 리스트)
	 * @return ManagementCommonFIleDomain
	 */
	List<ManagementCommonFileDomain> selectFileMutiList(@Param(value = "condition") ManagementCommonFileDomain ManagementCommonFileDomain);
	
	/**
	 * 공통 > 첨부파일 삭제대상 (복수 첨부 리스트)
	 * @return ManagementCommonFIleDomain
	 */
	List<ManagementCommonFileDomain> selectDeleteFileMutiList(@Param(value = "condition") ManagementCommonFileDomain ManagementCommonFileDomain);
	
	/**
	 * 공통 > 첨부파일 등록
	 * @return int
	 */
	int insertFile(@Param(value = "condition") ManagementCommonFileDomain ManagementCommonFileDomain);
	
	/**
	 * 공통 > 첨부파일 고유번호 추가
	 * @return int
	 */
	int updateFile(@Param(value = "condition") ManagementCommonFileDomain ManagementCommonFileDomain);
	
	/**
	 * 공통 > 첨부파일 사용안함 변경
	 * @return int
	 */
	int updateUnuseFile(@Param(value = "condition") ManagementCommonFileDomain ManagementCommonFileDomain);
	
	/**
	 * 공통 > 첨부파일 삭제
	 * @return int
	 */
	int deleteFile(@Param(value = "condition") ManagementCommonFileDomain ManagementCommonFileDomain);
	
}
