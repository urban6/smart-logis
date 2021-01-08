package kr.co.shovvel.hcf.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.log4j.Logger;

public class AuthTag extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4866359152234315166L;

	private Logger logger = Logger.getLogger(this.getClass());
	
	private String auth;

	public int doEndTag() throws JspException {
 	
    	final BodyContent bodyContent = getBodyContent();
    	
		try {
			if("A".equals(auth)){				
				pageContext.getOut().print(bodyContent.getString());
			}else{
				pageContext.getOut().print("");
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
    	
		return SKIP_BODY;
	}

	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}

}
