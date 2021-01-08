package kr.co.shovvel.dm.service.sample;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.shovvel.dm.common.DMConstants;
import kr.co.shovvel.dm.dao.sample.SampleMapper;
import kr.co.shovvel.dm.domain.common.Result;
import kr.co.shovvel.dm.domain.sample.SampleDomain;

@Service
public class SampleService {
	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private SampleMapper sampleMapper;

	public int selectSampleCount(SampleDomain sampleDomain) {
		return sampleMapper.selectSampleCount(sampleDomain);
	}
	
	public List<SampleDomain> selectSampleList(SampleDomain sampleDomain, int page, int perPage) {
		int start = ((page - 1) * perPage);
		int end = perPage;
		List<SampleDomain> list = sampleMapper.selectSampleList(sampleDomain, start, end);
		
		return list;
	}
	
	public String checkSampleName(SampleDomain sampleDomain) {
		int nSampleNameCount = sampleMapper.selectSampleNameCount(sampleDomain);  
		if(nSampleNameCount <= 0) {
			return DMConstants.Result.OK;
		} else {
			return DMConstants.Result.FAIL; 
		}
	}
	
	@Transactional
	public Result addAction(SampleDomain sampleDomain) {
		Result result = new Result();
		try {
			
			sampleMapper.insertSample(sampleDomain);
			
			result.setResult(DMConstants.Result.OK);			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			
			result.setResult(DMConstants.Result.FAIL);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	public SampleDomain selectSampleInfo(SampleDomain sampleDomain) {
		sampleDomain  = sampleMapper.selectSampleInfo(sampleDomain);
		
		return sampleDomain;
	}
	
	@Transactional
	public Result modifyAction(SampleDomain sampleDomain) {
		Result result = new Result();
		try {
			
			sampleMapper.updateSample(sampleDomain);
			
			result.setResult(DMConstants.Result.OK);			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			
			result.setResult(DMConstants.Result.FAIL);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	@Transactional
	public Result deleteSampleAction(SampleDomain sampleDomain) {
		Result result = new Result();
		try {
			
			sampleDomain.setUse_yn("N");
			sampleMapper.deleteSample(sampleDomain);
			
			result.setResult(DMConstants.Result.OK);			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			
			result.setResult(DMConstants.Result.FAIL);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	public List<LinkedHashMap<String, String>> selectExcelList(SampleDomain sampleDomain) {
    	
    	List<LinkedHashMap<String, String>> list = sampleMapper.selectExcelList(sampleDomain);
    	
    	return list;
    }
}
