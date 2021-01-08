package kr.co.shovvel.dm.controller.management.map;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.shovvel.dm.domain.management.login.LoginDomain;
import kr.co.shovvel.dm.domain.management.map.LctDomain;
import kr.co.shovvel.dm.domain.management.map.LctVO;
import kr.co.shovvel.dm.service.management.map.MapService;

@Controller
@RequestMapping(value ="/management/map")
public class MapController {
	private Logger logger =Logger.getLogger(this.getClass());
	
	private String thisUrl = "management/map";
	
	@Autowired
	private MapService mapService;
	
	@RequestMapping(value = "map")
	public String opneMap(HttpServletRequest request) {
		return thisUrl + "/map";
	}
	
	/*
	  @RequestMapping(value = "location")
	  public void getLocation(HttpServletRequest request, Model model) { 
	  
		  LctVO lct = mapService.getLocation(1); 
		  double x = 0; 
		  double y = 0;
	  
		  try { 
			  x = lct.getLct_x_posi(); y = lct.getLct_y_posi();
	  
			  logger.debug("X location : "+x); 
			  logger.debug("Y location : "+y); 
		  } catch(Exception e) 
		  { // TODO: handle exception }
	  
		  model.addAttribute("x", x); model.addAttribute("y", y); }
	  }
	  */
	
	@RequestMapping(value ="test")
	public void testMap(HttpServletRequest request, Model model) {
		
		LctDomain testNum = new LctDomain();
		testNum=mapService.getLocation();
		
		try {
			//model.addAttribute("x", testNum.getLct_x_posi());
			logger.debug("X location : "+testNum.getX());
			logger.debug("Y location : "+testNum.getY());
		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		 
	}
	@RequestMapping(value ="test2")
	public void testLogin(HttpServletRequest request) {
		LoginDomain ld = new LoginDomain();
		ld=mapService.getLoginTest();
		
		try {
			logger.debug("@@@@@@@@@@@@  "+ld.getLockType());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
