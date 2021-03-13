package com.shoppingMall.order.service;



import java.util.List;
import java.util.Map;

import com.shoppingMall.cart.vo.CartVO;
import com.shoppingMall.order.vo.OrderDetailsVO;
import com.shoppingMall.order.vo.OrderListVO;
import com.shoppingMall.order.vo.OrderVO;

public interface OrderService {
	
	public void orderInfo(OrderVO orderVO) throws Exception;
	public int selectOrderCount(String member_id) throws Exception;
	public void orderInfoDetails(OrderDetailsVO orderDetailvo) throws Exception;
	public void deleteCart(String member_id) throws Exception;
	public List<OrderVO> orderComplete(String order_no) throws Exception;
	public List<OrderVO> orderList(OrderVO orderVO) throws Exception;
	public List<OrderListVO> orderView(OrderVO orderVO) throws Exception;
	public Map<String, List> selectOrderCartList(String member_id) throws Exception;

}
