package kr.co.shovvel.dm.dao.management.partnermng.partneradmin;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.partnermng.partneradmin.PartnerAdminDomain;


@Component
public interface PartnerAdminMapper {
	
	int selectPartnerAdminCount(@Param(value = "condition") PartnerAdminDomain partnerAdminDomain);
	
	List<PartnerAdminDomain> selectPartnerAdminList(@Param(value = "condition") PartnerAdminDomain partnerAdminDomain
			, @Param(value = "start") int start
			, @Param(value = "end") int end);
	
	int resetPartnerAdminPassword(PartnerAdminDomain partnerAdminDomain);
	int sendSmsPartnerAdminPassword(PartnerAdminDomain partnerAdminDomain);
	
	int selectPartnerAdminbyID(PartnerAdminDomain partnerAdminDomain);
	
	int insertPartnerAdmin(PartnerAdminDomain partnerAdminDomain);
	
	PartnerAdminDomain selectPartnerAdminInfo(PartnerAdminDomain partnerAdminDomain);
	
	int updatePartnerAdmin(PartnerAdminDomain partnerAdminDomain);
	
	int deletePartnerAdmin(PartnerAdminDomain partnerAdminDomain);
	
	List<LinkedHashMap<String, String>> selectExcelList(@Param(value = "condition") PartnerAdminDomain partnerAdminDomain);
}
