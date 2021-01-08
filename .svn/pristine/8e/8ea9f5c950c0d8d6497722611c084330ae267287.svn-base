package kr.co.shovvel.dm.controller.management.member;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.shovvel.dm.domain.management.member.MemberDomain;
import kr.co.shovvel.dm.service.management.member.MemberService;

@Controller
@RequestMapping(value = "/management/member")
public class MemberController {
	
	private Logger logger = Logger.getLogger(this.getClass());
    
	@Autowired
	private MemberService memberService;
    
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: selectCoachIdCheck
	 * 2. ClassName : MemberController
	 * 3. Comment   : 코치 회원가입 > 가입 페이지
	 * 4. 작성자    : 
	 * 5. 작성일    : 
	 * </PRE>
	 *   @param request
	 *   @param model
	 *   @return String
	 */
    @RequestMapping(value = "join_coach", method = RequestMethod.POST)
    public String join_coach(HttpServletRequest request, Model model) {
    	
    	return "management/member/join_coach";
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: selectCoachIdCheck
     * 2. ClassName : MemberController
     * 3. Comment   : 코치 회원가입 > 아이디 중복 확인
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param memberDomain
     *   @param model
     */
    @RequestMapping(value="selectCoachIdCheck", method=RequestMethod.POST)
    public void coachIdCheck(
    		MemberDomain memberDomain,
    		Model model) {
    	
    	// 코치 회원가입 > 아이디 중복 확인
    	memberService.selectCoachIdCnt(memberDomain, model);
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: insertSms
     * 2. ClassName : MemberController
     * 3. Comment   : 코치 회원가입 > 인증번호 발송
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param memberDomain
     *   @param model
     */
    @RequestMapping(value="insertSms", method=RequestMethod.POST)
    public void selectSmsCertInfo(
    		MemberDomain memberDomain,
    		Model model) {
    	
    	// 아이디 중복 확인
    	memberService.insertSms(memberDomain, model);
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: selectSmsCertInfo
     * 2. ClassName : MemberController
     * 3. Comment   : 코치 회원가입 > 인증번호 확인
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param memberDomain
     *   @param model
     */
    @RequestMapping(value="selectSmsCertInfo", method=RequestMethod.POST)
    public void sendCertNo(
    		MemberDomain memberDomain,
    		Model model) {
    	
    	// 아이디 중복 확인
    	memberService.selectSmsCertInfo(memberDomain, model);
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: insertCoach
     * 2. ClassName : MemberController
     * 3. Comment   : 코치 회원가입 > 회원 가입
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param memberDomain
     *   @param request
     *   @param model
     *   @return String
     *   @throws Exception 
     */
    @RequestMapping(value="insertCoach", method=RequestMethod.POST)
    public String insertManager(
    		HttpServletRequest request,
    		MemberDomain memberDomain,
    		Model model) throws IllegalStateException, IOException {
    	
    	// 관리자 등록
    	memberService.insertCoach(request, memberDomain, model);
    	
    	return "management/login/login";
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: edit_coach
     * 2. ClassName : MemberController
     * 3. Comment   : 내정보 > 정보 조회
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param memberDomain
     *   @param model
     *   @return String
     */
    @RequestMapping(value="edit_coach")
    public String edit_coach(
    		HttpServletRequest request,
    		MemberDomain memberDomain,
    		Model model) {
    	
    	// 내정보 > 정보 조회
    	memberService.selectCoachDetail(request, memberDomain, model);
    	
    	return "management/member/edit_coach";
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: selectEqPasswdOrg
     * 2. ClassName : MemberController
     * 3. Comment   : 내정보 > 현재 비밀번호 확인
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param memberDomain
     *   @param model
     */
    @RequestMapping(value="selectEqPasswdOrg")
    public void selectEqPasswdOrg(
    		MemberDomain memberDomain,
    		Model model) {
    	
    	// 내정보 > 정보 변경
    	memberService.selectEqPasswdOrg(memberDomain, model);
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: updateCoach
     * 2. ClassName : MemberController
     * 3. Comment   : 내정보 > 정보 변경
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param memberDomain
     *   @param model
     *   @return String
     * @throws IOException 
     * @throws IllegalStateException 
     */
    @RequestMapping(value="updateCoach")
    public String updateCoach(
    		HttpServletRequest request,
    		MemberDomain memberDomain,
    		Model model) throws IllegalStateException, IOException {
    	
    	// 내정보 > 정보 변경
    	memberService.updateCoach(request, memberDomain, model);
    	
    	return "redirect:/management/coaching/coaching";
    }
}
