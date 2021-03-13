package com.shoppingMall.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.shoppingMall.cart.vo.CartVO;
import com.shoppingMall.order.vo.OrderDetailsVO;
import com.shoppingMall.order.vo.OrderListVO;
import com.shoppingMall.order.vo.OrderVO;
import com.shoppingMall.product.vo.ProductVO;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	// 주문 페이지에 장바구니에 담긴 상품 목록 가져오기
	@Override
	public List<CartVO> selectOrderCartList(String member_id) throws DataAccessException{
		return sqlSession.selectList("selectOrderCartList", member_id);
	}
	
	// 주문 페이지에서 장바구니에 담긴 상품 목록 개수
	@Override
	public int selectOrderCount(String member_id) throws DataAccessException{
		return sqlSession.selectOne("selectOrderCount", member_id);
	}
	
	// 주문 페이지에 장바구니에 담긴 상품 목록 가져오기 - 상품 이미지
	@Override
	public List<ProductVO> selectOrderProductList(List<CartVO> cartList) throws DataAccessException{
		return sqlSession.selectList("selectOrderProductList", cartList);
	}
	
	// 주문 정보 저장
	@Override
	public void orderInfo(OrderVO orderVO) throws DataAccessException{
		sqlSession.insert("orderInfo", orderVO);
	}
	
	// 주문 상세 정보 저장
	@Override
	public void orderInfoDetails(OrderDetailsVO orderDetailvo) throws DataAccessException{
		sqlSession.insert("orderInfoDetails", orderDetailvo);
	}
	
	// 주문 후 장바구니 비우기
	@Override
	public void deleteCart(String member_id) throws DataAccessException{
		sqlSession.delete("deleteCart", member_id);
	}
	
	// 주문 완료 페이지
	@Override
	public List<OrderVO> orderComplete(String order_no) throws DataAccessException{
		return sqlSession.selectList("orderComplete", order_no);
	}
	
	// 특정 회원의 주문 정보 조회
	@Override
	public List<OrderVO> orderList(OrderVO orderVO) throws DataAccessException{
		return sqlSession.selectList("orderList", orderVO);
	}
	
	// 주문 정보와 주문 상세 정보 조회
	@Override
	public List<OrderListVO> orderView(OrderVO orderVO) throws DataAccessException{
		return sqlSession.selectList("orderView", orderVO);
	}
}
