package kr.co.shovvel.dm.controller.logis.order;

import kr.co.shovvel.dm.domain.logis.order.LogisDTO;
import kr.co.shovvel.dm.domain.logis.order.OrderDTO;
import kr.co.shovvel.dm.domain.logis.order.WarehouseDTO;
import kr.co.shovvel.dm.service.logis.order.OrderService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	private Logger log = Logger.getLogger(this.getClass());

    @Autowired
    private OrderService orderService;
    
    /**
     * 메인 페이지 호출 
     * */
    @RequestMapping("/index")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response, 
								Model model) throws Exception {
		
    	response.setHeader("Cache-Control", "no-cache");
    	
    	log.info(this.getClass().getName() + ".index Start!");
		
    	ModelAndView mav = new ModelAndView();
    	
		log.info(this.getClass().getName() + ".index End!");
		
		mav.setViewName("logis/order/index");
		
		return mav;
		
	}
    
    /**
     * 주문 내역 조회 페이지 호출 
     * */
    @RequestMapping("/OrderSearch")
	public ModelAndView OrderSearch(HttpServletRequest request, HttpServletResponse response, 
								Model model) throws Exception {
		
    	response.setHeader("Cache-Control", "no-cache");
    	
    	log.info(this.getClass().getName() + ".OrderSearch Start!");
		
    	ModelAndView mav = new ModelAndView();
    	
		log.info(this.getClass().getName() + ".OrderSearch End!");
		
		mav.setViewName("logis/order/OrderSearch");
		
		return mav;
		
	}
    
    /**
     * 주문 내역 조회    
     * */
    @RequestMapping("/OrderList")
    public ModelAndView OrderList(HttpServletResponse response, HttpServletRequest request,
    							Model model) throws Exception {
        
    	response.setHeader("Cache-Control", "no-cache");
        
        log.info(this.getClass().getName() + ".OrderList Start!");
        
        String startDate	= (String) request.getParameter("startDate");
        String endDate		= (String) request.getParameter("endDate");
        String keyword		= (String) request.getParameter("keyword");
        
        log.info("startDate	: " + startDate);
        log.info("endDate	: " + endDate);
        log.info("keyword	: " + keyword);
        
        OrderDTO orderDTO = new OrderDTO();
        
        orderDTO.setStartDate(startDate);
        orderDTO.setEndDate(endDate);
        orderDTO.setKeyword(keyword);
        
        List<OrderDTO> orderList = orderService.getOrderList(orderDTO);
        
        if (orderList == null) {
        	
        	orderList = new ArrayList<OrderDTO>();
        	
        }
        
        log.info("getOrderList Success!");

        ModelAndView mav = new ModelAndView();
        
        mav.addObject("list", orderList);
        
        orderList	= null;
        orderDTO	= null;
        
        log.info(this.getClass().getName() + ".OrderList End!");
        
        mav.setViewName("logis/order/OrderSearch");
        
        return mav;
        
    }
    
    /**
     * 주문 상세 내역 조회 
     * */
    @RequestMapping("/OrderDetail")
    public ModelAndView OrderDetail(HttpServletResponse response, HttpServletRequest request,
    							Model model) throws Exception {
        
    	response.setHeader("Cache-Control", "no-cache");
    	    	
    	log.info(this.getClass().getName() + ".OrderDetail Start!");

        String orderUid = request.getParameter("orderUid");
        
        log.info("orderUid : " + orderUid);
        
        OrderDTO orderDto = new OrderDTO();              
        
        orderDto.setOrderUid(orderUid);

        OrderDTO orderDTO = orderService.getOrderDetail(orderDto);
        
        if (orderDTO == null) {
        	
        	orderDTO = new OrderDTO();
        	
        }
        
        log.info("getOrderDetail Success!");

        ModelAndView mav = new ModelAndView();
        
        mav.addObject("orderDTO", orderDTO);
        
        orderDTO	= null;
        orderDto	= null;	
        
        log.info(this.getClass().getName() + ".OrderDetail End!");
        
        mav.setViewName("logis/order/OrderDetail");
        
        return mav;
        
    }
    
    /**
     * 창고 신청 내역 조회 페이지 호출      
     * */
    @RequestMapping("/WarehouseSearch")
	public ModelAndView WarehouseSearch(HttpServletRequest request, HttpServletResponse response, 
										Model model) throws Exception {
		
    	response.setHeader("Cache-Control", "no-cache");
    	
    	log.info(this.getClass().getName() + ".WarehouseSearch Start!");
		
    	ModelAndView mav = new ModelAndView();
    	
		log.info(this.getClass().getName() + ".WarehouseSearch End!");
		
		mav.setViewName("logis/order/WarehouseSearch");
		
		return mav;
		
	}
    
    /**
     * 창고 신청 내역 조회    
     * */
    @RequestMapping("/WarehouseList")
    public ModelAndView WarehouseList(HttpServletResponse response, HttpServletRequest request,
    									Model model) throws Exception {
        
    	response.setHeader("Cache-Control", "no-cache");
        
        log.info(this.getClass().getName() + ".WarehouseList Start!");
        
        String startDate	= (String) request.getParameter("startDate");
        String endDate		= (String) request.getParameter("endDate");
        String keyword		= (String) request.getParameter("keyword");
        
        log.info("startDate	: " + startDate);
        log.info("endDate	: " + endDate);
        log.info("keyword	: " + keyword);
        
        WarehouseDTO warehouseDTO = new WarehouseDTO();
        
        warehouseDTO.setStartDate(startDate);
        warehouseDTO.setEndDate(endDate);
        warehouseDTO.setKeyword(keyword);
        
        List<WarehouseDTO> warehouseList = orderService.getWarehouseList(warehouseDTO);
        
        if (warehouseList == null) {
        	
        	warehouseList = new ArrayList<WarehouseDTO>();
        	
        }
        
        log.info("getWarehouseList Success!");

        ModelAndView mav = new ModelAndView();
        
        mav.addObject("list", warehouseList);
        
        warehouseList	= null;
        warehouseDTO	= null;
        
        log.info(this.getClass().getName() + ".WarehouseList End!");
        
        mav.setViewName("logis/order/WarehouseSearch");
        
        return mav;
        
    }
    
    /**
     * 창고 신청 상세 내역 조회 
     * */
    @RequestMapping("/WarehouseDetail")
    public ModelAndView WarehouseDetail(HttpServletResponse response, HttpServletRequest request,
    							Model model) throws Exception {
        
    	response.setHeader("Cache-Control", "no-cache");
    	    	
    	log.info(this.getClass().getName() + ".WarehouseDetail Start!");

        String orderInfoUid = request.getParameter("orderInfoUid");
        
        log.info("orderInfoUid : " + orderInfoUid);
        
        WarehouseDTO warehouseDto = new WarehouseDTO();              
        
        warehouseDto.setOrderInfoUid(orderInfoUid);

        WarehouseDTO warehouseDTO = orderService.getWarehouseDetail(warehouseDto);
        
        if (warehouseDTO == null) {
        	
        	warehouseDTO = new WarehouseDTO();
        	
        }
        
        log.info("getWarehouseDetail Success!");

        ModelAndView mav = new ModelAndView();
        
        mav.addObject("warehouseDTO", warehouseDTO);
        
        warehouseDTO	= null;
        warehouseDto	= null;	
        
        log.info(this.getClass().getName() + ".WarehouseDetail End!");
        
        mav.setViewName("logis/order/WarehouseDetail");
        
        return mav;
        
    }
    
    /**
     * 물류 신청 내역 조회 페이지 호출      
     * */
    @RequestMapping("/LogisSearch")
	public ModelAndView LogisSearch(HttpServletRequest request, HttpServletResponse response, 
										Model model) throws Exception {
		
    	response.setHeader("Cache-Control", "no-cache");
    	
    	log.info(this.getClass().getName() + ".LogisSearch Start!");
		
    	ModelAndView mav = new ModelAndView();
    	
		log.info(this.getClass().getName() + ".LogisSearch End!");
		
		mav.setViewName("logis/order/LogisSearch");
		
		return mav;
		
	}
    
    /**
     * 물류 신청 내역 조회    
     * */
    @RequestMapping("/LogisList")
    public ModelAndView LogisList(HttpServletResponse response, HttpServletRequest request,
    									Model model) throws Exception {
        
    	response.setHeader("Cache-Control", "no-cache");
        
        log.info(this.getClass().getName() + ".LogisList Start!");
        
        String startDate	= (String) request.getParameter("startDate");
        String endDate		= (String) request.getParameter("endDate");
        String keyword		= (String) request.getParameter("keyword");
        
        log.info("startDate	: " + startDate);
        log.info("endDate	: " + endDate);
        log.info("keyword	: " + keyword);
        
        LogisDTO logisDTO = new LogisDTO();
        
        logisDTO.setStartDate(startDate);
        logisDTO.setEndDate(endDate);
        logisDTO.setKeyword(keyword);
        
        List<LogisDTO> logisList = orderService.getLogisList(logisDTO);
        
        if (logisList == null) {
        	
        	logisList = new ArrayList<LogisDTO>();
        	
        }
        
        log.info("getLogisList Success!");

        ModelAndView mav = new ModelAndView();
        
        mav.addObject("list", logisList);
        
        logisList	= null;
        logisDTO	= null;
        
        log.info(this.getClass().getName() + ".LogisList End!");
        
        mav.setViewName("logis/order/LogisSearch");
        
        return mav;
        
    }
    
    /**
     * 물류 신청 상세 내역 조회 
     * */
    @RequestMapping("/LogisDetail")
    public ModelAndView LogisDetail(HttpServletResponse response, HttpServletRequest request,
    							Model model) throws Exception {
        
    	response.setHeader("Cache-Control", "no-cache");
    	    	
    	log.info(this.getClass().getName() + ".LogisDetail Start!");

        String logisOrderUid = request.getParameter("logisOrderUid");
        
        log.info("logisOrderUid : " + logisOrderUid);
        
        LogisDTO logisDto = new LogisDTO();              
        
        logisDto.setLogisOrderUid(logisOrderUid);

        LogisDTO logisDTO = orderService.getLogisDetail(logisDto);
        
        if (logisDTO == null) {
        	
        	logisDTO = new LogisDTO();
        	
        }
        
        log.info("getLogisDetail Success!");

        ModelAndView mav = new ModelAndView();
        
        mav.addObject("logisDTO", logisDTO);
        
        logisDTO	= null;
        logisDto	= null;	
        
        log.info(this.getClass().getName() + ".LogisDetail End!");
        
        mav.setViewName("logis/order/LogisDetail");
        
        return mav;
        
    }

}
