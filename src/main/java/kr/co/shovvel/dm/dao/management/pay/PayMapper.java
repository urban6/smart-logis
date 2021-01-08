package kr.co.shovvel.dm.dao.management.pay;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.pay.SellerApprovalVO;
import kr.co.shovvel.dm.domain.management.pay.SellerInfoVO;
import kr.co.shovvel.dm.domain.management.pay.SellerProductInfoVO;
import kr.co.shovvel.dm.domain.management.pay.SellerProductOrderVO;

@Component
public interface PayMapper {
	
		SellerInfoVO getSellerInfo(int sellerUid);
		
		ArrayList<SellerProductInfoVO> getProductInfo(String cpId);
		
		Map<String, Object> getProductInfo_Selected(String productUid);
		
		int setUserOrder(SellerProductOrderVO userOrder);
		
		Map<String, Object> getOrderInfo(String sellerKey);
		
		ArrayList<Map<String, Object>> getOrderTotalPrice(String sellerOrderReferenceKey);
		
		int updateUserOrder(SellerProductOrderVO userOrder);
		
		int setOrderApproval(SellerApprovalVO orderApproval);
		
		int setOrder(SellerApprovalVO orderApproval);
		
		Map<String, Object> getOrderProductPrice(@Param("orderNo")String orderNo, @Param("sellerOrderProductReferenceKey")String sellerOrderProductReferenceKey );
		
		int updateCancel(SellerApprovalVO orderApproval);

		String searchSellerKey(@Param(value = "productUid") int productUid);

		int searchLogisPrice(@Param(value = "productUid") int productUid);
		
		void updateOrderCode(@Param("code")String code, @Param("userUid")String userUid );
		
		void updateApprovalCode(@Param("approvalCode")String approvalCode, @Param("sellerOrderReferenceKey")String sellerOrderReferenceKey );
		
		SellerApprovalVO getArrovalDetail(String userUid);
}
