package kr.co.shovvel.dm.service.management.other;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.AbstractView;

import kr.co.shovvel.dm.dao.management.other.VerAppMapper;
import kr.co.shovvel.dm.domain.management.other.VerAppDomain;
import kr.co.shovvel.dm.domain.management.other.VerAppDomainVO;
import kr.co.shovvel.dm.domain.management.other.VerAppFileDownloadDomain;
import kr.co.shovvel.dm.domain.management.other.VerAppResultDomainVO;
import kr.co.shovvel.dm.domain.management.other.VerAppUpFileDomain;
import kr.co.shovvel.dm.domain.management.other.VerAppUpFileDomainVO;
import kr.co.shovvel.dm.util.StringUtil;

@Component
public class VerAppFileDownloadService extends AbstractView {
	private Logger			logger	= Logger.getLogger( this.getClass() );

	// @Autowired
	// private VerAppMapper verAppMapper;
	@Autowired
	private VerAppService	verAppService;

	@Value( "#{configuration['path.directory.upload']}" )
	private String			pathDirectoryUpload;

	@Override
	protected void renderMergedOutputModel( Map< String , Object > model , HttpServletRequest request , HttpServletResponse response ) throws Exception {
		VerAppFileDownloadDomain verAppFileDownload = (VerAppFileDownloadDomain) model.get( "verAppFileDownload" );
		// 파라메터 확인
		if ( verAppFileDownload == null ) {
			throw new Exception( "버전 파일 정보가 없습니다." );
		}

		VerAppDomain verAppDomain = new VerAppDomain();
		verAppDomain.setVerAppNum( verAppFileDownload.getVerAppNum() );
		verAppDomain.setVerAppNo( verAppFileDownload.getVerAppNo() );
		verAppDomain.setVerAppType( verAppFileDownload.getVerAppType() );
		verAppDomain.setVerAppStr( verAppFileDownload.getVerAppStr() );

		// 버전 정보
		VerAppDomainVO verAppVo = verAppService.selectVerApp( verAppDomain );
		// 버전 정보 없으면 오류
		if ( verAppVo == null ) {
			throw new Exception( "버전 정보가 없습니다." );
		}

		// 버전 정보 비교 (파일명, 파일 크기 등)
		if ( !verAppFileDownload.getVerAppFileNm().equals( verAppVo.getVerAppFileNm() ) ) {
			throw new Exception( "버전 정보가 다릅니다." );
		}

		// 파일 다운로드
		File downFile = new File( pathDirectoryUpload , verAppVo.getVerAppFilePath() );
		if ( !downFile.exists() ) {
			throw new Exception( "버전 파일이 없습니다." );
		}
		if ( verAppFileDownload.getVerAppFileSize() != downFile.length() || verAppFileDownload.getVerAppFileSize() != verAppVo.getVerAppFileSize() ) {
			throw new Exception( "파일 정보가 다릅니다." );
		}

		setContentType( "application/download; charset=utf-8" );
		response.setContentType( getContentType() );
		response.setContentLength( (int) downFile.length() );

		String	header		= request.getHeader( "User-Agent" );
		boolean	b			= header.indexOf( "MSIE" ) > -1;
		String	fileName	= verAppFileDownload.getVerAppFileNm();

		if ( b ) {
			fileName = URLEncoder.encode( fileName , "utf-8" );
		} else {
			fileName = new String( fileName.getBytes( "utf-8" ) , "iso-8859-1" );
		}

		response.setHeader( "Conent-Disposition" , "attachment); filename=\"" + fileName + "\";" );
		response.setHeader( "Content-Transter-Encoding" , "binary" );

		OutputStream	out	= response.getOutputStream();
		FileInputStream	fis	= null;

		try {
			fis = new FileInputStream( downFile );

			FileCopyUtils.copy( fis , out );
		} catch ( Exception e ) {
			e.printStackTrace();
		} finally {
			if ( fis != null ) {
				try {
					fis.close();
				} catch ( IOException ioe ) {
					ioe.printStackTrace();
				}
			}

			out.flush();
		}
	}

}
