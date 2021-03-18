package com.shoppingMall.review.service;

import java.util.List;
import java.util.Map;

import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.review.vo.ReviewVO;

public interface ReviewService {
	
	public void writerReview(Map<String, Object> reviewMap) throws Exception;
	public List<ReviewVO> selectReview (int product_no, CriteriaVO cri) throws Exception;
	public int reviewListCount(int product_no) throws Exception;
//	public List<ReviewVO> selectReview (int product_no) throws Exception;
	public List<ReviewVO> myReviewList (Map<String, Object> param) throws Exception;
//	public List<ReviewVO> myReviewList (String writer) throws Exception;
	public int myReviewCount(String writer) throws Exception;
	public ReviewVO updateBtn(int review_no) throws Exception;
	public void updateReview(Map<String, Object> reviewMap) throws Exception;
	void deleteReview(ReviewVO review) throws Exception;

}
