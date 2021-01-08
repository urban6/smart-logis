package kr.co.shovvel.dm.service.management.other;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;

import kr.co.shovvel.dm.dao.management.other.VerAppMapper;
import kr.co.shovvel.dm.domain.management.other.VerAppDomain;
import kr.co.shovvel.dm.domain.management.other.VerAppDomainVO;
import kr.co.shovvel.dm.domain.management.other.VerAppResultDomainVO;
import kr.co.shovvel.dm.domain.management.other.VerAppUpFileDomain;
import kr.co.shovvel.dm.domain.management.other.VerAppUpFileDomainVO;
import kr.co.shovvel.dm.util.CommonUtil;
import kr.co.shovvel.dm.util.StringUtil;

@Service
public class VerAppService {
	private Logger			logger	= Logger.getLogger( this.getClass() );

	@Autowired
	private VerAppMapper	verAppMapper;

	@Value( "#{configuration['path.directory.upload']}" )
	private String			pathDirectoryUpload;
	
	@Value( "#{configuration['appVer']}" )
	private String		appUrl;

	/**
	 * 시스템 관리 > 버전 관리 > 이력 조회 목록
	 *
	 * @return List<VerAppDomainVO>
	 */
	public List< VerAppDomainVO > selectVerAppList( VerAppDomain condition ) {
		List< VerAppDomainVO > result = verAppMapper.selectVerAppList( condition );
		return result;
	}

	/**
	 * 시스템 관리 > 버전 관리 > 이력 조회 목록 건수
	 *
	 * @return int
	 */
	public int selectVerAppListCount( VerAppDomain condition ) {
		int result = verAppMapper.selectCountVerAppList( condition );
		return result;
	}

	/**
	 * 시스템 관리 > 버전 관리 > 버전 조회
	 *
	 * @return VerAppDomainVO
	 */
	public VerAppDomainVO selectVerApp( VerAppDomain condition ) {
		VerAppDomainVO result = verAppMapper.selectVerApp( condition );
		return result;
	}

	@Transactional
	public VerAppResultDomainVO addVerApp( VerAppUpFileDomain condition ) {
		VerAppResultDomainVO result = new VerAppResultDomainVO();

		try {
			MultipartFile upFile = condition.getUpFile();

			if ( upFile == null || upFile.isEmpty() ) {
				result.setResultCode( "EmptyFile" );
				result.setResultMsg( "파일이 없습니다." );
				return result;
			}

			// 버전 등록
			int insertCnt = verAppMapper.insertVerApp( condition );

			if ( insertCnt != 1 ) {
				throw new Exception( "버전 등록 중 오류가 발생했습니다." );
			}
			
			condition.setDbPath( appUrl );
			
			int						verAppNum	= verAppMapper.selectVerAppNum(condition) - 1;

			String					targetPath	= "/verApp/"+ verAppNum;
			// 파일업로드
			VerAppUpFileDomainVO	upFileVO	= saveFile( upFile , targetPath );

			if ( upFileVO == null ) {
				throw new Exception( "버전 파일 업로드 중 오류가 발생했습니다." );
			}

			// 파일 정보 수정
			condition.setVerAppFileName( upFileVO.getFileName() );
			condition.setVerAppFilePath( replaceFilePathToDbStr( upFileVO.getUploadFilePath() ) );
			condition.setVerAppFileSize( upFileVO.getFileSize() );
			condition.setVerAppNum( verAppNum );
			condition.setVerAppStrOld( condition.getVerAppStr() );

			int updateFileCnt = verAppMapper.updateVerAppFile( condition );

			if ( updateFileCnt != 1 ) {
				throw new Exception( "버전 파일 등록 중 오류가 발생했습니다." );
			}

			result.setResultCode( "success" );
			result.setResultMsg( "버전 추가되었습니다." );
		} catch ( Exception e ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			result.setResultCode( "Error" );
			result.setResultMsg( e.getMessage() );
		}
		return result;
	}

