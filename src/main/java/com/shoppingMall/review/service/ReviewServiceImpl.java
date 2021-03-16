package com.shoppingMall.review.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.review.dao.ReviewDAO;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService{

	private static final Logger logger = LoggerFactory.getLogger(ReviewServiceImpl.class);
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	// 후기 작성
	@Override
	public void writerReview(Map<String, Object> reviewMap) throws Exception{
		reviewDAO.writerReview(reviewMap);
	}
}
