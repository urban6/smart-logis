package kr.co.shovvel.dm.service.logis.order;

import kr.co.shovvel.dm.dao.logis.order.OrderMapper;
import kr.co.shovvel.dm.domain.logis.order.LogisDTO;
import kr.co.shovvel.dm.domain.logis.order.OrderDTO;
import kr.co.shovvel.dm.domain.logis.order.WarehouseDTO;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
	
	private Logger log = Logger.getLogger(this.getClass());
		
    @Autowired
    private OrderMapper orderMapper;
    
    /**
     * 주문 내역 조회     
     * */
	public List<OrderDTO> getOrderList(OrderDTO orderDTO) throws Exception {
		
		log.info(this.getClass().getName() + ".getOrderList Start!");
		
		log.info(this.getClass().getName() + ".getOrderList End!");
		
		return orderMapper.getOrderList(orderDTO);
		
		
	}
	
	/**
     * 주문 상세 내역 조회     
     * */
	public OrderDTO getOrderDetail(OrderDTO orderDTO) throws Exception {
		
		log.info(this.getClass().getName() + ".getOrderDetail Start!");
		
		log.info(this.getClass().getName() + ".getOrderDetail End!");
		
        return orderMapper.getOrderDetail(orderDTO);
        
    }
	
	/**
     * 창고 신청 내역 조회     
     * */
	public List<WarehouseDTO> getWarehouseList(WarehouseDTO warehouseDTO) throws Exception {
		
		log.info(this.getClass().getName() + ".getWarehouseList Start!");
		
		log.info(this.getClass().getName() + ".getWarehouseList End!");
		
		return orderMapper.getWarehouseList(warehouseDTO);
		
		
	}
	
	/**
     * 창고 신청 상세 내역 조회     
     * */
	public WarehouseDTO getWarehouseDetail(WarehouseDTO warehouseDTO) throws Exception {
		
		log.info(this.getClass().getName() + ".getWarehouseDetail Start!");
		
		log.info(this.getClass().getName() + ".getWarehouseDetail End!");
		
        return orderMapper.getWarehouseDetail(warehouseDTO);
        
    }
	
	/**
     * 물류 신청 내역 조회     
     * */
	public List<LogisDTO> getLogisList(LogisDTO logisDTO) throws Exception {
		
		log.info(this.getClass().getName() + ".getLogisList Start!");
		
		log.info(this.getClass().getName() + ".getLogisList End!");
		
		return orderMapper.getLogisList(logisDTO);
		
		
	}
	
	/**
     * 물류 신청 상세 내역 조회     
     * */
	public LogisDTO getLogisDetail(LogisDTO logisDTO) throws Exception {
		
		log.info(this.getClass().getName() + ".getLogisDetail Start!");
		
		log.info(this.getClass().getName() + ".getLogisDetail End!");
		
        return orderMapper.getLogisDetail(logisDTO);
        
    }

}
