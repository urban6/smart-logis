package kr.co.shovvel.dm.controller.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;

import kr.co.shovvel.dm.domain.common.ResponseCommon;
import kr.co.shovvel.dm.service.common.RestfulService;

@Controller
@RequestMapping(value = "/restful")
public class RestfulController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	/*@Value("#{configuration['restfulRelayServerURL']}")
	private String restfulRelayServerURL;*/
	
	@Autowired
	private RestfulService restfulService;

	@RequestMapping(value = "test")
	public @ResponseBody String test(HttpServletResponse response) {
		JsonObject ret = new JsonObject();
		ret.addProperty("name", "test");
		ret.addProperty("description", "Restful localhost.");
		response.setHeader("X-Auth-Token", "testHeaderValue");
		return ret.toString();
	}
	
	@RequestMapping(value = "relayTest")
	public @ResponseBody String relayTest(HttpServletResponse response) {
		try {
			JsonObject jsonParam = new JsonObject();
	    	jsonParam.addProperty("testKey", "testValue");
			return restfulService.restfulRequest(response, "http://127.0.0.1:8080/restful/test", "POST", jsonParam);
		} catch (Exception ex) {
			return ex.getMessage();
		}
	}
	
	// /restful/relay?url=http://127.0.0.1:8080/restful/test
	/*@RequestMapping(value = "relay")
	public @ResponseBody String relay(HttpServletRequest request, HttpServletResponse response, @RequestParam("url") String sUrl, @RequestParam("requestMethod") String sRequestMethod) {
		try {
			return restfulService.restfulRelayRequest(request, response, sUrl, sRequestMethod);
		} catch (Exception ex) {
			return ex.getMessage();
		}
	}*/
	
	@RequestMapping(value = "authTokens")
	public @ResponseBody String authTokens() {
    	String token = "";
    	String id = "shovvel";
    	String password = "shovvel1234";
    	
    	CloseableHttpClient client = HttpClients.createDefault();
    	try{
	    	HttpPost post = new HttpPost("http://125.129.139.197:8000/v2/auth/tokens");
	    	StringEntity parameters = new StringEntity("{\"auth\":{\"identity\":{\"user\":{\"id\":\""+id+"\",\"password\":\""+password+"\"}}}}");
	    	
	    	parameters.setContentType("application/json");
	    	post.setEntity(parameters);
	    	
	    	logger.debug("[parameters data] :: "+parameters);
	    	
	    	HttpResponse response = client.execute(post);
	    	
	    	logger.debug("X-Subject-Token(getFirstHeader) :: "+response.getFirstHeader("X-Subject-Token"));
	    	logger.debug("X-Subject-Token(getEntity()) :: "+response.getEntity());
	    	logger.debug("X-Auth-Token(getFirstHeader) :: "+response.getFirstHeader("X-Auth-Token"));
	    	logger.debug("============================================================================== ");
	    	token = response.getFirstHeader("X-Auth-Token").getValue();
        } catch (Exception e){
    		e.printStackTrace();
    	} finally {
    		try {client.close();} catch (Exception ex) {}
    	}
        return token;
    }
	
	@RequestMapping(value = "apiTest", method = {RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Object apiTest(
			HttpServletRequest request,
			HttpServletResponse response) {
		
		//return referencesDomain;
		ResponseCommon responseCommon = new ResponseCommon();
		responseCommon.setResult("OK");
		responseCommon.setMessage("TEST!");
		return responseCommon;
		
		
	}
}
