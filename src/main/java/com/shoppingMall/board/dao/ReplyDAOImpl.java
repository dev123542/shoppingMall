package com.shoppingMall.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shoppingMall.board.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	//댓글 조회
	public List<ReplyVO> readReply(int bno) throws Exception {
		return sqlSession.selectList("readReply", bno);
	}

	//댓글 작성
	public void writeReply(ReplyVO replyvo) throws Exception {
		sqlSession.insert("writeReply", replyvo);
	}

	//댓글 수정
	public void updateReply(ReplyVO replyvo) throws Exception {
		sqlSession.update("updateReply", replyvo);
	}

	//댓글 삭제
	public void deleteReply(ReplyVO replyvo) throws Exception {
		sqlSession.delete("deleteReply", replyvo);
	}

	//선택한 댓글 조회
	public ReplyVO selectReply(int rno) throws Exception {
		return sqlSession.selectOne("selectReply", rno);
	}

}
