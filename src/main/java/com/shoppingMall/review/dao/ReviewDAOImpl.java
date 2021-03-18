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
	public List<ReviewVO> selectReview (Map<String, Object> paramMap)throws DataAccessException{
		return sqlSession.selectList("selectReview", paramMap);
	}
//	public List<ReviewVO> selectReview (int product_no) throws DataAccessException{
//		return sqlSession.selectList("selectReview", product_no);
//	}
	
	// 후기 목록 총 개수
	@Override
	public int reviewListCount(int product_no) throws DataAccessException{
		return sqlSession.selectOne("reviewListCount", product_no);
	}
	
	// 마이페이지에서 후기 목록
	@Override
	public List<ReviewVO> myReviewList (Map<String, Object> param) throws DataAccessException{
		return sqlSession.selectList("myReviewList", param);
	}
//	public List<ReviewVO> myReviewList (String writer) throws DataAccessException{
//		return sqlSession.selectList("myReviewList", writer);
//	}
	
	// 마이페이지 후기 목록 개수
	@Override
	public int myReviewCount(String writer) throws DataAccessException{
		return sqlSession.selectOne("myReviewCount", writer);
	}
	
	// 마이페이지 후기 수정창
	@Override
	public ReviewVO updateBtn(int review_no) throws DataAccessException{
		return sqlSession.selectOne("updateBtn", review_no);
	}
	
	// 후기 수정
	@Override
	public void updateReview(Map<String, Object> reviewMap) throws DataAccessException{
		sqlSession.update("updateReview", reviewMap);
	}
	
	// 후기 삭제
	@Override
	public void deleteReview(ReviewVO review) throws DataAccessException{
		sqlSession.delete("deleteReview", review);
	}
}
