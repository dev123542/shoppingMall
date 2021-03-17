package com.shoppingMall.review.service;

import java.util.List;
import java.util.Map;

import com.shoppingMall.review.vo.ReviewVO;

public interface ReviewService {
	
	public void writerReview(Map<String, Object> reviewMap) throws Exception;
	public List<ReviewVO> selectReview (int product_no) throws Exception;
	public List<ReviewVO> myReviewList (String writer) throws Exception;
	public void updateReview(Map<String, Object> reviewMap) throws Exception;
	void deleteReview(ReviewVO review) throws Exception;

}
