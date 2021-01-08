package kr.co.shovvel.hcf.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.shovvel.hcf.utils.MessageUtil;

public class PerPageControlTag extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6762304057183908836L;

	//private Logger logger = Logger.getLogger(this.getClass());

	private String page;
	private String perPage;
	private Integer totalCount;
	private String excel;
	
	private final static String HEADER 
		= "  	<script type=\"text/javascript\">"
		+ "		$(document).ready(function() {"
		+ "			$(\"#page\").blur(function(){"
		+ "				var maxpage = Math.ceil(@totalCount@ / $(\"#perPage\").val()); "
	 	+ "         	if($(\"#page\").val() == null || $(\"#page\").val() == \"\") { "
//	 	+ "            		alert(\"Please enter a page number.\");"
	 	+ "					$(\"#page\").val(@page@); "	
		+ "         	}"
		+ "				if($(\"#page\").val() > maxpage){ "
		+ "						$(\"#page\").val(maxpage); "
		+ "				} "	
		+ "			});"
		
		+ "			$(\"#selectPerPage\").change(function () {"
		+ "				setPerPage($(this).val());"
		+ "			});"
		
		+ "		});"
	    + "       function _fnIsNumeric(loc) { "
	    + "         if(loc.value != \"\" && !$.isNumeric(loc.value)) { "
		+ "            alert(\"Please enter only numbers.\");"
		+ "            loc.value = \"1\";"
		+ "            loc.focus();"
		+ "         }"
		+ "       } "
		+ "		  function _fnpressed(e, loc,totalCount)"
		+ "		  { "		
		+ "   		if(e.keyCode == 13) "
		+ "  		{"
	    + "         	if(loc.value == \"\" || !$.isNumeric(loc.value)) { "
//		+ "            alert(\"Please enter a page number.\");"
		+ "					$(\"#page\").val(@page@); "	
		+ "         	}"
		+ "				else { "
		+ "					var maxpage = Math.ceil(totalCount / $(\"#perPage\").val()); "
		+ "					if($(\"#page\").val() > maxpage){ "
		+ "						$(\"#page\").val(maxpage); "
		+ "					} "
		+ "					goSearch();"
		+ "				}"
		+ "   		} "
		+ "		  }"
	 	+ "       function _fnIsNull(totalCount) { "
	 	+ "         if($(\"#page\").val() == null || $(\"#page\").val() == \"\") { "
		+ "					$(\"#page\").val(@page@); "	
		+ "         }"
		+ "			else { "
		+ "					var maxpage = Math.ceil(totalCount / $(\"#perPage\").val()); "
		+ "					if($(\"#page\").val() > maxpage){ "
		+ "						$(\"#page\").val(maxpage); "
		+ "					} "		
		+ "				goSearch();"
		+ "			}"	
		+ "       } "
		+ "     </script>"
		
		+ "     <div class=\"result type_01\">"
		+ "     <div class=\"left_cont\">"
		+ "         <strong>Total List : </strong><span><em>@totalCount@</em> rows</span>"
		+ "     </div>"
		+ "			<input type=\"hidden\" id=\"perPage\" name=\"perPage\" value=\"@perPage@\"/>"
		+ "			<input type=\"hidden\" id=\"page\" name=\"page\" value=\"@page@\"/>"
		
		+ "     <div class=\"right_cont\">"
		+ "       <div class=\"select type_02\">"
		
		+ "         <select id=\"selectPerPage\">";
	    

	private final static String FOOTER 	
     =  "				</select>"	
		+ "       </div>"
		+ "       <div class=\"line\">"
		+ "         <button class=\"btn icon\" type=\"button\" title=\"Download\" id=\"btn_download\" onclick=\"fnExcel();\">"
		+ "           <i class=\"down\"></i><span>Download</span>"
		+ "         </button>"
		+ "       </div>"
		+ "     </div>"
		+ "     </div>";
	
	private final static String nonExcelFOOTER
	=  "				</select>"	
			+ "       </div>"
			+ "     </div>"
			+ "     </div>";
	
	public int doEndTag() throws JspException {
		
		//<spring:message code="label.common.perpage.text" />
		
		
		try {
			String line=MessageUtil.getMessage("label.common.perpage.text");
			String body = "";
			body = HEADER;
			body = body.replaceAll("@page@",page );
			body = body.replaceAll("@perPage@",perPage );
			body = body.replaceAll("@totalPage@",String.valueOf(new java.text.DecimalFormat("#,###").format(Math.ceil((double)totalCount / Double.parseDouble(perPage)))));
			body = body.replaceAll("@totalCount@",String.valueOf((totalCount < 0) ? 0: new java.text.DecimalFormat("#,###").format(totalCount)  ));
			body = body.replaceAll("@line@",line );
			
	    	BodyContent bodyContent = getBodyContent();
	    	String listString="";
	    	if(bodyContent!=null){
	    		String[] list = bodyContent.getString().split(",");
	    		for(int i=0;i<list.length;i++){
	    			if(list[i].trim().equals(perPage)){listString+=" <option value=\""+list[i].trim()+"\"Selected >"+list[i].trim()+" Line</option>";}
	    			else{ listString+="					<option value=\""+list[i].trim()+"\">"+list[i].trim()+" Line</option>";}
	    		}
	    	}
	    	body+=listString;
	    	
	    	if(excel == "Y")
	    		body+=FOOTER;
	    	else
	    		body+=nonExcelFOOTER;
			
//			logger.debug("PerPageControlTag ======>"+body);
			pageContext.getOut().print(body);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return SKIP_BODY;
	}

	
	public String getExcel() {
		return excel;
	}
	public void setExcel(String excel) {
		this.excel = excel;
	}

	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getPerPage() {
		return perPage;
	}
	public void setPerPage(String perPage) {
		this.perPage = perPage;
	}

	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
}
