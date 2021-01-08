package kr.co.shovvel.dm.service.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.lang.StringUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpEntityEnclosingRequestBase;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPatch;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.xml.sax.InputSource;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.shovvel.dm.domain.common.ResponseCommon;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

@Service
public class RestfulService {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private Ehcache ehcache;
	
	@Value("#{configuration['default.restful.socket.timeout']}")
	private String defaultRestfulSocketTimeout;
	@Value("#{configuration['default.restful.connect.timeout']}")
	private String defaultRestfulConnectTimeout;
	@Value("#{configuration['default.restful.connection.request.timeout']}")
	private String defaultRestfulConnectionRequestTimeout;
	
	@Value("#{configuration['deploy.restful.socket.timeout']}")
	private String deployRestfulSocketTimeout;
	@Value("#{configuration['deploy.restful.connect.timeout']}")
	private String deployRestfulConnectTimeout;
	@Value("#{configuration['deploy.restful.connection.request.timeout']}")
	private String deployRestfulConnectionRequestTimeout;
	
	/*@Value("#{configuration['restfulRelayServerURL']}")
	private String restfulRelayServerURL;*/
	
	public static String REQUEST_METHOD_PATCH = "PATCH";
	public static String REQUEST_METHOD_POST = "POST";
	public static String REQUEST_METHOD_GET = "GET";
	public static String REQUEST_METHOD_PUT = "PUT";
	public static String REQUEST_METHOD_DELETE = "DELETE";
	
	public boolean isRelay() {
		/*logger.info("======================restfulRelayServerURL="+restfulRelayServerURL);
		if (StringUtils.isNotEmpty(this.restfulRelayServerURL)) {
			return true;
		}*/
		return false;
	}
	
	public String getUrl(String sUrl, String sRequestMethod) {
		String sRet = sUrl;
		if (this.isRelay()) {
			//sRet = this.restfulRelayServerURL + "/restful/relay?url=" + sUrl + "&requestMethod=" + sRequestMethod;
		}
		return sRet;
	}
	
	public String restfulRequest(HttpServletResponse response, String sUrl, String sRequestMethod, JsonObject jsonParam) throws Exception {
		return this.restfulRequest(false, response, sUrl, sRequestMethod, jsonParam, new JsonObject());
	}
	
	public String restfulRequest(boolean bTimeout, HttpServletResponse response, String sUrl, String sRequestMethod, JsonObject jsonParam) throws Exception {
		return this.restfulRequest(bTimeout, response, sUrl, sRequestMethod, jsonParam, new JsonObject());
	}
	
	public String restfulRequest(HttpServletResponse response, String sUrl, String sRequestMethod, String sJsonParam) throws Exception {
		return this.restfulRequest(false, response, sUrl, sRequestMethod, sJsonParam, new JsonObject());
	}
	
	public String restfulRequest(boolean bTimeout, HttpServletResponse response, String sUrl, String sRequestMethod, String sJsonParam) throws Exception {
		return this.restfulRequest(bTimeout, response, sUrl, sRequestMethod, sJsonParam, new JsonObject());
	}
	
	public String restfulRequest(String sUrl, String sRequestMethod, String sJsonParam) throws Exception {
		return this.restfulRequest(false, null, sUrl, sRequestMethod, sJsonParam, new JsonObject());
	}
	
	public String restfulRequest(boolean bTimeout, String sUrl, String sRequestMethod, String sJsonParam) throws Exception {
		return this.restfulRequest(bTimeout, null, sUrl, sRequestMethod, sJsonParam, new JsonObject());
	}
	
	public String restfulRequest(String sUrl, String sRequestMethod, JsonObject jsonHeader) throws Exception {
		return this.restfulRequest(false, null, sUrl, sRequestMethod, "{}", jsonHeader);
	}
	
	public String restfulRequest(boolean bTimeout, String sUrl, String sRequestMethod, JsonObject jsonHeader) throws Exception {
		return this.restfulRequest(bTimeout, null, sUrl, sRequestMethod, "{}", jsonHeader);
	}
	
	public String restfulRequest(HttpServletResponse response, String sUrl, String sRequestMethod, JsonObject jsonParam, JsonObject jsonHeader) throws Exception {
		return this.restfulRequest(false, response, sUrl, sRequestMethod, jsonParam.toString(), jsonHeader);
	}

	// configuration.xml 파일의 restfulRelayServerURL 설정에 따라
	// 개발자 PC에서는 개발서버를 통해 RestApi 호출(개발서버에서 중계)
	// 개발서버에서는 직접 RestApi 호출
	public String restfulRequest(boolean bTimeout, HttpServletResponse response, String sUrl, String sRequestMethod, JsonObject jsonParam, JsonObject jsonHeader) throws Exception {
		return this.restfulRequest(bTimeout, response, sUrl, sRequestMethod, jsonParam.toString(), jsonHeader);
	}
	
