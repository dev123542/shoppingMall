package com.shoppingMall.order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.cart.vo.CartVO;
import com.shoppingMall.order.controller.OrderController;
import com.shoppingMall.order.dao.OrderDAO;
import com.shoppingMall.order.vo.OrderDetailsVO;
import com.shoppingMall.order.vo.OrderListVO;
import com.shoppingMall.order.vo.OrderVO;
import com.shoppingMall.product.vo.ProductVO;

@Service("orderService")
public class OrderServiceImpl implements OrderService{

	private static final Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);
	
	@Autowired
	private OrderDAO orderDAO;
	
	// 주문 페이지에서 장바구니에 담긴 상품 목록 가져오기
	@Override
	public Map<String, List> selectOrderCartList(String member_id) throws Exception {
		Map<String,List> cartMap=new HashMap<String,List>();
		List<CartVO> myCartList=orderDAO.selectOrderCartList(member_id);
		if(myCartList.size()==0){ 
			return null;
		}
		List<ProductVO> myProductList = orderDAO.selectOrderProductList(myCartList);
		cartMap.put("myProductList", myProductList);
		cartMap.put("myCartList", myCartList);
		return cartMap;
	}
	
	// 주문 페이지에서 장바구니에 담긴 상품 개수
	@Override
	public int selectOrderCount(String member_id) throws Exception{
		return orderDAO.selectOrderCount(member_id);
	}
	
	// 주문 정보 저장
	@Override
	public void orderInfo(OrderVO orderVO) throws Exception {
		orderDAO.orderInfo(orderVO);
	}

	// 주문 상세 정보 저장
	@Override
	public void orderInfoDetails(OrderDetailsVO orderDetailvo) throws Exception {
		orderDAO.orderInfoDetails(orderDetailvo);
	}

	// 주문 후 장바구니 비우기
	@Override
	public void deleteCart(String member_id) throws Exception {
		orderDAO.deleteCart(member_id);
	}

	// 주문 완료 페이지
	@Override
	public List<OrderVO> orderComplete(String order_no) throws Exception{
		return orderDAO.orderComplete(order_no);
	}
	
	// 특정 회원의 주문 정보 조회
	@Override
	public List<OrderVO> orderList(OrderVO orderVO) throws Exception {
		return orderDAO.orderList(orderVO);
	}

	// 주문 정보와 주문 상세 정보 조회
	@Override
	public List<OrderListVO> orderView(OrderVO orderVO) throws Exception {
		return orderDAO.orderView(orderVO);
	}

}
