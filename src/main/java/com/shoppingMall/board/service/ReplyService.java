package com.shoppingMall.board.service;

import java.util.List;

import com.shoppingMall.board.vo.ReplyVO;

public interface ReplyService {
	//댓글 조회
	public List<ReplyVO> readReply(int bno) throws Exception;
	//댓글 작성
	public void writeReply(ReplyVO replyvo) throws Exception;
	//댓글 수정
	public void updateReply(ReplyVO replyvo) throws Exception;
	//댓글 삭제
	public void deleteReply(ReplyVO replyvo) throws Exception;
	//선택한 댓글 조회
	public ReplyVO selectReply(int rno) throws Exception;
}
