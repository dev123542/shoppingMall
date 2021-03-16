package com.shoppingMall.review.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface ReviewDAO {
	
	public void writerReview(Map<String, Object> reviewMap) throws DataAccessException;

}