	@Transactional
	public VerAppResultDomainVO modifyVerApp( VerAppUpFileDomain condition ) {
		VerAppResultDomainVO result = new VerAppResultDomainVO();
		try {
			MultipartFile	upFile			= condition.getUpFile();

			VerAppDomain	infoCondition	= new VerAppDomain();
			infoCondition.setVerAppNum( condition.getVerAppNum() );
			infoCondition.setVerAppNo( condition.getVerAppNo() );
			infoCondition.setVerAppStr( condition.getVerAppStrOld() );
			VerAppDomainVO verAppVo = verAppMapper.selectVerApp( infoCondition );

			if ( verAppVo == null ) {
				result.setResultCode( "NoInfo" );
				result.setResultMsg( "정보가 없습니다." );
				return result;
			}

			if ( upFile.isEmpty() ) {

				int updateInfoCnt = verAppMapper.updateVerApp( condition );

				if ( updateInfoCnt != 1 ) {
					throw new Exception( "버전 정보 수정 중 오류가 발생했습니다." );
				}

				result.setResultCode( "success" );
				result.setResultMsg( "저장되었습니다." );
			} else {
				int						verAppNum	= verAppVo.getVerAppNum();
				String					oldFilePath	= verAppVo.getVerAppFilePath();
				String					targetPath	= "/verApp/"+ verAppNum;

				// 파일업로드
				VerAppUpFileDomainVO	upFileVO	= saveFile( upFile , targetPath );

				if ( upFileVO == null ) {
					throw new Exception( "버전 파일 업로드 중 오류가 발생했습니다." );
				}

				// 파일 정보 수정
				condition.setVerAppFileName( upFileVO.getFileName() );
				condition.setVerAppFilePath( replaceFilePathToDbStr( upFileVO.getUploadFilePath() ) );
				condition.setVerAppFileSize( upFileVO.getFileSize() );

				int updateFileCnt = verAppMapper.updateVerAppInfo( condition );

				if ( updateFileCnt != 1 ) {
					throw new Exception( "버전 파일 등록 중 오류가 발생했습니다." );
				}

				// 기존 파일 삭제
				if ( !StringUtil.isNull( oldFilePath ) ) {
					File oldFile = new File( oldFilePath );
					if ( oldFile.exists() ) {
						oldFile.delete();
					}
				}

				result.setResultCode( "success" );
				result.setResultMsg( "저장되었습니다." );
			}
		} catch ( Exception e ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			result.setResultCode( "Error" );
			result.setResultMsg( e.getMessage() );
		}
		return result;
	}

	@Transactional
	public VerAppResultDomainVO deleteVerApp( VerAppUpFileDomain condition ) {
		VerAppResultDomainVO result = new VerAppResultDomainVO();
		try {
			VerAppDomain infoCondition = new VerAppDomain();
			infoCondition.setVerAppNum( condition.getVerAppNum() );
			infoCondition.setVerAppNo( condition.getVerAppNo() );
			infoCondition.setVerAppStr( condition.getVerAppStrOld() );
			VerAppDomainVO verAppVo = verAppMapper.selectVerApp( infoCondition );

			if ( verAppVo == null ) {
				result.setResultCode( "NoInfo" );
				result.setResultMsg( "정보가 없습니다." );
				return result;
			}

			int updateDelCnt = verAppMapper.updateVerAppDelete( condition );

			if ( updateDelCnt != 1 ) {
				throw new Exception( "버전 정보 삭제 중 오류가 발생했습니다." );
			}

			result.setResultCode( "success" );
			result.setResultMsg( "삭제되었습니다." );
		} catch ( Exception e ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			result.setResultCode( "Error" );
			result.setResultMsg( e.getMessage() );
		}
		return result;
	}

	public VerAppUpFileDomainVO saveFile( MultipartFile upFile , String targetDirPath ) throws IllegalStateException , IOException {
		VerAppUpFileDomainVO result = null;

		if ( !upFile.isEmpty() ) {
			String	dirPath	= pathDirectoryUpload + targetDirPath;
			File	file	= new File( dirPath , new Date().getTime() + getRandomStr( 6 ) );
			if ( !file.getParentFile().exists() ) {
				file.getParentFile().mkdirs();
			}
			if ( file.exists() ) {
				file.delete();
			}
			upFile.transferTo( file );

			// API 전송 파일 임시 생성
			File apiFile = new File( dirPath , upFile.getOriginalFilename() );
			if ( apiFile.exists() ) {
				apiFile.delete();
			}
			Files.copy( file.toPath() , apiFile.toPath() );

			// API 서버 업로드
			String	url			= "https://apihealthpilot.snuh.org/certify/appUpload";
			boolean	boolSave	= CommonUtil.HttpPostSendApk( url , apiFile );

			// API 전송 임시 파일 삭제
			apiFile.delete();

			if ( !boolSave ) {
				file.delete();
				throw new IOException( "버전 정보 전송 중 오류가 발생했습니다." );
			}

			result = new VerAppUpFileDomainVO();
			result.setFileName( upFile.getOriginalFilename() );
			result.setFileSize( upFile.getSize() );
			result.setUploadDirPath( dirPath );
			result.setUploadFilePath( file.getPath().replace( pathDirectoryUpload , "" ) );
		}
		return result;
	}

	private String getRandomStr( int len ) {
		String	result	= "";

		int		rInt	= getRandomInt( len );
		result = String.valueOf( rInt );
		return result;
	}

	private int getRandomInt( int len ) {
		int		result	= 0;

		double	random	= Math.random();
		int		tmpInt	= 0;
		int		min		= 1000;
		int		max		= 9999;

		switch ( len ) {
		case 4 :
			min = 1000;
			break;
		case 5 :
			min = 10000;
			break;
		case 6 :
			min = 100000;
			break;
		case 7 :
			min = 1000000;
			break;
		case 8 :
			min = 10000000;
			break;
		default :
			min = 1000;
			break;
		}

		tmpInt = (int) (random * max) + min;
		if ( tmpInt < min ) {
			tmpInt = getRandomInt( len );
		}
		result = tmpInt;

		return result;
	}

	private String replaceFilePathToDbStr( String filePath ) {
		String result = "";
		result = filePath.replace( "\\" , "/" );
		result = result.replace( pathDirectoryUpload , "" );
		return result;
	}
}
