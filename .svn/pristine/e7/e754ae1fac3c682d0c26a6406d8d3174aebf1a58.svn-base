package kr.co.shovvel.hcf.utils;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class pagingUtil {

	/**
	 * 페이징 정보를 제공
	 * @param RowSize : 한 페이지에 표시되는 줄 수
	 * @param PageSize : 페이징 번호에 표시되는 갯수
	 * @param totalCnt : 조회된 데이터 총 갯수
	 * @param thisPage : 현재 페이지 번호
	 * @return
	 */
	public static Map<String, Object> getInfo (int RowSize, int PageSize, int totalCnt, int thisPage){
		Map<String, Object> result = new HashMap<String, Object>();
		int firstPage = 1;		// 처음 페이지
		int lastPage = 1;		// 마지막 페이지
		int prevPage = 1;		// 이전 페이지
		int nextPage = 1;		// 다음 페이지
		int prevStep = 1;		// 이전 단위 페이지
		int nextStep = 1;		// 다음 단위 페이지
		int startPage = 1;		// 반복 시작 페이지
		int endPage = 1;		// 반복 종료 페이지
		int startRow = 1;		// 쿼리에서 사용되는 데이터 로우 시작번호
		int endRow = 1;		// 쿼리에서 사용되는 데이터 로우 종료번호
		
		result.put("thisPage", String.valueOf( 1 ) );
		result.put("firstPage", String.valueOf( firstPage ) );
		result.put("lastPage", String.valueOf( lastPage ) );
		result.put("prevPage", String.valueOf( prevPage ) );
		result.put("nextPage", String.valueOf( nextPage ) );
		result.put("prevStep", String.valueOf( prevStep ) );
		result.put("nextStep", String.valueOf( nextStep ) );
		result.put("startPage", String.valueOf( startPage ) );
		result.put("endPage", String.valueOf( endPage ) );
		result.put("startRow", String.valueOf( startRow ) );
		result.put("endRow", String.valueOf( endRow ) );		

		if ( totalCnt == 0 ) { return result; }		// 데이터가 없는 경우
		if ( thisPage == 0 ) { thisPage = 1; }		// 현재페이지가 없는 경우
		if ( RowSize == 0 ) { RowSize = 10; }		// 데이터 로우 사이즈가 없는 경우
		if ( PageSize == 0 ) { PageSize = 10; }	// 페이징 사이즈가 없는 경우
		
		// 마지막 페이지
		lastPage = (totalCnt + (RowSize - 1)) / RowSize;
		
		// 현재 페이지가 1보다 작거나 마지막 페이지 보다 큰 경우
		if (thisPage < 1){ thisPage = 1; }
		if (thisPage > lastPage) { thisPage = lastPage; }
		
		// 쿼리에서 사용되는 데이터 로우 계산
		endRow = thisPage * RowSize;
		startRow = ((thisPage - 1) * RowSize) + 1;
		
		// 페이징 시작 및 종료 
		startPage = ((thisPage - 1) / PageSize) * PageSize + 1;
		endPage = (startPage + PageSize) - 1;
		if ( endPage > lastPage ){ endPage = lastPage; }
		
		// 이전 페이지
		if ( thisPage > 1 ) {
			prevPage = thisPage - 1;
		} else {
			prevPage = 1;
		}
		
		// 다음 페이지
		if ( thisPage < lastPage ) {			
			nextPage = thisPage + 1;
		} else {
			nextPage = lastPage;
		}		
		
		// 이전 단위 페이지
		if ( thisPage - PageSize < 1 ){
			prevStep = 1;
		} else {
			prevStep = startPage - PageSize;
		}
		
		// 다음 단위 페이지
		if ( thisPage + PageSize > lastPage ){
			nextStep = lastPage;
		} else {
			nextStep = startPage + PageSize;
		}
				
		result.put("thisPage", String.valueOf( thisPage ) );
		result.put("firstPage", String.valueOf( firstPage ) );
		result.put("lastPage", String.valueOf( lastPage ) );
		result.put("prevPage", String.valueOf( prevPage ) );
		result.put("nextPage", String.valueOf( nextPage ) );
		result.put("prevStep", String.valueOf( prevStep ) );
		result.put("nextStep", String.valueOf( nextStep ) );
		result.put("startPage", String.valueOf( startPage ) );
		result.put("endPage", String.valueOf( endPage ) );
		result.put("startRow", String.valueOf( startRow ) );
		result.put("endRow", String.valueOf( endRow ) );
	
		return result;
	}
	
	/**
	 * Request변수에서 tp를 찾아서 현재 페이지 확인
	 * @param request : HttpServletRequest
	 * @return
	 */
	public static String thisPage(HttpServletRequest request){
		String pageNo = "1";
		Enumeration<?> enums = request.getParameterNames();
		while(enums.hasMoreElements()){
			String paramName = (String)enums.nextElement();
			if ( "tp".equals(paramName.toLowerCase())){
				pageNo = request.getParameterValues(paramName)[0];
			}			
		}		
		return pageNo.replaceAll("[^\\d]", "");
	}
}
