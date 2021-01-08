package kr.co.shovvel.hcf.web.servlet.view.document;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import kr.co.shovvel.hcf.utils.MessageUtil;


public class HCFAbstractXlsView extends AbstractXlsView {

	@Override
	@SuppressWarnings({ "unchecked", "rawtypes"})
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		List<Map<String, Object>> list = (List<Map<String, Object>>) model.get("list");
		
		List<String> title = new ArrayList<String>();
		if(list.size() > 0) {
			for(String mapKey : list.get(0).keySet()){
				title.add(mapKey);
			}
		}
		
		List<String> dataType = (List<String>) model.get("dataType");
		String filename = (String) model.get("filename");
		String nowDate  = (String) model.get("nowDate");  //현재시간을 DB에서 조회로 변경.

		String uri = request.getRequestURI();
		String tempUriName = uri.replaceAll(".+/([\\w]+)/([\\w]+)/export.+", "$1_$2");
		
		if(StringUtils.isEmpty(filename)) {
			buildExcelSheet(workbook, list, title, tempUriName, dataType);
		} else {
			buildExcelSheet(workbook, list, title, URLDecoder.decode(filename, "UTF-8"), dataType);
		}

		StringBuilder tempFilename = new StringBuilder();

		// add menu name for excel file name
		if(StringUtils.isEmpty(filename)) {
			tempFilename.append(tempUriName).append("_");
		} else {
			tempFilename.append(filename).append("_");
		}

		// add menu sub name for excel file name
		String filesubname = (String) model.get("filesubname");
		if(!StringUtils.isEmpty(filesubname)) { 
			tempFilename.append("(").append(filesubname).append(")").append("_");
		}
		
		tempFilename.append(nowDate).append(".xls");
		
		// filename attach 형태로 변환 앞쪽에 붙임
		tempFilename.insert(0, "attachment; filename=\"");
		tempFilename.append("\"");
		
		response.setHeader("Content-Disposition", tempFilename.toString());
	}

	private void buildExcelSheet(Workbook workbook, List<Map<String, Object>> list, List<String> titleList, String sheetName, List<String> dataTypeList) {
		Sheet sheet = workbook.createSheet(sheetName);

		CellStyle csTitle = workbook.createCellStyle();
		csTitle.setDataFormat(HSSFDataFormat.getBuiltinFormat("text"));
		csTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		csTitle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		csTitle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

		CellStyle csString = workbook.createCellStyle();
		csString.setDataFormat(HSSFDataFormat.getBuiltinFormat("General"));
		//csString.setDataFormat(HSSFDataFormat.getBuiltinFormat("text"));
		csString.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		CellStyle csNumber1 = workbook.createCellStyle();
		csNumber1.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		csNumber1.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		
		CellStyle csNumber2 = workbook.createCellStyle();
		csNumber2.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.00"));
		csNumber2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		
		CellStyle csNumber3 = workbook.createCellStyle();
		csNumber2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		
		CellStyle csNumber4 = workbook.createCellStyle();
		csNumber4.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00%"));
		csNumber4.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		
		int rowNum = 0;

		Row titleRow = sheet.createRow(rowNum++);
		writeTitle(titleRow, csTitle, titleList);

		Row valueRow = null;
		Cell valueCell = null;

		if(list == null || list.size() <= 0) {
			valueRow = sheet.createRow(rowNum++);

			valueCell = valueRow.createCell(0);
	        valueCell.setCellStyle(csString);
	        valueCell.setCellValue(MessageUtil.getMessage("label.empty.list"));
		} else {
			String dataType = null;
			Object value = null;
        	String valueStr = null;
        	String valueNumStr = null;
        	//System.err.println(list.toString());
        	//System.err.println(titleList.toString());
        	
        	String title;
        	
        	for (Map<String, Object> mapRow : list) {
				valueRow = sheet.createRow(rowNum++);
				
				for(int i = 0; i < titleList.size(); i++) {
					valueCell = valueRow.createCell(i);
					
					title = titleList.get(i);
					if (title.indexOf(".") > 0) title = title.replace(".", ""); //title에 콤마(.)있으면 제거하고 만들어야한다.
					//System.err.println("title-->"+title);
					value = mapRow.get(title);
		        	valueStr = String.valueOf(value);
		        	//System.err.println(titleList.get(i)+"/"+valueStr);
		        	
		        	if(valueStr.equals("null")) valueStr = "";

		        	if(dataTypeList == null) {
		        		dataType = "S";
		        	} else {
		        		dataType = dataTypeList.get(i);

		        		if(!dataType.equals("S") && !dataType.equals("N") && !dataType.equals("NN") && !dataType.equals("P") ) dataType = "S";
		        	}

					if(dataType.equals("S")) {
		        		valueCell.setCellStyle(csString);
				        valueCell.setCellValue(valueStr);
					} else {
			        	valueNumStr = valueStr.replace(",", "");
			        	
			        	if (dataType.equals("NN")) {
			        		valueCell.setCellStyle(csNumber3);
					        valueCell.setCellValue(Double.parseDouble(valueNumStr));
			        	}else if(dataType.equals("P")){
			        		valueCell.setCellStyle(csNumber4);
					        valueCell.setCellValue(Double.parseDouble(valueNumStr));
			        	}else {
				        	if(isNumeric(valueNumStr)) {
					        	if(valueNumStr.indexOf(".") < 0) {
							        valueCell.setCellStyle(csNumber1);
					        	} else {
					        		valueCell.setCellStyle(csNumber2);
					        	}
	
						        valueCell.setCellValue(Double.parseDouble(valueNumStr));
				        	} else {
				        		valueCell.setCellStyle(csString);
						        valueCell.setCellValue(valueStr);
				        	}
			        	}
					}
				}
			}	
		}
	}

	// 제목 세팅
	private void writeTitle(Row row, CellStyle cs, List<String> titleList) {
		Cell titleCell = null;

		for(int i = 0; i < titleList.size(); i++) {
			titleCell = row.createCell(i);

			titleCell.setCellStyle(cs);
			titleCell.setCellValue(titleList.get(i));
		}
	}
	
	public static boolean isNumeric(String s) {
		return s.matches("[-+]?\\d*\\.?\\d+");
	}
}
