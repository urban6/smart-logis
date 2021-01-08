package kr.co.shovvel.hcf.tag;

import java.io.IOException;

import javax.servlet.jsp.tagext.TagSupport;

import kr.co.shovvel.hcf.utils.MessageUtil;

public class pagingTag2 extends TagSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1794041546244821417L;

	//ajax 여부
	private boolean is_ajax=false;

	//ajax 사용일 경우 javascript 
	private String ajax_method="goPostPage";
	//ajax 사용일 경우 요청 url
	private String ajax_url;
	//ajax 사용일 경우 결과를 받을 div 아이디 지정
	private String ajax_target;
	
	//페이지 클릭 시 이동 경로
	private String href;
	
	//현재 페이지
	private int active=1;
	
	
	//키 리스트
	private String parameterKeys;
	//밸루 리스트
	private String parameterValues;
	
	//한 페이지 안에 몇 줄을 보여줄 것인지 기술
	private int per_page=Integer.parseInt(MessageUtil.getMessage("paging.per_page"));
	//한 화면에 몇 개의 페이지이동 버튼을 보여줄 것인지 기술
	private int per_size=Integer.parseInt(MessageUtil.getMessage("paging.per_size"));
	//전체 갯수
	private int total_count;
	
	//첫 페이지 이동 레이블
	private String paging_first = MessageUtil.getMessage("paging.move.paging_first.label");
	//이전 10 페이지 레이블
	private String paging_pre = MessageUtil.getMessage("paging.move.paging_pre.label");
	//다음 10 페이지 레이블
	private String paging_next = MessageUtil.getMessage("paging.move.paging_next.label");
	//마지막 페이지 이동 레이블
	private String paging_end = MessageUtil.getMessage("paging.move.paging_end.label");
	
    public int doStartTag()  {

    	String result = "";

		int yardStick = (int) Math.ceil(((double)active / (double)per_size));
		int start = ((yardStick-1) * per_size)+1;
		int end = ((yardStick) * per_size);
		int lastPage = (int) Math.ceil(((double)total_count / (double)per_page));
		
		if(is_ajax==false){
			result = makeUrl(start,end,lastPage);
		}else{
			result = makeAjax(start,end,lastPage);
		}
		try {
			pageContext.getOut().print(result);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
        return SKIP_BODY;
   
		
    }

    private String makeAjax(int start, int end, int lastPage ){
    	/*System.err.println("makeAjax");
    	System.err.println(start);
    	System.err.println(end);
    	System.err.println(lastPage);*/
    	
    	if(ajax_target==null || ajax_target.isEmpty())return "";
    	if ((active > lastPage) || (start < 1)) return "";
    	
    	String result ="<ul class=\"btnsArea btn_web\">";
		if(start>1){
			result+="<li><a href=\"javascript:"+ajax_method+"('"+ajax_target+"','"+ajax_url+"',1,"+per_page+","+per_size+","+parameterKeys+");\" class=\"btn btn_first\" title='"+paging_first+"'><em>"+paging_first+"</em></a></li>";
			result+="<li><a href=\"javascript:"+ajax_method+"('"+ajax_target+"','"+ajax_url+"',"+(start-1)+","+per_page+","+per_size+","+parameterKeys+");\" class=\"btn btn_prev\" title='"+paging_pre+"'><em>"+paging_pre+"</em></a></li>";
		}
		
		for(int i=start;i<=end;i++){
			if( i <=lastPage){
				if(i==active){
					result+=(" <li><a href=\"#\" class=\"num on\">"+i+"</a></li> ");
				}else{
					result+=(" <li><a href=\"javascript:"+ajax_method+"('"+ajax_target+"','"+ajax_url+"',"+i+","+per_page+","+per_size+","+parameterKeys+");\" class=\"num\">"+i+"</a></li> ");
				}
			}
		}
		if(end<lastPage){
			result+="<li><a href=\"javascript:"+ajax_method+"('"+ajax_target+"','"+ajax_url+"',"+(end+1)+","+per_page+","+per_size+","+parameterKeys+");\" class=\"btn btn_next\" title='"+paging_next+"'><em> "+paging_next+"</em></a></li>";
			result+="<li><a href=\"javascript:"+ajax_method+"('"+ajax_target+"','"+ajax_url+"',"+lastPage+","+per_page+","+per_size+","+parameterKeys+");\" class=\"btn btn_last\" title='"+paging_end+"'><em> "+paging_end+"</em></a></li>";
		}
		result +="</ul>";
		
		return result;
    }
    
    private String makeUrl(int start, int end, int lastPage ){
    	/*System.err.println("makeUrl");
    	System.err.println(start);
    	System.err.println(end);
    	System.err.println(lastPage);*/
    	
    	if ((active > lastPage) || (start < 1)) return "";
    	
    	String result ="<ul class=\"btnsArea btn_web\">";


		String extraParameter = "";

		if(parameterKeys!=null){
			String[] splitParameterKeys=parameterKeys.split(",");
			String[] splitParameterValues=parameterValues.split(",");
			for(int i=0;i<splitParameterKeys.length;i++){
				if(splitParameterValues[i]!=null && splitParameterValues[i]!=null){
					String tempKey=splitParameterKeys[i]+"";
					String tempValue=splitParameterValues[i]+"";
					extraParameter+=("&"+tempKey+"="+tempValue);
				}
			}
			if("&=".equals(extraParameter))extraParameter="";
		}
		
		if(href.contains("?")){
			href = href +"&";
		}else{
			href = href +"?";
		}
		
		if(start>1){
			result+="<li><a href=\""+href+"page="+1+"&perPage="+per_page+"&perSize="+per_size+extraParameter+"\" class=\"btn btn_first\"><em>"+paging_first+"</em></a></li>";
			result+="<li><a href=\""+href+"page="+(start-1)+"&perPage="+per_page+"&perSize="+per_size+extraParameter+"\" class=\"btn btn_prev\"><em>"+paging_pre+"</em></a></li>";
		}
		
		for(int i=start;i<=end;i++){
			if( i <=lastPage){
				if(i==active){
					result+=(" <li><a href=\"#\" class=\"num on\">"+i+"</a></li> ");
				}else{
					result+=(" <li><a href=\""+href+"page="+i+"&perPage="+per_page+"&perSize="+per_size+extraParameter+"\" class=\"num\">"+i+"</a></li> ");
				}
			}
		}

		if(end<lastPage){
			result+="<li><a href=\""+href+"page="+(end+1)+"&perPage="+per_page+"&perSize="+per_size+extraParameter+"\" class=\"btn btn_next\"><em>"+paging_next+"</em></a></li>";
			result+="<li><a href=\""+href+"page="+lastPage+"&perPage="+per_page+"&perSize="+per_size+extraParameter+"\" class=\"btn btn_last\"><em>"+paging_end+"</em></a></li>";
		}
		
		result +="</ul>";
		return result;
    }
    
    
	public boolean isIs_ajax() {
		return is_ajax;
	}
	public void setIs_ajax(boolean is_ajax) {
		this.is_ajax = is_ajax;
	}
	public String getAjax_method() {
		return ajax_method;
	}
	public void setAjax_method(String ajax_method) {
		this.ajax_method = ajax_method;
	}
	public String getAjax_url() {
		return ajax_url;
	}
	public void setAjax_url(String ajax_url) {
		this.ajax_url = ajax_url;
	}
	public String getAjax_target() {
		return ajax_target;
	}
	public void setAjax_target(String ajax_target) {
		this.ajax_target = ajax_target;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
	}
	public int getPer_page() {
		return per_page;
	}
	public void setPer_page(int per_page) {
		this.per_page = per_page;
	}
	public int getPer_size() {
		return per_size;
	}
	public void setPer_size(int per_size) {
		this.per_size = per_size;
	}
	public int getTotal_count() {
		return total_count;
	}
	public void setTotal_count(int total_count) {
		this.total_count = total_count;
	}

	public String getParameterKeys() {
		return parameterKeys;
	}

	public void setParameterKeys(String parameterKeys) {
		this.parameterKeys = parameterKeys;
	}

	public String getParameterValues() {
		return parameterValues;
	}

	public void setParameterValues(String parameterValues) {
		this.parameterValues = parameterValues;
	}

}
