package kr.co.shovvel.dm.service.management.partnermng.partner;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.shovvel.dm.common.DMConstants;
import kr.co.shovvel.dm.dao.management.partnermng.partner.PartnerMapper;
import kr.co.shovvel.dm.domain.common.Result;
import kr.co.shovvel.dm.domain.management.partnermng.partner.PartnerDomain;

@Service
public class PartnerService {
	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private PartnerMapper partnerMapper;

	public int selectPartnerCount(PartnerDomain partnerDomain) {
		return partnerMapper.selectPartnerCount(partnerDomain);
	}
	
	public List<PartnerDomain> selectPartnerList(PartnerDomain partnerDomain, int page, int perPage) {
		int start = ((page - 1) * perPage);
		int end = perPage;
		List<PartnerDomain> list = partnerMapper.selectPartnerList(partnerDomain, start, end);
		
		return list;
	}

	public PartnerDomain selectPartnerInfo(PartnerDomain partnerDomain) {
		partnerDomain  = partnerMapper.selectPartnerInfo(partnerDomain);		
		return partnerDomain;
	}
	
	@Transactional
	public Result addAction(PartnerDomain partnerDomain, String partner_type) {
		Result result = new Result();
		try {
			logger.debug("Insert Partner Info:" + partnerDomain.toString());
			partnerMapper.insertPartner(partnerDomain);
			logger.debug("Insert Partner No:" + partnerDomain.getPartner_sno());
			partnerMapper.insertPartnerHist(partnerDomain);
			
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
	public Result modifyAction(PartnerDomain partnerDomain) {
		Result result = new Result();
		try {
			partnerMapper.updatePartner(partnerDomain);
			partnerMapper.insertPartnerHist(partnerDomain);
			
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
	public Result deletePartner(PartnerDomain partnerDomain) {
		Result result = new Result();
		try {
			partnerMapper.deletePartner(partnerDomain);
			partnerMapper.insertPartnerHist(partnerDomain);
			
			result.setResult(DMConstants.Result.OK);			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			
			result.setResult(DMConstants.Result.FAIL);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	public List<LinkedHashMap<String, String>> selectExcelList(PartnerDomain partnerDomain) {
    	
    	List<LinkedHashMap<String, String>> list = partnerMapper.selectExcelList(partnerDomain);
    	
    	return list;
    }
}
