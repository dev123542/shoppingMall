package com.shoppingMall.admin.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.shoppingMall.order.vo.OrderVO;

@Repository("adminOrderDAOImpl")
public class AdminOrderDAOImpl implements AdminOrderDAO{

	@Autowired
	private SqlSession sqlSession;
	
	// 주문 목록
	@Override
	public List<OrderVO> adminOrderList() throws DataAccessException{
		return sqlSession.selectList("adminOrderList");
	}
}
