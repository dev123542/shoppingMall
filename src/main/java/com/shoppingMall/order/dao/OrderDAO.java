package com.shoppingMall.order.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.shoppingMall.cart.vo.CartVO;
import com.shoppingMall.order.vo.OrderDetailsVO;
import com.shoppingMall.order.vo.OrderListVO;
import com.shoppingMall.order.vo.OrderVO;
import com.shoppingMall.product.vo.ProductVO;

public interface OrderDAO {
	
	public void orderInfo(OrderVO orderVO) throws DataAccessException;
	public int selectOrderCount(String member_id) throws DataAccessException;
	public void orderInfoDetails(OrderDetailsVO orderDetailvo) throws DataAccessException;
	public void deleteCart(String member_id) throws DataAccessException;
	public List<OrderVO> orderComplete(String order_no) throws DataAccessException;
	public List<OrderVO> orderList(OrderVO orderVO) throws DataAccessException;
	public List<OrderListVO> orderView(OrderVO orderVO) throws DataAccessException;
	public List<CartVO> selectOrderCartList(String member_id) throws DataAccessException;
	public List<ProductVO> selectOrderProductList(List<CartVO> cartList) throws DataAccessException;
}
