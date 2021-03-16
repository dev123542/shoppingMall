package com.shoppingMall.review.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.shoppingMall.review.vo.ReviewVO;

public interface ReviewDAO {
	
	public void writerReview(Map<String, Object> reviewMap) throws DataAccessException;
	public List<ReviewVO> selectReview (int product_no) throws DataAccessException;

}