	public String restfulRequest(String sUrl, String sRequestMethod, String sJsonParam, JsonObject jsonHeader) throws Exception {
		return this.restfulRequest(false, null, sUrl, sRequestMethod, sJsonParam, jsonHeader);
	}
	
	public String restfulRequest(boolean bTimeout, String sUrl, String sRequestMethod, String sJsonParam, JsonObject jsonHeader) throws Exception {
		return this.restfulRequest(bTimeout, null, sUrl, sRequestMethod, sJsonParam, jsonHeader);
	}
	
	public CloseableHttpClient getClient(boolean bTimeout) {
		// bTimeout = false;
		CloseableHttpClient client;
		if (bTimeout) {
			RequestConfig defaultRequestConfig = RequestConfig.custom()
				    .setSocketTimeout(Integer.parseInt(deployRestfulSocketTimeout))
				    .setConnectTimeout(Integer.parseInt(deployRestfulConnectTimeout))
				    .setConnectionRequestTimeout(Integer.parseInt(deployRestfulConnectionRequestTimeout))
				    .setStaleConnectionCheckEnabled(true)
				    .build();
	    	client = HttpClients.custom().setDefaultRequestConfig(defaultRequestConfig).build();
		} else {			
//	    	client = HttpClients.createDefault();
			RequestConfig defaultRequestConfig = RequestConfig.custom()
				    .setSocketTimeout(Integer.parseInt(defaultRestfulSocketTimeout))
				    .setConnectTimeout(Integer.parseInt(defaultRestfulConnectTimeout))
				    .setConnectionRequestTimeout(Integer.parseInt(defaultRestfulConnectionRequestTimeout))
				    .setStaleConnectionCheckEnabled(true)
				    .build();
			client = HttpClients.custom().setDefaultRequestConfig(defaultRequestConfig).build();
		}
    	return client;
	}
	
	public String restfulRequest(HttpServletResponse response, String sUrl, String sRequestMethod, String sJsonParam, JsonObject jsonHeader) throws Exception {
		return this.restfulRequest(false, response, sUrl, sRequestMethod, sJsonParam, jsonHeader);
	}
	
	public String restfulRequest(boolean bTimeout, HttpServletResponse response, String sUrl, String sRequestMethod, String sJsonParam, JsonObject jsonHeader) throws Exception {
    	CloseableHttpClient client = this.getClient(bTimeout);
    	String sRet = null;
    	ResponseCommon responseCommon = new ResponseCommon();
    	Gson gson = new Gson();
    	try {
			HttpResponse res = this.getRestfulResponse(client, sUrl, sRequestMethod, sJsonParam, jsonHeader);
			String line = "";
	    	StringBuffer sbRet = new StringBuffer();
	    	HttpEntity entity = res.getEntity();
	    	if (entity != null) {
	        	BufferedReader rd = new BufferedReader(new InputStreamReader(entity.getContent(), "UTF-8"));
				while ((line = rd.readLine()) != null) {
					sbRet.append(line);
				}
	    	}
	    	//logger.info("==res.getStatusLine().getStatusCode()=="+res.getStatusLine().getStatusCode());
	    	
	    	if(res.getStatusLine().getStatusCode() == HttpStatus.OK.value()){
	    		JsonParser parser = new JsonParser();
	        	logger.info("====================================");
	        	logger.info(sbRet.toString());
	        	logger.info("====================================");
//	        	JsonObject ret = (JsonObject)parser.parse(sbRet.toString());
	        	
	        	String strRet = sbRet.toString();
	        	if (sbRet != null && sbRet.toString() != null && sbRet.length() > 0) {
	        		if (sbRet.toString().substring(0,1).equals("[")) {
	        			strRet = "{\"result_data\":"+sbRet.toString()+"}";
	        		}
	        	}
	        	if (this.isJsonString(strRet)) {
	            	JsonObject ret = (JsonObject)parser.parse(strRet);
	            	sRet = ret.toString();
	        	} else {
	        		sRet = strRet;
	        	}
	        	
	        	this.updateResponseHeaders(response, res);
	        	
	    	}else{
	    		responseCommon.setResult("FAIL");
	    		responseCommon.setMessage(res.getStatusLine().getStatusCode() + ":"+res.getEntity().toString());
	    		sRet = gson.toJson(responseCommon);
	    	}
			
    	} catch (Exception ex) {
    		ex.printStackTrace();
    		throw ex;
    	} finally {
    		try {
    			client.close();
    		} catch (Exception ex) {
        		ex.printStackTrace();
    		}
    	}
    	return sRet;
	}
	
