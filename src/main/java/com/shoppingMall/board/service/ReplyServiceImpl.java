package com.shoppingMall.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.board.dao.ReplyDAO;
import com.shoppingMall.board.vo.QnaVO;
import com.shoppingMall.board.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyDAO replydao;
	
	//댓글 조회
	public List<ReplyVO> readReply(int bno) throws Exception {
		return replydao.readReply(bno);
	}

	//댓글 작성
	public void writeReply(ReplyVO replyvo) throws Exception {
		replydao.writeReply(replyvo);
		
	}

	//댓글 수정
	public void updateReply(ReplyVO replyvo) throws Exception {
		replydao.updateReply(replyvo);
	}

	//댓글 삭제
	public void deleteReply(ReplyVO replyvo) throws Exception {
		replydao.deleteReply(replyvo);
	}

	//선택한 댓글 조회
	public ReplyVO selectReply(int rno) throws Exception {
		return replydao.selectReply(rno);
	}
}
