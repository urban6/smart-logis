package kr.co.shovvel.dm.service.management.member;

import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.dao.management.member.MemberMapper;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.management.common.ManagementCommonFileDomain;
import kr.co.shovvel.dm.domain.management.member.MemberDomain;
import kr.co.shovvel.dm.service.management.common.ManagementCommonFileService;
import kr.co.shovvel.dm.service.management.operation.usermanage.UserManageService;

@Service
public class MemberService {
	private Logger						logger	= Logger.getLogger(this.getClass());

	@Autowired
	private UserManageService			userManageService;

	@Autowired
	private ManagementCommonFileService	managementCommonFileService;

	@Autowired
	private MemberMapper				memberMapper;

	public void selectCoachIdCnt( MemberDomain memberDomain , Model model ) {
		int selectCoachIdCnt = memberMapper.selectCoachIdCnt(memberDomain);

		if ( selectCoachIdCnt == 0 ) {
			model.addAttribute("rtnFlag" , true);
			model.addAttribute("rtnMsg" , "사용 가능한 아이디 입니다.");
		} else {
			model.addAttribute("rtnFlag" , false);
			model.addAttribute("rtnMsg" , "중복된 이메일입니다. 다른 이메일을 입력해주세요.");
		}
	}

	public void insertSms( MemberDomain memberDomain , Model model ) {
		Random			randomByTime	= new Random(System.currentTimeMillis());
		StringBuilder	sbResult		= new StringBuilder();
		for ( int i = 0 ; i < 6 ; i++ ) {
			sbResult.append(randomByTime.nextInt(10));
		}

		memberDomain.setReceive_hp_no(memberDomain.getUser_hp_no_1().trim() + memberDomain.getUser_hp_no_2().trim() + memberDomain.getUser_hp_no_3().trim());
		memberDomain.setSms_msg_ctcd("00707010");
		memberDomain.setSms_msg_ctnt("{\"code\":\"" + sbResult.toString() + "\"}");
		memberDomain.setCert_num(sbResult.toString());

		// CODE : F01 : 시스템 오류
		// CODE : F02 : 휴대폰 입력 오류
		// CODE : S00 : 발송성공
		String resultCode = "F01";
		// 생성한 인증번호 DB에 저장
		if ( memberMapper.insertSmsCertNumber(memberDomain) > 0
				// 저장 성공 후 SMS 발송
				&& memberMapper.insertSms(memberDomain) > 0 ) {
			resultCode = "S00";
		}

		model.addAttribute("rtnFlag" , true);
		model.addAttribute("rtnCode" , resultCode);
		model.addAttribute("rtnMsg" , "SMS가 발송되었습니다.");
	}

	public void selectSmsCertInfo( MemberDomain memberDomain , Model model ) {
		model.addAttribute("rtnFlag" , false);

		int rtnNo = memberMapper.selectSmsCertInfo(memberDomain);

		// SMS > 인증번호 확인
		if ( rtnNo > 0 ) {
			// 인증번호 사용완료 처리
			memberMapper.updateSmsCertNumberUseYn(memberDomain);
			model.addAttribute("rtnFlag" , true);
			model.addAttribute("rtnNo" , rtnNo);
		}
	}

