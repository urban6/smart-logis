package kr.co.shovvel.dm.service.management.partnermng.partneradmin;

import java.util.LinkedHashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.shovvel.dm.common.DMConstants;
import kr.co.shovvel.dm.dao.management.partnermng.partneradmin.PartnerAdminMapper;
import kr.co.shovvel.dm.domain.common.Result;
import kr.co.shovvel.dm.domain.management.partnermng.partneradmin.PartnerAdminDomain;

@Service
public class PartnerAdminService {
	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private PartnerAdminMapper partnerAdminMapper;

	// 파트너 관리자_카운트
	public int selectPartnerAdminCount(PartnerAdminDomain partnerAdminDomain) {
		return partnerAdminMapper.selectPartnerAdminCount(partnerAdminDomain);
	}
	
	// 파트너 관리자_목록
	public List<PartnerAdminDomain> selectPartnerAdminList(PartnerAdminDomain partnerAdminDomain, int page, int perPage) {
		int start = ((page - 1) * perPage);
		int end = perPage;
		List<PartnerAdminDomain> list = partnerAdminMapper.selectPartnerAdminList(partnerAdminDomain, start, end);
		
		return list;
	}

	// 비밀번호 초기화
	@Transactional
	public Result resetPassword(PartnerAdminDomain partnerAdminDomain) {
		Result result = new Result();
		try {
			//비밀번호 초기화
			partnerAdminMapper.resetPartnerAdminPassword(partnerAdminDomain);
			//SMS전송처리
			partnerAdminMapper.sendSmsPartnerAdminPassword(partnerAdminDomain);
			
			result.setResult(DMConstants.Result.OK);			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			
			result.setResult(DMConstants.Result.FAIL);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	// ID중복체크
	public int selectPartnerAdminbyID(PartnerAdminDomain partnerAdminDomain) {
		return partnerAdminMapper.selectPartnerAdminbyID(partnerAdminDomain);
	}
	
	// 관리자 등록
	@Transactional
	public Result addAction(PartnerAdminDomain partnerAdminDomain) {
		Result result = new Result();
		try {
			logger.debug("Insert PartnerAdmin Info:" + partnerAdminDomain.toString());
			partnerAdminMapper.insertPartnerAdmin(partnerAdminDomain);
			
			result.setResult(DMConstants.Result.OK);			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			
			result.setResult(DMConstants.Result.FAIL);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	// 파트너 관리자 상세조회
	public PartnerAdminDomain selectPartnerAdminInfo(PartnerAdminDomain partnerAdminDomain) {
		return partnerAdminMapper.selectPartnerAdminInfo(partnerAdminDomain);
	}
	
	// 수정
	@Transactional
	public Result modifyAction(PartnerAdminDomain partnerAdminDomain) {
		Result result = new Result();
		try {
			partnerAdminMapper.updatePartnerAdmin(partnerAdminDomain);
			
			result.setResult(DMConstants.Result.OK);			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			
			result.setResult(DMConstants.Result.FAIL);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	// 삭제
	@Transactional
	public Result deletePartner(PartnerAdminDomain partnerAdminDomain) {
		Result result = new Result();
		try {
			partnerAdminMapper.deletePartnerAdmin(partnerAdminDomain);
			
			result.setResult(DMConstants.Result.OK);			
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			
			result.setResult(DMConstants.Result.FAIL);
			result.setMessage(e.getMessage());
		}
		return result;
	}
	
	// 엑셀출력
	public List<LinkedHashMap<String, String>> selectExcelList(PartnerAdminDomain partnerAdminDomain) {
    	
    	List<LinkedHashMap<String, String>> list = partnerAdminMapper.selectExcelList(partnerAdminDomain);
    	
    	return list;
    }
}
