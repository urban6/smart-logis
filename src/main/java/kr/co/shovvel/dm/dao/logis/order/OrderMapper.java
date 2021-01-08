package kr.co.shovvel.dm.dao.logis.order;

import kr.co.shovvel.dm.domain.logis.order.LogisDTO;
import kr.co.shovvel.dm.domain.logis.order.OrderDTO;
import kr.co.shovvel.dm.domain.logis.order.WarehouseDTO;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface OrderMapper {
		
	// 주문 내역 조회
	List<OrderDTO> getOrderList(OrderDTO orderDTO) throws Exception;
	
	// 주문 상세 내역 조회
	OrderDTO getOrderDetail(OrderDTO orderDTO) throws Exception;
	
	// 창고 신청 내역 조회
	List<WarehouseDTO> getWarehouseList(WarehouseDTO warehouseDTO) throws Exception;
	
	// 창고 신청 상세 내역 조회
	WarehouseDTO getWarehouseDetail(WarehouseDTO warehouseDTO) throws Exception;
	
	// 물류 신청 내역 조회
	List<LogisDTO> getLogisList(LogisDTO logisDTO) throws Exception;
	
	// 물류 신청 상세 내역 조회
	LogisDTO getLogisDetail(LogisDTO logisDTO) throws Exception;

}
