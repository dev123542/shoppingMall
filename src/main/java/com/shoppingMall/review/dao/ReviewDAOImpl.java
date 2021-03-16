package com.shoppingMall.review.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.shoppingMall.review.vo.ReviewVO;

@Repository("reviewDAO")
public class ReviewDAOImpl implements ReviewDAO{

	private static final Logger logger = LoggerFactory.getLogger(ReviewDAOImpl.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	// 후기 작성
	@Override
	public void writerReview(Map<String, Object> reviewMap) throws DataAccessException{
		sqlSession.insert("writerReview", reviewMap);
	}
	
	// 후기 목록
	@Override
	public List<ReviewVO> selectReview (int product_no) throws DataAccessException{
		return sqlSession.selectList("selectReview", product_no);
	}
}
