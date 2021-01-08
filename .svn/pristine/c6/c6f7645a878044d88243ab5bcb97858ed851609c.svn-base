package kr.co.shovvel.dm.controller.management.other;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.common.paging.Paging;
import kr.co.shovvel.dm.domain.management.other.VerAppDomain;
import kr.co.shovvel.dm.domain.management.other.VerAppDomainVO;
import kr.co.shovvel.dm.domain.management.other.VerAppResultDomainVO;
import kr.co.shovvel.dm.domain.management.other.VerAppUpFileDomain;
import kr.co.shovvel.dm.service.management.other.VerAppService;

@Controller
@RequestMapping( value = "/management/other/version" )
public class VersionController {

	private Logger			logger	= Logger.getLogger( this.getClass() );

	@Autowired
	private VerAppService	verAppService;

	private String			thisUrl	= "management/other";

	/**
	 *
	 * <PRE>
	 * 1. MethodName: versionList
	 * 2. ClassName : VersionController
	 * 3. Comment   : 버전 관리
	 * 4. 작성자    :
	 * 5. 작성일    :
	 * </PRE>
	 *
	 * @param verAppDomain
	 * @param request
	 * @param model
	 * @return String
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping( value = "versionList" , method = RequestMethod.POST )
	public String versionList( VerAppDomain verAppDomain , HttpServletRequest request , Model model ) throws IllegalStateException , IOException {

		model.addAttribute( "searchVal" , verAppDomain );

		return thisUrl + "/versionList";
	}

	/**
	 *
	 * <PRE>
	 * 1. MethodName: versionListAction
	 * 2. ClassName : VersionController
	 * 3. Comment   : 버전 관리 목록
	 * 4. 작성자    :
	 * 5. 작성일    :
	 * </PRE>
	 *
	 * @param verAppDomain
	 * @param request
	 * @param model
	 * @return String
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping( value = "versionListAction" , method = RequestMethod.POST )
	public String versionListAction( VerAppDomain verAppDomain , HttpServletRequest request , HttpSession session , Model model ) throws IllegalStateException , IOException {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		verAppDomain.setUserSno( sessionUser.getUserSno() );

		Paging					paging		= new Paging();

		int						totalCount	= verAppService.selectVerAppListCount( verAppDomain );
		List< VerAppDomainVO >	verAppList	= new ArrayList< VerAppDomainVO >();

		if ( totalCount > 0 ) {
			verAppList = verAppService.selectVerAppList( verAppDomain );
		}

		// paging을 위한 DTO를 생성
		paging.setTotalCount( totalCount ); // 결과 갯수를 DTO에 저장
		paging.setLists( verAppList ); // 결과를 DTO에 저장

		model.addAttribute( "searchVal" , verAppDomain );
		model.addAttribute( "verAppList" , paging );

		return thisUrl + "/versionListAction";
	}

	/**
	 *
	 * <PRE>
	 * 1. MethodName: versionDetail
	 * 2. ClassName : VersionController
	 * 3. Comment   : 버전 관리 > 정보 및 수정
	 * 4. 작성자    :
	 * 5. 작성일    :
	 * </PRE>
	 *
	 * @param verAppDomain
	 * @param request
	 * @param model
	 * @return String
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping( value = "versionDetail" , method = RequestMethod.POST )
	public String versionDetail( VerAppDomain verAppDomain , HttpServletRequest request , HttpSession session , Model model ) throws IllegalStateException , IOException {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		verAppDomain.setUserSno( sessionUser.getUserSno() );
		VerAppDomainVO verAppInfo = verAppService.selectVerApp( verAppDomain );

		model.addAttribute( "searchVal" , verAppDomain );
		model.addAttribute( "info" , verAppInfo );
		model.addAttribute( "infoMod" , "M" );

		return thisUrl + "/versionDetail";
	}

	/**
	 *
	 * <PRE>
	 * 1. MethodName: versionAdd
	 * 2. ClassName : VersionController
	 * 3. Comment   : 버전 관리 > 새 버전 등록
	 * 4. 작성자    :
	 * 5. 작성일    :
	 * </PRE>
	 *
	 * @param verAppDomain
	 * @param request
	 * @param model
	 * @return String
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping( value = "versionAdd" , method = RequestMethod.POST )
	public String versionAdd( VerAppDomain verAppDomain , HttpServletRequest request , HttpSession session , Model model ) throws IllegalStateException , IOException {

		model.addAttribute( "searchVal" , verAppDomain );
		model.addAttribute( "info" , null );
		model.addAttribute( "infoMod" , "A" );

		return thisUrl + "/versionDetail";
	}

	/**
	 *
	 * <PRE>
	 * 1. MethodName: versionAddAction
	 * 2. ClassName : VersionController
	 * 3. Comment   : 버전 관리 > 새 버전 등록
	 * 4. 작성자    :
	 * 5. 작성일    :
	 * </PRE>
	 *
	 * @param verAppUpFileDomain
	 * @param request
	 * @param model
	 * @return String
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping( value = "versionAppAddAction" , method = RequestMethod.POST )
	public @ResponseBody VerAppResultDomainVO versionAppAddAction( VerAppUpFileDomain verAppUpFileDomain , MultipartHttpServletRequest mRequest , HttpSession session , Model model )
			throws IllegalStateException , IOException {
		// session
		PrevSessionUser sessionUser	= (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		Iterator< String >	fileNm		= mRequest.getFileNames();
		if ( fileNm.hasNext() ) {
			MultipartFile mFile = mRequest.getFile( fileNm.next() );
			verAppUpFileDomain.setUpFile( mFile );
			verAppUpFileDomain.setVerAppUserSno( sessionUser.getUserSno() );
		}
		VerAppResultDomainVO resultVo = verAppService.addVerApp( verAppUpFileDomain );
		return resultVo;
	}

	/**
	 *
	 * <PRE>
	 * 1. MethodName: versionModifyAction
	 * 2. ClassName : VersionController
	 * 3. Comment   : 버전 관리 > 버전 수정
	 * 4. 작성자    :
	 * 5. 작성일    :
	 * </PRE>
	 *
	 * @param verAppUpFileDomain
	 * @param request
	 * @param model
	 * @return String
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping( value = "versionAppModifyAction" , method = RequestMethod.POST )
	public @ResponseBody VerAppResultDomainVO versionAppModifyAction( VerAppUpFileDomain verAppUpFileDomain , MultipartHttpServletRequest mRequest , HttpSession session , Model model )
			throws IllegalStateException , IOException {
		// session
		PrevSessionUser sessionUser	= (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		Iterator< String >	fileNm		= mRequest.getFileNames();
		if ( fileNm.hasNext() ) {
			MultipartFile mFile = mRequest.getFile( fileNm.next() );
			verAppUpFileDomain.setUpFile( mFile );
			verAppUpFileDomain.setVerAppUserSno( sessionUser.getUserSno() );
		}
		VerAppResultDomainVO resultVo = verAppService.modifyVerApp( verAppUpFileDomain );
		return resultVo;
	}

	/**
	 *
	 * <PRE>
	 * 1. MethodName: versionModifyAction
	 * 2. ClassName : VersionController
	 * 3. Comment   : 버전 관리 > 버전 수정
	 * 4. 작성자    :
	 * 5. 작성일    :
	 * </PRE>
	 *
	 * @param verAppUpFileDomain
	 * @param request
	 * @param model
	 * @return String
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@RequestMapping( value = "versionAppDeleteAction" , method = RequestMethod.POST )
	public @ResponseBody VerAppResultDomainVO versionAppDeleteAction( VerAppUpFileDomain verAppUpFileDomain , HttpSession session , Model model ) throws IllegalStateException , IOException {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
		verAppUpFileDomain.setVerAppUserSno( sessionUser.getUserSno() );

		VerAppResultDomainVO resultVo = verAppService.deleteVerApp( verAppUpFileDomain );
		return resultVo;
	}
}
