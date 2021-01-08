package kr.co.shovvel.dm.util;

import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import kr.co.shovvel.dm.domain.management.operation.menu.MenuVO;
import lombok.extern.log4j.Log4j;

@Log4j
public class CommonUtil {
	
	/**
	 * 메뉴 트리 구조 변환
	 *
	 * @param parentId
	 *                                  : 상위 메뉴 (0 : 최상위)
	 * @param listAuthorizationMenu
	 *                                  : 권한에 맞는 메뉴 목록
	 * @return
	 */
	public static List< MenuVO > getOrganizedMenu( String parentId , List< MenuVO > listAuthorizationMenu ) {
		List< MenuVO > result = new ArrayList< MenuVO >();

		for ( MenuVO menu : listAuthorizationMenu ) {
			if ( StringUtil.null2void( menu.getUpMenuId() ).equals( parentId ) ) {
				menu.setChildren( getOrganizedMenu( menu.getMenuId().toString() , listAuthorizationMenu ) );
				result.add( menu );
			}
		}

		return result;
	}

	/**
	 *
	 * @param url
	 * @param params
	 * @return
	 * @throws IOException
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 */
	public static NodeList HttpPostXml( String url , List< NameValuePair > params ) throws IOException , ParserConfigurationException , SAXException {
		String					mainUrl			= "http://hisweb.snuh.org/webservice/MS/GN/CtiWebService";
		HttpClient				httpClient		= HttpClientBuilder.create().build();
		HttpPost				httpPost		= new HttpPost( mainUrl + url );
		NodeList				nList			= null;

		UrlEncodedFormEntity	urlFormEntity	= new UrlEncodedFormEntity( params , "UTF-8" );
		httpPost.setEntity( urlFormEntity );

		HttpResponse	httpresponse	= httpClient.execute( httpPost );
		HttpEntity		respEntity		= httpresponse.getEntity();

		if ( respEntity != null ) {
			String content = EntityUtils.toString( respEntity );
			//log.debug( url + "\n\t***** HttpPostXml *****\t" + content );
			InputSource				is				= new InputSource( new StringReader( content ) );
			DocumentBuilderFactory	factory			= DocumentBuilderFactory.newInstance();
			DocumentBuilder			documentBuilder	= factory.newDocumentBuilder();
			Document				doc				= documentBuilder.parse( is );
			nList = doc.getElementsByTagName( "Table" );
		}


	return nList;	
	}
	
	/**
	 *
	 * @param url
	 * @param params
	 * @return 
	 * @throws IOException
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 */
	public static NodeList HttpPostXml_new(String	mainUrl,  String url , List< NameValuePair > params ) {
		

		// String					mainUrl			= "http://hisdevweb.snuh.org/webservice/MS/GN/CtiWebService";
		HttpClient				httpClient		= HttpClientBuilder.create().build();
		HttpPost				httpPost		= new HttpPost( mainUrl + url );
		NodeList				nList			= null;

		UrlEncodedFormEntity urlFormEntity;
		try {
			urlFormEntity = new UrlEncodedFormEntity( params , "UTF-8" );
			
			httpPost.setEntity( urlFormEntity );

			HttpResponse httpresponse;
			try {
				httpresponse = httpClient.execute( httpPost );
				
				HttpEntity		respEntity		= httpresponse.getEntity();

				if ( respEntity != null ) {
					
					String content = EntityUtils.toString( respEntity );
					//log.debug( url + "\n\t***** HttpPostXml_new *****\t" + content );
					InputSource				is				= new InputSource( new StringReader( content ) );
					DocumentBuilderFactory	factory			= DocumentBuilderFactory.newInstance();
					DocumentBuilder documentBuilder;
					try {
						documentBuilder = factory.newDocumentBuilder();
						
						Document doc;
						try {
							doc = documentBuilder.parse( is );
							
							nList = doc.getElementsByTagName( "Table" );
							return nList;
							
						} catch (SAXException e) {
							//log.error( url + "\n\t***** HttpPostXml_new *****\t" + e.getMessage() );
							return nList;
						}
					} catch (ParserConfigurationException e) {
						//log.error( url + "\n\t***** HttpPostXml_new *****\t" + e.getMessage() );
						return nList;
					}
				}
				
			} catch (IOException e) {
				//log.error( url + "\n\t***** HttpPostXml_new *****\t" + e.getMessage() );
				return nList;
			}
		} catch (UnsupportedEncodingException e) {
			//log.error( url + "\n\t***** HttpPostXml_new *****\t" + e.getMessage() );
			return nList;
		}
		return nList;
	}

