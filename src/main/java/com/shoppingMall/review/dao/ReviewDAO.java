package com.shoppingMall.review.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.shoppingMall.review.vo.ReviewVO;

public interface ReviewDAO {
	
	public void writerReview(Map<String, Object> reviewMap) throws DataAccessException;
	public List<ReviewVO> selectReview (Map<String, Object> paramMap) throws DataAccessException;
//	public List<ReviewVO> selectReview (int product_no) throws DataAccessException;
	public int reviewListCount(int product_no) throws DataAccessException;
	public List<ReviewVO> myReviewList (Map<String, Object> param) throws DataAccessException;
//	public List<ReviewVO> myReviewList (String writer) throws DataAccessException;
	public int myReviewCount(String writer) throws DataAccessException;
	public ReviewVO updateBtn(int review_no) throws DataAccessException;
	public void updateReview(Map<String, Object> reviewMap) throws DataAccessException;
	public void deleteReview(ReviewVO review) throws DataAccessException;
}