	public void insertCoach( HttpServletRequest request , MemberDomain memberDomain , Model model ) throws IllegalStateException , IOException {

		memberDomain.setPartner_sno(0); //
		memberDomain.setLogin_id(memberDomain.getUser_email());
		memberDomain.setLevel_id(3); // 3 : 코치

		memberDomain.setUser_ctcd("00000000"); // 임시 값
		memberDomain.setDefault_passwd_yn("N"); // 최초 접속 암호 설정 (Y : 암호 입력, N : 기존 등록 암호 사용 가능)
		memberDomain.setAccount_exfire("99991231");

//		//passwd life cycle
//		int passwd_life_cycle = userManageService.getPasswdLifeCycle(Integer.toString(memberDomain.getLevel_id()));
//		memberDomain.setPasswd_life_cycle(passwd_life_cycle);

		int							user_sno					= memberMapper.insertCoach(memberDomain);

		// 공통 > 첨부파일 추가 (프로필 사진)
		ManagementCommonFileDomain	managementCommonFileDomain	= new ManagementCommonFileDomain();
		managementCommonFileDomain.setData_cd(memberDomain.getData_cd2());
		managementCommonFileDomain.setData_cd2(memberDomain.getData_cd2());
		managementCommonFileDomain.setData_seq(memberDomain.getUser_sno());
		managementCommonFileDomain.setFile_nm("file_01");
		int fileSeq = managementCommonFileService.insertFileByName(request , managementCommonFileDomain , model);

		if ( fileSeq > 0 ) {
			// 코치회원가입 > 코치 프로필 사진 정보 업데이트
			memberDomain.setImg_file_sno(fileSeq);
			memberMapper.updateImgFileSnoCoach(memberDomain);
		}
	}

	public void selectCoachDetail( HttpServletRequest request , MemberDomain memberDomain , Model model ) {

		PrevSessionUser sessionUser = (PrevSessionUser) request.getSession().getAttribute(Consts.USER.SESSION_USER);
		memberDomain.setUser_sno(Integer.parseInt(sessionUser.getUserSno()));

		// 내정보 > 정보 조회
		MemberDomain selectCoachDetail = memberMapper.selectCoachDetail(memberDomain);
		model.addAttribute("selectCoachDetail" , selectCoachDetail);

		ManagementCommonFileDomain managementCommonFIleDomain = new ManagementCommonFileDomain();
		managementCommonFIleDomain.setData_cd("COACH_PHOTO");
		managementCommonFIleDomain.setData_cd2("COACH_PHOTO");
		managementCommonFIleDomain.setData_seq(memberDomain.getUser_sno());

		// 공통 > 첨부파일 상세 (프로필)
		model.addAttribute("selectFileProfile" , managementCommonFileService.selectFileDetail(managementCommonFIleDomain , model));
	}

	public void selectEqPasswdOrg( MemberDomain memberDomain , Model model ) {
		memberDomain.setPasswd(memberDomain.getPasswd_org());
		// 내정보 > 정보 조회
		MemberDomain selectEqPasswdOrg = memberMapper.selectEqPasswdOrg(memberDomain);
		model.addAttribute("rtnSno" , selectEqPasswdOrg == null ? 0 : selectEqPasswdOrg.getUser_sno());
	}

	public void updateCoach( HttpServletRequest request , MemberDomain memberDomain , Model model ) throws IllegalStateException , IOException {

		// 내정보 > 정보 변경
		memberMapper.updateCoach(memberDomain);

		if ( memberDomain.getHasFile().equals("Y") == false ) {
			return;
		}

		// 공통 > 첨부파일 사용안함 변경
		ManagementCommonFileDomain managementCommonFileDomain = new ManagementCommonFileDomain();
		managementCommonFileDomain.setData_cd(memberDomain.getData_cd2());
		managementCommonFileDomain.setData_cd2(memberDomain.getData_cd2());
		managementCommonFileDomain.setData_seq(memberDomain.getUser_sno());
		managementCommonFileDomain.setFile_nm("file_01");
		managementCommonFileDomain.setData_cd_param(memberDomain.getData_cd2() + "_DEL");
		managementCommonFileDomain.setData_cd2_param(memberDomain.getData_cd2());
		managementCommonFileService.updateUnuseFile(managementCommonFileDomain , model);

		// 공통 > 첨부파일 추가 (프로필 사진)
		int fileSeq = managementCommonFileService.insertFileByName(request , managementCommonFileDomain , model);

		if ( fileSeq > 0 ) {
			// 코치회원가입 > 코치 프로필 사진 정보 업데이트
			memberDomain.setImg_file_sno(fileSeq);
			memberMapper.updateImgFileSnoCoach(memberDomain);
		}
	}

}