	/**
	 *
	 * @param url
	 * @param params
	 * @return
	 * @throws IOException
	 * @throws ClientProtocolException
	 */
	public static boolean HttpPostUpdate(String	mainUrl,  String url , List< NameValuePair > params ) {
		// String		mainUrl		= "http://hisdevweb.snuh.org/webservice/MS/GN/CtiWebService";
		boolean		result		= false;
		HttpClient	httpClient	= HttpClientBuilder.create().build();
		HttpPost	httpPost	= new HttpPost( mainUrl + url );

		try {
			httpPost.setEntity( new UrlEncodedFormEntity( params , "UTF-8" ) );
			
			HttpResponse httpresponse;
			try {
				httpresponse = httpClient.execute( httpPost );
				
				HttpEntity		respEntity		= httpresponse.getEntity();
				int				status			= httpresponse.getStatusLine().getStatusCode();
				if ( status >= 200 && status < 300 ) {
					result = true;
				}

				if ( respEntity != null ) {
					String content = EntityUtils.toString( respEntity );
					//log.debug( url + "\n\t***** HttpPostUpdate *****\t" + content );
				}
				
			} catch (ClientProtocolException e) {
				//log.error( url + "\n\t***** HttpPostUpdate *****\t" + e.getMessage() );
				result = false;
			} catch (IOException e) {
				//log.error( url + "\n\t***** HttpPostUpdate *****\t" + e.getMessage() );
				result = false;
			}
			
			
		} catch (UnsupportedEncodingException e) {
			//log.error( url + "\n\t***** HttpPostUpdate *****\t" + e.getMessage() );
			result = false;
		}
		
		return result;
	}

	/**
	 *
	 * @param url
	 * @return
	 * @throws IOException
	 * @throws ClientProtocolException
	 */
	public static boolean HttpGetSend( URI url ) throws ClientProtocolException , IOException {

		boolean			result			= false;
		HttpClient		httpClient		= HttpClientBuilder.create().build();
		HttpGet			httpGet			= new HttpGet( url );

		HttpResponse	httpresponse	= httpClient.execute( httpGet );
		HttpEntity		respEntity		= httpresponse.getEntity();
		int				status			= httpresponse.getStatusLine().getStatusCode();
		// if ( status >= 200 && status < 300 ) {
		// result = true;
		// }
		// TODO : 임시로 접속만 되면 성공으로 처리
		if ( status >= 200 && status < 500 ) {
			result = true;
		}

		if ( respEntity != null ) {
			String content = EntityUtils.toString( respEntity );
			//log.debug( url + "\n\t***** HttpGetSend *****\t" + content );
		}
		return result;
	}

	@SuppressWarnings( "deprecation" )
	public static boolean HttpPostSendApk( String url , File uploadFile ) {
		boolean result = false;

		try {
			HttpClient		httpclient	= new DefaultHttpClient();
			HttpPost		httppost	= new HttpPost( new URI( url ) );

			FileBody		bin			= new FileBody( uploadFile );
			StringBody		comment		= new StringBody( "Filename: " + uploadFile.getName() );

			MultipartEntity	reqEntity	= new MultipartEntity();
			reqEntity.addPart( "file_name" , bin );
			httppost.setEntity( reqEntity );

			HttpResponse	response	= httpclient.execute( httppost );
			HttpEntity		resEntity	= response.getEntity();

			if ( resEntity != null ) {
				String content = EntityUtils.toString( resEntity );
				//log.debug( url + "\n\t***** HttpPostSendApk *****\t" + content );
			}

			result = true;
		} catch ( IOException | URISyntaxException e ) {
			e.printStackTrace();
		}

		return result;
	}
}
