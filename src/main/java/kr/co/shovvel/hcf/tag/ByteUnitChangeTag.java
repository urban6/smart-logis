package kr.co.shovvel.hcf.tag;

import java.io.IOException;
import java.text.DecimalFormat;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.log4j.Logger;

import kr.co.shovvel.hcf.utils.ByteUtil;
import kr.co.shovvel.hcf.utils.MessageUtil;

public class ByteUnitChangeTag extends BodyTagSupport {

	private static final long serialVersionUID = -5294307446286799494L;
							  
	private Logger logger = Logger.getLogger(this.getClass());
	
	private String bytes;
	private String unit;

	public int doEndTag() throws JspException {
 	
    	final BodyContent bodyContent = getBodyContent();
    	
		try {
			pageContext.getOut().print(ByteUtil.ByteUnitChange(bytes, unit));
			
			/*
			double dBytes = Double.parseDouble(bytes);
			
			if (dBytes <= 0) {
				pageContext.getOut().print("0 " + unit);
		    } else {
			    final String[] units = new String[] {"", "K", "M", "G", "T", "P" };
			    int digitGroups = (int) (Math.log10(dBytes) / Math.log10(1024));
			    String strChangedByte = new DecimalFormat("#,##0.#").format(dBytes / Math.pow(1024, digitGroups)) + " " + units[digitGroups];
		    
			    // DecimalFormat df = new DecimalFormat("0.00000");
			    pageContext.getOut().print(strChangedByte + unit);
		    }
		    */
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
    	
		return SKIP_BODY;
	}

	public String getBytes() {
		return bytes;
	}
	public void setBytes(String bytes) {
		this.bytes = bytes;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	
}
