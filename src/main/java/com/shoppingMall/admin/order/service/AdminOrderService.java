package com.shoppingMall.admin.order.service;

import java.util.List;

import com.shoppingMall.order.vo.OrderVO;

public interface AdminOrderService {
	
	public List<OrderVO> adminOrderList() throws Exception;
}
