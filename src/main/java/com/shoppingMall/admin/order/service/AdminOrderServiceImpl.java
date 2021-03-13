package com.shoppingMall.admin.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.admin.order.dao.AdminOrderDAO;
import com.shoppingMall.order.vo.OrderVO;

@Service("adminOrderServiceImpl")
public class AdminOrderServiceImpl implements AdminOrderService{

	@Autowired
	private AdminOrderDAO adminOrderDAO;
	
	// 주문 목록
	@Override
	public List<OrderVO> adminOrderList() throws Exception{
		return adminOrderDAO.adminOrderList();
	}
}
