package kr.co.shovvel.dm.controller.management.other;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.shovvel.dm.domain.management.other.VerAppFileDownloadDomain;

@Controller
@RequestMapping( value = "/app/version/" )
public class VersionAppFileDownloadController {

	private Logger logger = Logger.getLogger( this.getClass() );

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
	@RequestMapping( value = "{verAppType}/{verAppFileSize}/{verAppNo}/{verAppNum}/apkDownload/{verAppStr}/{verAppFileNm}.{verAppFileNmExt}" )
	public ModelAndView apkDownload( HttpServletResponse response , @PathVariable( "verAppType" ) String verAppType , @PathVariable( "verAppFileSize" ) long verAppFileSize , @PathVariable( "verAppNo" ) int verAppNo ,
			@PathVariable( "verAppNum" ) int verAppNum , @PathVariable( "verAppStr" ) String verAppStr , @PathVariable( "verAppFileNm" ) String verAppFileNm , @PathVariable( "verAppFileNmExt" ) String verAppFileNmExt )
			throws Exception {
		VerAppFileDownloadDomain verAppFileDownload = new VerAppFileDownloadDomain();
		verAppFileDownload.setVerAppFileNm( verAppFileNm + "." + verAppFileNmExt );
		verAppFileDownload.setVerAppFileSize( verAppFileSize );
		verAppFileDownload.setVerAppNo( verAppNo );
		verAppFileDownload.setVerAppNum( verAppNum );
		verAppFileDownload.setVerAppStr( verAppStr );
		verAppFileDownload.setVerAppType( verAppType );

		return new ModelAndView( "downloadApkFile" , "verAppFileDownload" , verAppFileDownload );
	}
}