	public HttpResponse getRestfulResponse(String sUrl, String sRequestMethod, String sJsonParam) throws Exception {
		return this.getRestfulResponse(false, sUrl, sRequestMethod, sJsonParam);
	}
	
	public HttpResponse getRestfulResponse(boolean bTimeout, String sUrl, String sRequestMethod, String sJsonParam) throws Exception {
		CloseableHttpClient client = this.getClient(bTimeout);
		HttpResponse response = null;
		try {
			response = this.getRestfulResponse(client, sUrl, sRequestMethod, sJsonParam, new JsonObject());
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
    		try {
    			client.close();
    		} catch (Exception ex) {
        		ex.printStackTrace();
    		}
    	}
		return response;
	}
	
	public HttpResponse getRestfulResponse(CloseableHttpClient client, String sUrl, String sRequestMethod, String sJsonParam, JsonObject jsonHeader) throws Exception {
    	// respoonse
    	HttpResponse res = null;
    	try {
    		String sDestUrl = this.getUrl(sUrl, sRequestMethod);
    		logger.debug("=========================sDestUrl="+sDestUrl);

	    	// header
	    	Iterator<Entry<String, JsonElement>> entrySet = null;
	    	if (jsonHeader != null) {
				entrySet = jsonHeader.entrySet().iterator();
			}
	    	
    		HttpEntityEnclosingRequestBase eerReq = null;
			HttpRequestBase req = null;
	    	if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_POST)) {
	    		eerReq = new HttpPost(sDestUrl);
    		} else if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_PUT)) {
    			eerReq = new HttpPut(sDestUrl);
    		} else if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_PATCH)) {
    			eerReq = new HttpPatch(sDestUrl);
    		} else {
    			if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_GET)) {
    				req = new HttpGet(sDestUrl);
    			} else if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_DELETE)) {
    				req = new HttpDelete(sDestUrl);
    			}
    		}
	    	if (entrySet != null) {
				while (entrySet.hasNext()) {
					Entry<String, JsonElement> entry = entrySet.next();
					String headerName = entry.getKey();
					if (eerReq != null && eerReq.getFirstHeader(headerName) == null) {
						eerReq.setHeader(headerName, jsonHeader.get(headerName).getAsString());
					}
					if (req != null && req.getFirstHeader(headerName) == null) {
						req.setHeader(headerName, jsonHeader.get(headerName).getAsString());
					}
				}
			}
	    	if (eerReq != null) {
				StringEntity parameters = new StringEntity(sJsonParam, "UTF-8");
				if (this.isJsonString(sJsonParam)) {
			    	parameters.setContentType("application/json; charset=UTF-8");
				}
				eerReq.setEntity(parameters);
    	    	res = client.execute(eerReq);
	    	} else if (req != null) {
	    		res = client.execute(req);
	    	}
    	} catch (Exception ex) {
    		ex.printStackTrace();
    		throw ex;
    	}
    	return res;
	}
	
	public boolean isJsonString(String sJsonParam) {
		if (sJsonParam == null || sJsonParam.equals("")) {
			return false;
		}
		try {
			JsonParser parser = new JsonParser();
			parser.parse(sJsonParam);
			return true;
		} catch (Exception ex) {
			return false;
		}
	}
	
	public boolean isXmlString(String sXmlParam) {
		if (sXmlParam == null || sXmlParam.equals("")) {
			return false;
		}
		try {
			InputSource is = new InputSource(new StringReader(sXmlParam));
			DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
			return true;
		} catch (Exception ex) {
			return false;
		}
	}
	
	public void updateResponseHeaders(HttpServletResponse response, HttpResponse res) {
		if (response == null) {
			return;
		}
		Header[] headers = res.getAllHeaders();
    	for (Header header : headers) {
			response.setHeader(header.getName(), header.getValue());
    	}
	}
	
	/*public String restfulRelayRequest(HttpServletRequest request, HttpServletResponse response, String sUrl, String sRequestMethod) throws Exception {
		String line = "";
    	StringBuffer sbRet = new StringBuffer();
    	String sRet = null;
    	
    	StringBuilder jsonParam = new StringBuilder();
    	BufferedReader bufferedReader = null;
    	try {
        	InputStream inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    jsonParam.append(charBuffer, 0, bytesRead);
                }
            }
    	} catch (Exception ex) {
    		ex.printStackTrace();
    		throw ex;
    	} finally {
    		if (bufferedReader != null) {
    			try {
    				bufferedReader.close();
    			} catch (Exception ex) {
    			}
    		}
    	}
    	
    	CloseableHttpClient client = HttpClients.createDefault();
    	try{
	    	// respoonse
	    	HttpResponse res = null;
	    	
	    	// header
	    	Enumeration<String> headerNames = request.getHeaderNames();
	    	
    		if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_POST)) {
    	    	HttpPost post = new HttpPost(sUrl);
				while (headerNames.hasMoreElements()) {
					String headerName = headerNames.nextElement();
					if (!headerName.equalsIgnoreCase("Content-Length")) {
						// Content-Length 를 setHeader 하면 오류남
						post.setHeader(headerName, request.getHeader(headerName));
					}
				}
		    	StringEntity parameters = new StringEntity(jsonParam.toString());
		    	parameters.setContentType("application/json");
		    	post.setEntity(parameters);
    	    	res = client.execute(post);
    		} else if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_PUT)) {
    	    	HttpPut put = new HttpPut(sUrl);
				while (headerNames.hasMoreElements()) {
					String headerName = headerNames.nextElement();
					if (!headerName.equalsIgnoreCase("Content-Length")) {
						// Content-Length 를 setHeader 하면 오류남
						put.setHeader(headerName, request.getHeader(headerName));
					}
				}
		    	StringEntity parameters = new StringEntity(jsonParam.toString());
		    	parameters.setContentType("application/json");
		    	put.setEntity(parameters);
    	    	res = client.execute(put);
    		} else {
    			HttpRequestBase req = null;
    			if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_GET)) {
    				req = new HttpGet(sUrl);
    			} else if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_DELETE)) {
    				req = new HttpDelete(sUrl);
    			} else if (sRequestMethod.equals(RestfulService.REQUEST_METHOD_PUT)) {
    				req = new HttpPut(sUrl);
    			}
    			while (headerNames.hasMoreElements()) {
					String headerName = headerNames.nextElement();
					if (req.getFirstHeader(headerName) == null) {
						req.setHeader(headerName, request.getHeader(headerName));
					}
				}
    			res = client.execute(req);
    		}
    		
    		HttpEntity entity = res.getEntity();
	    	if (entity != null) {
	        	BufferedReader rd = new BufferedReader(new InputStreamReader(entity.getContent(), "UTF-8"));
				while ((line = rd.readLine()) != null) {
					sbRet.append(line);
				}
	    	}
	    	
	    	if (!sbRet.toString().isEmpty()) {
		    	JsonParser parser = new JsonParser();
		    	logger.debug(sbRet.toString());
		    	JsonObject ret = (JsonObject)parser.parse(sbRet.toString());
		    	sRet = ret.toString();
	    	}
	    	
	    	this.updateResponseHeaders(response, res);
    	} catch (Exception e){
    		e.printStackTrace();
    		throw e;
    	} finally {
    		try {client.close();} catch (Exception ex) {}
    	}
    	return sRet;
	}*/
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getInterworkingSystem(String id) {
		List<Map<String, Object>> interworkingSystemList = null;
		Cache cache = ehcache.getCacheManager().getCache("interworkingSystemCache");
		Element interworkingSystemElement = cache.get("interworkingSystemElement");
		if (interworkingSystemElement != null && interworkingSystemElement.getObjectValue() != null) {
			interworkingSystemList = (List<Map<String, Object>>)interworkingSystemElement.getObjectValue();
		} else {
			interworkingSystemList = new ArrayList<Map<String, Object>>();
			interworkingSystemElement = new Element("interworkingSystemElement", interworkingSystemList);
			cache.put(interworkingSystemElement);
		}

		for (Map<String, Object> interworkingSystem : interworkingSystemList) {
			if (interworkingSystem.get("ID").equals(id)) {
				return interworkingSystem;
			}
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getInterworkingSystem(String id, String ns_id) {		
		Map<String, Object> returnData = new HashMap<String, Object>();
							
		return returnData;		
	}
	
	public String getInterworkingSystemUrl(String id) {
		Map<String, Object> interworkingSystem = this.getInterworkingSystem(id);
		String url = interworkingSystem.get("ADDRESS").toString();
		return url;
	}
	
	public String getInterworkingSystemUrl(String id, String ns_id) {
		Map<String, Object> interworkingSystem = this.getInterworkingSystem(id, ns_id);
		String url = interworkingSystem.get("ADDRESS").toString();
		return url;
	}

	/*
	 * GROUP_ID 적용
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getInterworkingSystemByGroupId(String group_id, String id) {
		
		return null;
	}
	
	public String getInterworkingSystemUrlByGroupId(String group_id, String id) {
		Map<String, Object> interworkingSystem = this.getInterworkingSystemByGroupId(group_id, id);
		String url = interworkingSystem.get("ADDRESS").toString();
		return url;
	}

}
