package kr.co.shovvel.dm.dao.sample;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.sample.SampleDomain;


@Component
public interface SampleMapper {

	int selectSampleCount(@Param(value = "condition") SampleDomain sampleDomain);
	
	List<SampleDomain> selectSampleList(@Param(value = "condition") SampleDomain sampleDomain
			, @Param(value = "start") int start
			, @Param(value = "end") int end);
	
	int selectSampleNameCount(SampleDomain sampleDomain);
	
	int insertSample(SampleDomain sampleDomain);
	
	SampleDomain selectSampleInfo(SampleDomain sampleDomain);
	
	int updateSample(SampleDomain sampleDomain);
	
	int deleteSample(SampleDomain sampleDomain);
	
	List<LinkedHashMap<String, String>> selectExcelList(@Param(value = "condition") SampleDomain sampleDomain);
}
