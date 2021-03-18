package com.shoppingMall.review.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.board.vo.CriteriaVO;
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
	
	// 후기 목록 - 상품번호와 페이징 파라미터 map
	@Override
	public List<ReviewVO> selectReview (int product_no, CriteriaVO cri) throws Exception{
		logger.info("후기 상품 번호:"+product_no+"/rowStart:"+cri.getRowStart()+"/rowEnd:"+cri.getRowEnd());
		int rowStart = cri.getRowStart();
		int rowEnd = cri.getRowEnd();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("product_no", product_no);
		paramMap.put("rowStart", rowStart);
		paramMap.put("rowEnd", rowEnd);
		return reviewDAO.selectReview(paramMap);
	}
//	public List<ReviewVO> selectReview (int product_no) throws Exception{
//		return reviewDAO.selectReview(product_no);
//	}
	
	// 후기 목록 개수
	@Override
	public int reviewListCount(int product_no) throws Exception{
		return reviewDAO.reviewListCount(product_no);
	}
	
	// 마이페이지에서 후기 목록
	@Override
	public List<ReviewVO> myReviewList (Map<String, Object> param) throws Exception{
		return reviewDAO.myReviewList(param);
	}
//	public List<ReviewVO> myReviewList (String writer) throws Exception{
//		return reviewDAO.myReviewList(writer);
//	}
	
	// 마이페이지 후기 목록 개수
	@Override
	public int myReviewCount(String writer) throws Exception{
		return reviewDAO.myReviewCount(writer);
	}
	
	// 마이페이지에서 후기 수정창
	@Override
	public ReviewVO updateBtn(int review_no) throws Exception{
		return reviewDAO.updateBtn(review_no);
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
