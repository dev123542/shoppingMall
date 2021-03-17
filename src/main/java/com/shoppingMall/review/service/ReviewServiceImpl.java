package com.shoppingMall.review.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.review.dao.ReviewDAO;
import com.shoppingMall.review.vo.ReviewVO;

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
	
	// 후기 목록
	@Override
	public List<ReviewVO> selectReview (int product_no) throws Exception{
		return reviewDAO.selectReview(product_no);
	}
	
	// 마이페이지에서 후기 목록
	@Override
	public List<ReviewVO> myReviewList (String writer) throws Exception{
		return reviewDAO.myReviewList(writer);
	}
	
	// 후기 수정
	@Override
	public void updateReview(Map<String, Object> reviewMap) throws Exception{
		reviewDAO.updateReview(reviewMap);
	}
	
	// 후기 삭제
	@Override
	public void deleteReview(ReviewVO review) throws Exception{
		reviewDAO.deleteReview(review);
	}
}
