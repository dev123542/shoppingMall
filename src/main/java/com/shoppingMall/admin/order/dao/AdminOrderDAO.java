package com.shoppingMall.admin.order.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.shoppingMall.order.vo.OrderVO;

public interface AdminOrderDAO {
	
	public List<OrderVO> adminOrderList() throws DataAccessException;

}
