package kr.co.shovvel.dm.dao.management.partnermng.partner;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.partnermng.partner.PartnerDomain;


@Component
public interface PartnerMapper {

	int selectPartnerCount(@Param(value = "condition") PartnerDomain partnerDomain);
	
	List<PartnerDomain> selectPartnerList(@Param(value = "condition") PartnerDomain partnerDomain
			, @Param(value = "start") int start
			, @Param(value = "end") int end);
	
	PartnerDomain selectPartnerInfo(PartnerDomain partnerDomain);
	
	int insertPartner(PartnerDomain partnerDomain);
	
	int updatePartner(PartnerDomain partnerDomain);
	
	int deletePartner(PartnerDomain partnerDomain);
	
	int insertPartnerHist(PartnerDomain partnerDomain);
	
	List<LinkedHashMap<String, String>> selectExcelList(@Param(value = "condition") PartnerDomain partnerDomain);
}
