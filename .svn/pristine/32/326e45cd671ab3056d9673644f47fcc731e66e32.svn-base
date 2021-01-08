package kr.co.shovvel.hcf.utils;

import java.io.File;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class ConfigurationUtil {

	private static final Logger logger = Logger.getLogger(ConfigurationUtil.class);
	private static final DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	private DocumentBuilder builder;
	private Document document;

	public ConfigurationUtil() {
//		try {
//			StringBuilder sb = new StringBuilder();
//			sb.append(System.getProperty("catalina.home"));
//			sb.append(File.separator + "configuration" + File.separator + "configuration-properties.xml");
//
//			factory.setValidating(false);
//			factory.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
//
//			builder = factory.newDocumentBuilder();
//			document = builder.parse(new File(sb.toString()));
//
//			document.getDocumentElement().normalize();
//		} catch (ParserConfigurationException e) {
//			e.printStackTrace();
//		} catch (SAXException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
	}


	public String getDeveloperId() {
		String strResult = null;
		try {
			NodeList nList = document.getElementsByTagName("entry");
			for (int i = 0; i < nList.getLength(); i++) {
				Node node = nList.item(i);
				Element element = (Element) node;
				if( element.getAttribute("key").equals("developerId") ) {
					strResult = element.getTextContent();
					break;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return strResult;
	}

	public int getLoginSessionTimeout() {
		String strResult = "";
		int nResult = 0;
		try {
//			NodeList nList = document.getElementsByTagName("entry");
//			for (int i = 0; i < nList.getLength(); i++) {
//				Node node = nList.item(i);
//				Element element = (Element) node;
//				if( element.getAttribute("key").equals("login.session.timeout") ) {
//					strResult = element.getTextContent();
//					break;
//				}
//			}

//			if(strResult != null) {
//				nResult = Integer.parseInt(strResult);
//			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return nResult;
	}

	public String entryParse(String key) {
		try {
			NodeList nList = document.getElementsByTagName("entry");
			for (int i = 0; i < nList.getLength(); i++) {
				Node node = nList.item(i);
				Element element = (Element) node;
				if( element.getAttribute("key").equals(key) ) {
					return element.getTextContent();
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
}
